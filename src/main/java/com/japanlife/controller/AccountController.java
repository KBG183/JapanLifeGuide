package com.japanlife.controller;

import jakarta.validation.Valid;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.japanlife.dto.Member;
import com.japanlife.dto.form.PasswordChangeForm;
import com.japanlife.dto.form.ProfileForm;
import com.japanlife.service.MemberService;

@Controller
public class AccountController {
    private final MemberService members;

    public AccountController(MemberService members) {
        this.members = members;
    }

    @GetMapping("/account")
    public String account(Authentication authentication, Model model) {
        return showAccount(authentication, model);
    }

    @PostMapping("/account/profile")
    public String updateProfile(@Valid @ModelAttribute("profileForm") ProfileForm form,
            BindingResult bindingResult,
            Authentication authentication, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("errorKey", "account.displayNameInvalid");
            return showAccount(authentication, model);
        }
        members.updateDisplayName(currentMember(authentication).getId(), form.getDisplayName());
        return "redirect:/account?profileUpdated";
    }

    @PostMapping("/account/password")
    public String updatePassword(@Valid @ModelAttribute("passwordForm") PasswordChangeForm form,
            BindingResult bindingResult,
            Authentication authentication, Model model) {
        Member member = currentMember(authentication);
        if (!members.matchesPassword(member, form.getCurrentPassword())) {
            model.addAttribute("errorKey", "account.currentPasswordInvalid");
            return showAccount(authentication, model);
        }
        if (bindingResult.hasErrors() || !form.getPassword().equals(form.getPasswordConfirm())) {
            model.addAttribute("errorKey", "account.passwordInvalid");
            return showAccount(authentication, model);
        }
        members.updatePassword(member.getId(), form.getPassword());
        return "redirect:/account?passwordUpdated";
    }

    private Member currentMember(Authentication authentication) {
        return members.findByLoginId(authentication.getName());
    }

    private String showAccount(Authentication authentication, Model model) {
        model.addAttribute("member", currentMember(authentication));
        return "account/account";
    }
}
