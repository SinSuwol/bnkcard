package com.busanbank.card.admin.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import com.busanbank.card.admin.session.AdminSession;

@Configuration
@EnableWebSecurity
@Order(1)
public class SecurityConfig {

	@Bean(name = "adminFilterChain")
    public SecurityFilterChain adminFilterChain(HttpSecurity http, AdminSession adminSession) throws Exception {

		http
	    // /admin 및 하위 경로 적용
		.securityMatcher("/admin/**")

	    .authorizeHttpRequests(auth -> auth
	        .requestMatchers("/admin/adminLoginForm","/admin/login", "/admin/logout").permitAll()
	        .anyRequest()
	            .access((authentication, context) -> {
	                boolean loggedIn = adminSession.isLoggedIn();
	                return new org.springframework.security.authorization.AuthorizationDecision(loggedIn);
	            })
	    )

	    .csrf(csrf -> csrf.disable())
	    .sessionManagement(session -> session
	        .maximumSessions(1)
	        .maxSessionsPreventsLogin(true)
	    );

        return http.build();
    }
}

