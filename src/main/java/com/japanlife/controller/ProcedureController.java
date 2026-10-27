package com.japanlife.controller;

import java.util.Locale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.japanlife.service.ProcedureService;

@Controller
public class ProcedureController {
    private final ProcedureService service;
    public ProcedureController(ProcedureService service) { this.service = service; }

    @GetMapping("/")
    public String home() { return "redirect:/procedures"; }

    @GetMapping("/procedures")
    public String list(@RequestParam(defaultValue="") String q,
                       @RequestParam(defaultValue="") String situation,
                       @RequestParam(defaultValue="") String phase,
                       @RequestParam(defaultValue="1") int page, Locale locale, Model model) {
        q = service.cleanQuery(q);
        situation = service.cleanSituation(situation);
        phase = service.cleanPhase(phase);
        String language = locale.getLanguage();
        int total = service.count(q, situation, phase, language);
        int pages = Math.max(1, (int) Math.ceil(total / (double) ProcedureService.PAGE_SIZE));
        page = Math.max(1, Math.min(page, pages));
        model.addAttribute("items", service.search(q, situation, phase, page, language));
        model.addAttribute("q", q);
        model.addAttribute("situation", situation);
        model.addAttribute("phase", phase);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pages", pages);
        return "procedures/list";
    }

    @GetMapping("/procedures/{id}")
    public String detail(@PathVariable long id, Locale locale, Model model) {
        String language = locale.getLanguage();
        model.addAttribute("procedure", service.detail(id, language));
        model.addAttribute("documents", service.documents(id, language));
        model.addAttribute("steps", service.steps(id, language));
        model.addAttribute("sources", service.sources(id, language));
        model.addAttribute("offices", service.offices(id, language));
        return "procedures/detail";
    }
}
