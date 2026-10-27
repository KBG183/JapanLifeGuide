package com.japanlife.controller;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.util.Map;
import com.japanlife.service.EmailVerificationService;
import com.japanlife.service.MemberService;
import com.japanlife.service.PasswordResetService;

@Controller
public class AuthController {
    private final MemberService members;
    private final EmailVerificationService emailVerification;
    private final PasswordResetService passwordReset;
    public AuthController(MemberService members, EmailVerificationService emailVerification, PasswordResetService passwordReset) {
        this.members = members; this.emailVerification = emailVerification; this.passwordReset = passwordReset;
    }
    @GetMapping("/login") public String login(@RequestParam(required = false) String returnTo, Model model) {
        model.addAttribute("loginReturnTo", returnTo == null ? "" : returnTo);
        return "auth/login";
    }
    @GetMapping("/register") public String register() { return "auth/register"; }
    @GetMapping("/forgot-password") public String forgotPassword() { return "auth/forgot-password"; }
    @GetMapping("/find-login-id") public String findLoginId() { return "auth/find-login-id"; }
    @GetMapping("/register/check-login-id")
    @ResponseBody
    public java.util.Map<String, Object> checkLoginId(@RequestParam(required = false) String loginId) {
        String normalized = loginId == null ? "" : loginId.strip();
        if (!normalized.matches("[A-Za-z0-9._-]{4,60}")) {
            return java.util.Map.of("available", false, "reason", "invalid");
        }
        return java.util.Map.of("available", members.isLoginIdAvailable(normalized));
    }
    @GetMapping("/register/check-email")
    @ResponseBody
    public Map<String, Object> checkEmail(@RequestParam(required = false) String email) {
        String normalized = emailVerification.normalize(email);
        if (!EmailVerificationService.isValidEmail(normalized)) return Map.of("available", false, "reason", "invalid");
        return Map.of("available", members.isEmailAvailable(normalized));
    }
    @PostMapping("/register/send-email-code")
    @ResponseBody
    public Map<String, Object> sendEmailCode(@RequestParam(required = false) String email) {
        try {
            emailVerification.sendCode(email);
            return Map.of("sent", true);
        } catch (IllegalArgumentException e) {
            return Map.of("sent", false, "reason", "invalid");
        } catch (IllegalStateException e) {
            String reason = e.getMessage() == null ? "error" : e.getMessage();
            if (reason.equals("duplicate email")) reason = "duplicate";
            else if (reason.equals("resend cooldown")) reason = "cooldown";
            else reason = "mail";
            return Map.of("sent", false, "reason", reason);
        }
    }
    @PostMapping("/register/verify-email-code")
    @ResponseBody
    public Map<String, Object> verifyEmailCode(@RequestParam(required = false) String email,
            @RequestParam(required = false) String code, HttpSession session) {
        String normalized = emailVerification.normalize(email);
        if (emailVerification.verify(normalized, code)) {
            session.setAttribute("verifiedRegistrationEmail", normalized);
            return Map.of("verified", true);
        }
        return Map.of("verified", false);
    }
    @PostMapping("/forgot-password/send-code")
    @ResponseBody
    public Map<String, Object> sendPasswordResetCode(@RequestParam(required = false) String loginId,
            @RequestParam(required = false) String email) {
        try {
            String normalizedEmail = passwordReset.normalizeEmail(email);
            if (!PasswordResetService.isValidEmail(normalizedEmail)) return Map.of("sent", false, "reason", "invalid");
            passwordReset.sendCode(loginId, normalizedEmail);
            return Map.of("sent", true);
        } catch (IllegalStateException e) {
            return Map.of("sent", false, "reason", "resend cooldown".equals(e.getMessage()) ? "cooldown" : "mail");
        } catch (IllegalArgumentException e) {
            return Map.of("sent", false, "reason", "invalid");
        }
    }
    @PostMapping("/forgot-password/verify-code")
    @ResponseBody
    public Map<String, Object> verifyPasswordResetCode(@RequestParam(required = false) String loginId,
            @RequestParam(required = false) String email, @RequestParam(required = false) String code,
            HttpSession session) {
        Long memberId = passwordReset.verifyCode(loginId, email, code);
        if (memberId != null) {
            session.setAttribute("verifiedPasswordResetMemberId", memberId);
            return Map.of("verified", true);
        }
        return Map.of("verified", false);
    }
    @PostMapping("/find-login-id/send-code")
    @ResponseBody
    public Map<String, Object> sendFindLoginIdCode(@RequestParam(required = false) String email) {
        try {
            String normalized = emailVerification.normalize(email);
            if (!EmailVerificationService.isValidEmail(normalized)) return Map.of("sent", false, "reason", "invalid");
            emailVerification.sendRecoveryCode(normalized);
            return Map.of("sent", true);
        } catch (IllegalStateException e) {
            return Map.of("sent", false, "reason", "resend cooldown".equals(e.getMessage()) ? "cooldown" : "mail");
        } catch (IllegalArgumentException e) {
            return Map.of("sent", false, "reason", "invalid");
        }
    }
    @PostMapping("/find-login-id/verify-code")
    @ResponseBody
    public Map<String, Object> verifyFindLoginIdCode(@RequestParam(required = false) String email,
            @RequestParam(required = false) String code) {
        String normalized = emailVerification.normalize(email);
        if (!emailVerification.verify(normalized, code)) return Map.of("verified", false);
        com.japanlife.dto.Member member = members.findByEmail(normalized);
        return member == null ? Map.of("verified", false) : Map.of("verified", true, "loginId", member.getLoginId());
    }
    @PostMapping("/forgot-password/reset")
    public String resetPassword(@RequestParam String loginId, @RequestParam String email,
            @RequestParam String password, @RequestParam String passwordConfirm,
            HttpSession session, Model model) {
        Object verifiedId = session.getAttribute("verifiedPasswordResetMemberId");
        if (verifiedId == null) {
            model.addAttribute("errorKey", "auth.passwordReset.verificationRequired");
            return "auth/forgot-password";
        }
        com.japanlife.dto.Member member = passwordReset.findMember(loginId, email);
        if (member == null || !verifiedId.toString().equals(String.valueOf(member.getId()))) {
            model.addAttribute("errorKey", "auth.passwordReset.verificationRequired");
            return "auth/forgot-password";
        }
        if (!passwordReset.resetPassword(member.getId(), password, passwordConfirm)) {
            model.addAttribute("errorKey", "auth.passwordReset.passwordInvalid");
            return "auth/forgot-password";
        }
        session.invalidate();
        return "redirect:/login?passwordReset";
    }
    @PostMapping("/register")
    public String register(@RequestParam String loginId, @RequestParam String email, @RequestParam String displayName, @RequestParam String password, @RequestParam String passwordConfirm, @RequestParam(defaultValue = "false") boolean loginIdChecked, HttpSession session, Model model) {
        loginId = loginId == null ? "" : loginId.strip(); displayName = displayName == null ? "" : displayName.strip();
        email = emailVerification.normalize(email);
        model.addAttribute("loginId", loginId);
        model.addAttribute("email", email);
        model.addAttribute("displayName", displayName);
        model.addAttribute("loginIdChecked", loginIdChecked);
        model.addAttribute("emailVerified", email.equals(session.getAttribute("verifiedRegistrationEmail")));
        if (!loginIdChecked) {
            model.addAttribute("errorKey", "auth.register.loginIdCheckRequired"); return "auth/register";
        }
        if (!EmailVerificationService.isValidEmail(email) || !email.equals(session.getAttribute("verifiedRegistrationEmail"))) {
            model.addAttribute("errorKey", "auth.register.emailVerificationRequired"); return "auth/register";
        }
        if (!password.equals(passwordConfirm)) {
            model.addAttribute("errorKey", "auth.register.passwordMismatch");
            model.addAttribute("focusField", "passwordConfirm");
            return "auth/register";
        }
        if (!loginId.matches("[A-Za-z0-9._-]{4,60}") || displayName.isBlank() || displayName.length() > 100 || password.length() < 8 || password.length() > 72) {
            model.addAttribute("errorKey", "auth.register.validationError"); return "auth/register";
        }
        if (!members.isLoginIdAvailable(loginId)) {
            model.addAttribute("errorKey", "auth.register.duplicateError"); return "auth/register";
        }
        try { members.register(loginId, password, displayName, email); session.removeAttribute("verifiedRegistrationEmail"); } catch (DataIntegrityViolationException e) { model.addAttribute("errorKey", "auth.register.duplicateError"); return "auth/register"; }
        return "redirect:/login?registered";
    }
}
