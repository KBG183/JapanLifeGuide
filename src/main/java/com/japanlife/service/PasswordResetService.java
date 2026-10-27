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
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.japanlife.dto.Member;
import com.japanlife.dto.PasswordReset;
import com.japanlife.mapper.MemberMapper;

@Service
public class PasswordResetService {
    private static final String EMAIL_PATTERN = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
    private final MemberMapper members;
    private final PasswordEncoder passwordEncoder;
    private final ObjectProvider<JavaMailSender> mailSenders;
    private final AsyncMailService asyncMailService;
    private final SecureRandom random = new SecureRandom();
    private final int expiryMinutes;
    private final int resendCooldownSeconds;
    private final String from;

    public PasswordResetService(MemberMapper members, PasswordEncoder passwordEncoder,
            ObjectProvider<JavaMailSender> mailSenders,
            AsyncMailService asyncMailService,
            @Value("${app.mail.verification-expiry-minutes:10}") int expiryMinutes,
            @Value("${app.mail.resend-cooldown-seconds:60}") int resendCooldownSeconds,
            @Value("${app.mail.from:}") String from) {
        this.members = members;
        this.passwordEncoder = passwordEncoder;
        this.mailSenders = mailSenders;
        this.asyncMailService = asyncMailService;
        this.expiryMinutes = expiryMinutes;
        this.resendCooldownSeconds = resendCooldownSeconds;
        this.from = from;
    }

    public String normalizeEmail(String email) {
        return email == null ? "" : email.strip().toLowerCase(Locale.ROOT);
    }

    public static boolean isValidEmail(String email) {
        return email != null && email.length() <= 254 && email.matches(EMAIL_PATTERN);
    }

    public Member findMember(String loginId, String email) {
        String normalizedLoginId = loginId == null ? "" : loginId.strip();
        String normalizedEmail = normalizeEmail(email);
        if (!normalizedLoginId.matches("[A-Za-z0-9._-]{4,60}") || !isValidEmail(normalizedEmail)) return null;
        return members.findByLoginIdAndEmail(normalizedLoginId, normalizedEmail);
    }

    @Transactional
    public synchronized boolean sendCode(String loginId, String rawEmail) {
        String email = normalizeEmail(rawEmail);
        if (!isValidEmail(email)) throw new IllegalArgumentException("invalid email");
        Member member = findMember(loginId, email);
        if (member == null) return false;
        PasswordReset latest = members.findLatestPasswordReset(member.getId());
        LocalDateTime now = LocalDateTime.now();
        if (latest != null && latest.getSentAt() != null
                && !latest.getSentAt().plusSeconds(resendCooldownSeconds).isBefore(now)) {
            throw new IllegalStateException("resend cooldown");
        }
        String code = String.format("%06d", random.nextInt(1_000_000));
        PasswordReset reset = new PasswordReset();
        reset.setMemberId(member.getId());
        reset.setCodeHash(hash(code));
        reset.setSentAt(now);
        reset.setExpiresAt(now.plusMinutes(expiryMinutes));
        members.insertPasswordReset(reset);
        JavaMailSender sender = mailSenders.getIfAvailable();
        if (sender == null || from == null || from.isBlank()) throw new IllegalStateException("mail is not configured");
        asyncMailService.sendEmail(sender, from, email, "JAPAN LIFE GUIDE password reset",
                "Your password reset code is " + code + ". It expires in " + expiryMinutes + " minutes.");
        return true;
    }

    @Transactional
    public Long verifyCode(String loginId, String rawEmail, String code) {
        Member member = findMember(loginId, rawEmail);
        if (member == null || code == null || !code.matches("\\d{6}")) return null;
        PasswordReset reset = members.findLatestPasswordReset(member.getId());
        if (reset == null || reset.getVerifiedAt() != null || reset.getExpiresAt() == null
                || reset.getExpiresAt().isBefore(LocalDateTime.now())
                || reset.getAttemptCount() == null || reset.getAttemptCount() >= 5) return null;
        members.incrementPasswordResetAttempts(reset.getId());
        if (!MessageDigest.isEqual(reset.getCodeHash().getBytes(StandardCharsets.UTF_8), hash(code).getBytes(StandardCharsets.UTF_8))) return null;
        return members.markPasswordResetVerified(reset.getId(), LocalDateTime.now()) > 0 ? member.getId() : null;
    }

    @Transactional
    public boolean resetPassword(long memberId, String password, String passwordConfirm) {
        if (password == null || passwordConfirm == null || !password.equals(passwordConfirm)
                || password.length() < 8 || password.length() > 72) return false;
        return members.updatePasswordHash(memberId, passwordEncoder.encode(password)) > 0;
    }

    private String hash(String value) {
        try {
            return HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(value.getBytes(StandardCharsets.UTF_8)));
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 is unavailable", e);
        }
    }
}
