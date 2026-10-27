package com.japanlife.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PolicyController {
    @GetMapping("/privacy")
    public String privacy() { return "policy/privacy"; }

    @GetMapping("/terms")
    public String terms() { return "policy/terms"; }

    @GetMapping("/community/rules")
    public String communityRules() { return "policy/community-rules"; }
}
