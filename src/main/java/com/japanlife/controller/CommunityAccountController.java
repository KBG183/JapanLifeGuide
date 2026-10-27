package com.japanlife.controller;

import java.security.Principal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import com.japanlife.service.CommunityService;

@Controller
public class CommunityAccountController {
    private final CommunityService community;

    public CommunityAccountController(CommunityService community) {
        this.community = community;
    }

    @GetMapping("/my/community")
    public String activity(Principal principal, Model model) {
        model.addAttribute("bookmarks", community.bookmarks(principal.getName()));
        model.addAttribute("notifications", community.notifications(principal.getName()));
        return "community/activity";
    }

    @PostMapping("/my/community/notifications/{id}/read")
    public String markRead(@PathVariable long id, Principal principal) {
        community.markNotificationRead(principal.getName(), id);
        return "redirect:/my/community";
    }

    @PostMapping("/my/community/notifications/read-all")
    public String markAllRead(Principal principal) {
        community.markAllNotificationsRead(principal.getName());
        return "redirect:/my/community";
    }
}
