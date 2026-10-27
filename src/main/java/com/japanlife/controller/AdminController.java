package com.japanlife.controller;

import java.security.Principal;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;
import com.japanlife.dto.Member;
import com.japanlife.service.MemberService;
import com.japanlife.service.AdminContentService;
import com.japanlife.service.CommunityService;

@Controller
public class AdminController {
    private final MemberService members;
    private final AdminContentService content;
    private final CommunityService community;
    public AdminController(MemberService members, AdminContentService content, CommunityService community) { this.members = members; this.content = content; this.community = community; }

    @GetMapping("/admin")
    public String dashboard(Model model) {
        model.addAttribute("members", members.listForAdmin());
        model.addAttribute("procedures", content.procedures());
        model.addAttribute("publishedProcedureCount", content.publishedProcedureCount());
        model.addAttribute("documents", content.documents());
        model.addAttribute("steps", content.steps());
        model.addAttribute("sources", content.sources());
        model.addAttribute("offices", content.offices());
        model.addAttribute("reports", contentReports());
        model.addAttribute("communityPosts", community.adminPosts("", ""));
        return "admin/dashboard";
    }

    private java.util.List<java.util.Map<String,Object>> contentReports() { return community.reports(); }

    @GetMapping("/admin/members")
    public String memberPage(Principal principal, Model model) { model.addAttribute("members", members.listForAdmin()); model.addAttribute("audits", members.audit()); model.addAttribute("currentLoginId", principal.getName()); return "admin/members"; }
    @GetMapping("/admin/procedures")
    public String procedurePage(Model model) { model.addAttribute("procedures", content.procedures()); return "admin/procedures"; }
    @GetMapping("/admin/documents")
    public String documentPage(Model model) { model.addAttribute("documents", content.documents()); return "admin/documents"; }
    @GetMapping("/admin/steps")
    public String stepPage(Model model) { model.addAttribute("steps", content.steps()); return "admin/steps"; }
    @GetMapping("/admin/sources")
    public String sourcePage(Model model) { model.addAttribute("sources", content.sources()); return "admin/sources"; }
    @GetMapping("/admin/offices")
    public String officePage(Model model) { model.addAttribute("offices", content.offices()); return "admin/offices"; }
    @GetMapping("/admin/reports")
    public String reports(Model model) { model.addAttribute("reports", community.reports()); return "admin/reports"; }
    @GetMapping("/admin/community")
    public String communityPosts(@RequestParam(defaultValue="") String category, @RequestParam(defaultValue="") String q, Model model) { model.addAttribute("posts", community.adminPosts(category, q)); model.addAttribute("category", category); model.addAttribute("q", q); return "admin/community"; }
    @PostMapping("/admin/community/posts/{id}/status")
    public String updateCommunityPostStatus(@PathVariable long id, @RequestParam String status) { community.updatePostStatus(id, status); return "redirect:/admin/community?updated"; }
    @PostMapping("/admin/reports/{id}/moderate")
    public String moderateReport(@PathVariable long id, @RequestParam String action, Principal principal) { community.moderateReport(principal.getName(), id, action); return "redirect:/admin/reports?updated"; }

    @PostMapping("/admin/procedures/save")
    public String saveProcedure(@RequestParam(required=false) String id,@RequestParam String regionId,@RequestParam String categoryId,@RequestParam String title,@RequestParam String summary,@RequestParam String eligibility,@RequestParam(required=false) String deadline,@RequestParam(required=false) String method,@RequestParam(required=false) String notice,@RequestParam String situation,@RequestParam String phase,@RequestParam String published,@RequestParam String revision){ content.saveProcedure(id,regionId,categoryId,title,summary,eligibility,deadline,method,notice,situation,phase,published,revision); return "redirect:/admin/procedures?updated"; }
    @PostMapping("/admin/procedures/{id}/publish")
    public String togglePublished(@PathVariable String id){ content.togglePublished(id); return "redirect:/admin/procedures?updated"; }

