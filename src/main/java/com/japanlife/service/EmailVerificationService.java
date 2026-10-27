package com.japanlife.service;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.HexFormat;
import java.util.Locale;

import org.springframework.beans.factory.ObjectProvider;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.japanlife.dto.EmailVerification;
import com.japanlife.mapper.MemberMapper;

@Service
public class EmailVerificationService {
    private static final String EMAIL_PATTERN = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
    private final MemberMapper members;
    private final ObjectProvider<JavaMailSender> mailSenders;
    private final AsyncMailService asyncMailService;
    private final SecureRandom random = new SecureRandom();
    private final int expiryMinutes;
    private final int resendCooldownSeconds;
    private final String from;

    public EmailVerificationService(MemberMapper members, ObjectProvider<JavaMailSender> mailSenders,
            AsyncMailService asyncMailService,
            @Value("${app.mail.verification-expiry-minutes:10}") int expiryMinutes,
            @Value("${app.mail.resend-cooldown-seconds:60}") int resendCooldownSeconds,
            @Value("${app.mail.from:}") String from) {
        this.members = members;
        this.mailSenders = mailSenders;
        this.asyncMailService = asyncMailService;
        this.expiryMinutes = expiryMinutes;
        this.resendCooldownSeconds = resendCooldownSeconds;
        this.from = from;
    }

    public static boolean isValidEmail(String email) {
        return email != null && email.length() <= 254 && email.matches(EMAIL_PATTERN);
    }

    public String normalize(String email) {
        return email == null ? "" : email.strip().toLowerCase(Locale.ROOT);
    }

    @Transactional
    public synchronized void sendCode(String rawEmail) {
        sendCode(rawEmail, false);
    }

    @Transactional
    public synchronized boolean sendRecoveryCode(String rawEmail) {
        return sendCode(rawEmail, true);
    }

    private boolean sendCode(String rawEmail, boolean existingMemberAllowed) {
        String email = normalize(rawEmail);
        if (!isValidEmail(email)) throw new IllegalArgumentException("invalid email");
        if (!existingMemberAllowed && members.findByEmail(email) != null) throw new IllegalStateException("duplicate email");
        if (existingMemberAllowed && members.findByEmail(email) == null) return false;
        EmailVerification latest = members.findLatestEmailVerification(email);
        LocalDateTime now = LocalDateTime.now();
        if (latest != null && latest.getSentAt() != null
                && !latest.getSentAt().plusSeconds(resendCooldownSeconds).isBefore(now)) {
            throw new IllegalStateException("resend cooldown");
        }
        String code = String.format("%06d", random.nextInt(1_000_000));
        EmailVerification verification = new EmailVerification();
        verification.setEmail(email);
        verification.setCodeHash(hash(code));
        verification.setSentAt(now);
        verification.setExpiresAt(now.plusMinutes(expiryMinutes));
        members.insertEmailVerification(verification);
        JavaMailSender sender = mailSenders.getIfAvailable();
        if (sender == null || from == null || from.isBlank()) throw new IllegalStateException("mail is not configured");
        asyncMailService.sendEmail(sender, from, email, "JAPAN LIFE GUIDE email verification",
                "Your verification code is " + code + ". It expires in " + expiryMinutes + " minutes.");
        return true;
    }

    @Transactional
    public boolean verify(String rawEmail, String code) {
        String email = normalize(rawEmail);
        if (!isValidEmail(email) || code == null || !code.matches("\\d{6}")) return false;
        EmailVerification verification = members.findLatestEmailVerification(email);
        if (verification == null || verification.getVerifiedAt() != null || verification.getExpiresAt() == null
                || verification.getExpiresAt().isBefore(LocalDateTime.now())
                || verification.getAttemptCount() == null || verification.getAttemptCount() >= 5) return false;
        members.incrementEmailVerificationAttempts(verification.getId());
        if (!MessageDigest.isEqual(verification.getCodeHash().getBytes(StandardCharsets.UTF_8), hash(code).getBytes(StandardCharsets.UTF_8))) return false;
        return members.markEmailVerificationVerified(verification.getId(), LocalDateTime.now()) > 0;
    }

    private String hash(String value) {
        try {
            return HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(value.getBytes(StandardCharsets.UTF_8)));
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 is unavailable", e);
        }
    }
}
