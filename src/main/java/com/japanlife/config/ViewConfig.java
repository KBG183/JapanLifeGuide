package com.japanlife.config;

import java.security.Principal;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.util.UriComponentsBuilder;
import com.japanlife.service.CommunityService;

@ControllerAdvice
public class ViewConfig {
    @Value("${app.preview:false}")
    private boolean preview;

    private final CommunityService communityService;

    public ViewConfig(CommunityService communityService) {
        this.communityService = communityService;
    }

    @ModelAttribute("unreadNotificationCount")
    public int unreadNotificationCount(Principal principal) {
        if (principal == null) return 0;
        return communityService.unreadNotificationCount(principal.getName());
    }

    @ModelAttribute
    public void setupJstlLocale(HttpServletRequest request) {
        Locale locale = LocaleContextHolder.getLocale();
        jakarta.servlet.jsp.jstl.core.Config.set(request, jakarta.servlet.jsp.jstl.core.Config.FMT_LOCALE, locale);
        if (request.getSession(false) != null) {
            jakarta.servlet.jsp.jstl.core.Config.set(request.getSession(), jakarta.servlet.jsp.jstl.core.Config.FMT_LOCALE, locale);
        }
    }

    @ModelAttribute("preview")
    public boolean preview() {
        return preview;
    }

    @ModelAttribute("currentLanguage")
    public String currentLanguage() {
        return LocaleContextHolder.getLocale().getLanguage();
    }

    @ModelAttribute("languageAction")
    public String languageAction(HttpServletRequest request) {
        Object forwardedUri = request.getAttribute("jakarta.servlet.forward.request_uri");
        return forwardedUri instanceof String uri ? uri : request.getRequestURI();
    }

    @ModelAttribute("loginContinue")
    public String loginContinue(HttpServletRequest request) {
        String path = request.getRequestURI();
        if (path == null || path.equals("/login") || path.startsWith("/register")
                || path.startsWith("/forgot-password") || path.startsWith("/find-login-id")) {
            return "/procedures";
        }
        String query = request.getQueryString();
        return path + (query == null || query.isBlank() ? "" : "?" + query);
    }

    @ModelAttribute("languageLinks")
    public Map<String, String> languageLinks(HttpServletRequest request) {
        Object forwardedUri = request.getAttribute("jakarta.servlet.forward.request_uri");
        String path = forwardedUri instanceof String uri ? uri : request.getRequestURI();
        Map<String, String> links = new LinkedHashMap<>();
        for (String language : new String[] {"ja", "ko", "en"}) {
            UriComponentsBuilder builder = UriComponentsBuilder.fromPath(path);
            request.getParameterMap().forEach((name, values) -> {
                if (!"lang".equals(name)) for (String value : values) builder.queryParam(name, value);
            });
            builder.queryParam("lang", language);
            links.put(language, builder.build().encode().toUriString());
        }
        return links;
    }
}
