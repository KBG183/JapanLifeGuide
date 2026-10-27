package com.japanlife.dto.form;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class ProfileForm {
    @NotBlank(message = "account.displayNameInvalid")
    @Size(max = 100, message = "account.displayNameInvalid")
    private String displayName;

    public String getDisplayName() {
        return displayName != null ? displayName.strip() : null;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }
}