    @GetMapping("/admin/procedures/{id}/translations")
    public String procedureTranslationsPage(@PathVariable long id, Model model) {
        model.addAttribute("procedure", content.procedure(id));
        model.addAttribute("translations", content.procedureTranslations(id));
        return "admin/procedure-translations";
    }

    @PostMapping("/admin/procedures/{id}/translations")
    public String saveProcedureTranslation(
            @PathVariable long id,
            @RequestParam String lang,
            @RequestParam String title,
            @RequestParam String summary,
            @RequestParam String eligibility,
            @RequestParam(required = false) String deadline,
            @RequestParam(required = false) String method,
            @RequestParam(required = false) String notice) {
        content.saveProcedureTranslation(id, lang, title, summary, eligibility, deadline, method, notice);
        return "redirect:/admin/procedures/" + id + "/translations?saved=" + lang;
    }

    @GetMapping("/admin/documents/{id}/translations")
    public String documentTranslationsPage(@PathVariable long id, Model model) {
        model.addAttribute("document", content.document(id));
        model.addAttribute("translations", content.documentTranslations(id));
        return "admin/document-translations";
    }

    @PostMapping("/admin/documents/{id}/translations")
    public String saveDocumentTranslation(
            @PathVariable long id,
            @RequestParam String lang,
            @RequestParam String name,
            @RequestParam(required = false) String conditionText) {
        content.saveDocumentTranslation(id, lang, name, conditionText);
        return "redirect:/admin/documents/" + id + "/translations?saved=" + lang;
    }

    @PostMapping("/admin/documents/save")
    public String saveDocument(@RequestParam(required=false) String id,@RequestParam String procedureId,@RequestParam String name,@RequestParam String requirement,@RequestParam(required=false) String condition,@RequestParam String displayOrder){ content.saveDocument(id,procedureId,name,requirement,condition,displayOrder); return "redirect:/admin/documents?updated"; }
    @PostMapping("/admin/steps/save")
    public String saveStep(@RequestParam(required=false) String id,@RequestParam String procedureId,@RequestParam String stepNo,@RequestParam String title,@RequestParam String description){ content.saveStep(id,procedureId,stepNo,title,description); return "redirect:/admin/steps?updated"; }
    @PostMapping("/admin/sources/save")
    public String saveSource(@RequestParam(required=false) String id,@RequestParam String procedureId,@RequestParam String title,@RequestParam String url,@RequestParam String checkedOn,@RequestParam(required=false) String updatedOn){ content.saveSource(id,procedureId,title,url,checkedOn,updatedOn); return "redirect:/admin/sources?updated"; }
    @PostMapping("/admin/offices/save")
    public String saveOffice(@RequestParam(required=false) String id,@RequestParam String name,@RequestParam(required=false) String address,@RequestParam String homepageUrl,@RequestParam(required=false) String note){ content.saveOffice(id,name,address,homepageUrl,note); return "redirect:/admin/offices?updated"; }

    @PostMapping("/admin/members/{memberId}/role")
    public String updateRole(@PathVariable long memberId, @RequestParam String role, @RequestParam(required=false) String reason, Principal principal) {
        Member target = members.findById(memberId);
        Member admin = members.findByLoginId(principal.getName());
        if (target == null || admin == null || target.getLoginId().equals(principal.getName()) || !members.updateRole(memberId, role, admin.getId(), reason)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
        return "redirect:/admin/members?updated";
    }

    @PostMapping("/admin/members/{memberId}/status")
    public String updateStatus(@PathVariable long memberId, @RequestParam String status, @RequestParam(required=false) String reason, Principal principal) {
        Member target = members.findById(memberId);
        Member admin = members.findByLoginId(principal.getName());
        if (target == null || admin == null || target.getLoginId().equals(principal.getName()) || !members.updateStatus(memberId, status, admin.getId(), reason)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
        return "redirect:/admin/members?updated";
    }
}
