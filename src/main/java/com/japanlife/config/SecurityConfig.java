package com.japanlife.config;

import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.http.HttpMethod;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

@Configuration
public class SecurityConfig {
    @Bean PasswordEncoder passwordEncoder() { return new BCryptPasswordEncoder(); }
    @Bean AuthenticationSuccessHandler authenticationSuccessHandler() {
        var savedRequestHandler = new SavedRequestAwareAuthenticationSuccessHandler();
        savedRequestHandler.setDefaultTargetUrl("/procedures");
        return (request, response, authentication) -> {
            String target = request.getParameter("returnTo");
            if (target != null && target.startsWith("/") && !target.startsWith("//")
                    && !target.contains("\\") && !target.contains("\r") && !target.contains("\n")) {
                response.sendRedirect(request.getContextPath() + target);
                return;
            }
            savedRequestHandler.onAuthenticationSuccess(request, response, authentication);
        };
    }
    @Bean SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.authorizeHttpRequests(auth -> auth
            .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
                .requestMatchers("/", "/procedures/**", "/login", "/register/**", "/forgot-password/**", "/find-login-id/**", "/privacy", "/terms", "/community/rules", "/css/**", "/js/**", "/error").permitAll()
                .requestMatchers(HttpMethod.GET, "/community/write").authenticated()
                .requestMatchers(HttpMethod.GET, "/community", "/community/", "/community/images/**", "/community/{id}").permitAll()
                .requestMatchers("/admin/**").hasRole("ADMIN")
            .anyRequest().authenticated())
            .formLogin(form -> form.loginPage("/login").failureUrl("/login?error").successHandler(authenticationSuccessHandler()).permitAll())
            .logout(logout -> logout.logoutUrl("/logout").logoutSuccessUrl("/procedures?logout").permitAll());
        return http.build();
    }
}
