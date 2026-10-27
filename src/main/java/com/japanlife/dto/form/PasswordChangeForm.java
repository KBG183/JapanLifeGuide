package com.japanlife.dto.form;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class PasswordChangeForm {
    @NotBlank(message = "account.currentPasswordInvalid")
    private String currentPassword;

    @NotBlank(message = "account.passwordInvalid")
    @Size(min = 8, max = 72, message = "account.passwordInvalid")
    private String password;

    private String passwordConfirm;

    public String getCurrentPassword() {
        return currentPassword;
    }

    public void setCurrentPassword(String currentPassword) {
        this.currentPassword = currentPassword;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }
}
