package com.japanlife.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AppErrorController implements ErrorController {
    @RequestMapping("/error")
    public String error(HttpServletRequest request, Model model) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        int code = status instanceof Integer ? (Integer) status : 500;
        model.addAttribute("statusCode", code);
        String type = code == 404 ? "notFound" : code == 400 ? "badRequest" : "server";
        model.addAttribute("errorTitleKey", "error." + type + ".title");
        model.addAttribute("errorDescriptionKey", "error." + type + ".description");
        return "error/page";
    }
}
