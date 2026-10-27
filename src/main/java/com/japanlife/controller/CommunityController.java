package com.japanlife.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.Principal;
import java.util.Map;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.japanlife.service.CommunityService;
import com.japanlife.dto.form.CommentForm;
import com.japanlife.dto.form.CommunityPostForm;
import jakarta.validation.Valid;
import org.springframework.validation.BindingResult;

@Controller
public class CommunityController {
    private final CommunityService service;

    public CommunityController(CommunityService service) {
        this.service = service;
    }

    @GetMapping("/community")
    public String list(@RequestParam(defaultValue = "") String category,
                       @RequestParam(defaultValue = "") String q,
                       @RequestParam(defaultValue = "1") int page,
                       Model model) {
        int safePage = Math.max(page, 1);
        int pageSize = 10;
        int total = service.countPosts(category, q);
        int pages = Math.max(1, (total + pageSize - 1) / pageSize);
        if (safePage > pages) safePage = pages;

        model.addAttribute("posts", service.posts(category, q, safePage, pageSize));
        model.addAttribute("category", category);
        model.addAttribute("q", q);
        model.addAttribute("page", safePage);
        model.addAttribute("pages", pages);
        model.addAttribute("total", total);
        return "community/list";
    }

    @GetMapping("/community/{id}")
    public String detail(@PathVariable long id, Principal principal, Model model) {
        model.addAttribute("post", service.post(id));
        model.addAttribute("comments", service.comments(id));
        model.addAttribute("images", service.images(id));
        model.addAttribute("liked", principal != null && service.likedBy(principal.getName(), id));
        model.addAttribute("bookmarked", principal != null && service.bookmarkedBy(principal.getName(), id));
        model.addAttribute("currentMemberId", principal == null ? null : service.memberId(principal.getName()));
        return "community/detail";
    }

    @GetMapping("/community/write")
    public String write() {
        return "community/write";
    }

    @GetMapping("/community/{id}/edit")
    public String edit(@PathVariable long id, Principal principal, Model model) {
        model.addAttribute("post", service.editablePost(principal.getName(), id));
        model.addAttribute("currentMemberId", service.memberId(principal.getName()));
        return "community/edit";
    }

    @PostMapping("/community/write")
    public String create(@Valid @ModelAttribute CommunityPostForm form,
                         BindingResult bindingResult,
                         @RequestParam(required = false) MultipartFile[] images,
                         Principal principal) {
        if (bindingResult.hasErrors()) {
            throw new IllegalArgumentException("invalid post form");
        }
        long id = service.create(principal.getName(), form.getCategory(), form.getTitle(), form.getBody(), images);
        return "redirect:/community/" + id;
    }

    @PostMapping("/community/{id}/comments")
    public String comment(@PathVariable long id,
                          @Valid @ModelAttribute CommentForm form,
                          BindingResult bindingResult,
                          Principal principal) {
        if (bindingResult.hasErrors()) {
            throw new IllegalArgumentException("invalid comment form");
        }
        service.comment(principal.getName(), id, form.getBody());
        return "redirect:/community/" + id;
    }

    @PostMapping("/community/{id}/edit")
    public String update(@PathVariable long id,
                         @Valid @ModelAttribute CommunityPostForm form,
                         BindingResult bindingResult,
                         Principal principal) {
        if (bindingResult.hasErrors()) {
            throw new IllegalArgumentException("invalid edit form");
        }
        service.updatePost(principal.getName(), id, form.getCategory(), form.getTitle(), form.getBody());
        return "redirect:/community/" + id;
    }

    @PostMapping("/community/{id}/bookmark")
    @ResponseBody
    public Map<String, Object> bookmark(@PathVariable long id, Principal principal) {
        boolean bookmarked = service.bookmark(principal.getName(), id);
        return Map.of("bookmarked", bookmarked);
    }

    @PostMapping("/community/{id}/like")
    @ResponseBody
    public Map<String, Object> like(@PathVariable long id, Principal principal) {
        boolean liked = service.like(principal.getName(), id);
        return Map.of("liked", liked, "likeCount", service.likeCount(id));
    }

    @PostMapping("/community/{id}/delete")
    public String delete(@PathVariable long id, Principal principal) {
        service.deletePost(principal.getName(), id);
        return "redirect:/community";
    }

    @PostMapping("/community/{id}/report")
    public String report(@PathVariable long id, @RequestParam String reason, Principal principal) {
        service.reportPost(principal.getName(), id, reason);
        return "redirect:/community/" + id + "?reported";
    }

    @PostMapping("/community/comments/{id}/delete")
    public String deleteComment(@PathVariable long id, @RequestParam long postId, Principal principal) {
        service.deleteComment(principal.getName(), id);
        return "redirect:/community/" + postId;
    }

    @PostMapping("/community/comments/{id}/edit")
    public String updateComment(@PathVariable long id,
                                @RequestParam long postId,
                                @RequestParam String body,
                                Principal principal) {
        service.updateComment(principal.getName(), id, postId, body);
        return "redirect:/community/" + postId;
    }

    @PostMapping("/community/comments/{id}/report")
    public String reportComment(@PathVariable long id,
                                @RequestParam long postId,
                                @RequestParam String reason,
                                Principal principal) {
        service.reportComment(principal.getName(), id, reason);
        return "redirect:/community/" + postId + "?reported";
    }

    @GetMapping("/community/images/{name:.+}")
    @ResponseBody
    public ResponseEntity<Resource> image(@PathVariable String name) throws IOException {
        Path p = service.image(name);
        if (p == null || !Files.isRegularFile(p)) {
            return ResponseEntity.notFound().build();
        }
        String type = Files.probeContentType(p);
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(type == null ? MediaType.APPLICATION_OCTET_STREAM_VALUE : type))
                .body(new FileSystemResource(p));
    }
}
