package com.busanbank.card.user.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.session.HttpSessionEventPublisher;

@Configuration
@EnableWebSecurity
@Order(2)
public class UserSecurityConfig {

	@Autowired
	private CustomLoginSuccessHandler customLoginSuccessHandler;
	@Autowired
	private CustomSessionExpiredStrategy customSessionExpiredStrategy;
	
	@Bean
	BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	SessionRegistry sessionRegistry() {
	    return new SessionRegistryImpl();
	}

	@Bean
	static ServletListenerRegistrationBean<HttpSessionEventPublisher> httpSessionEventPublisher() {
	    return new ServletListenerRegistrationBean<>(new HttpSessionEventPublisher());
	}
	
	@Bean(name = "userFilterChain")
	SecurityFilterChain userFilterChain(HttpSecurity http) throws Exception {
		
		http.securityMatcher("/regist/**",  "/user/chat/**","/user/**", "/loginProc", "/logout")
			.authorizeHttpRequests((auth) -> auth
				.anyRequest().permitAll()
				);
		
		http.formLogin((auth) -> auth
				.loginPage("/user/login")
				.loginProcessingUrl("/loginProc")
				.successHandler(customLoginSuccessHandler)
				.failureUrl("/user/login?error=true")
				.permitAll()
				);
		
		http.logout(logout -> logout
				.logoutUrl("/logout")
				.logoutSuccessHandler((request, response, authentication) -> {
				    String expired = request.getParameter("expired");
				    if (expired != null) {
				        response.sendRedirect("/user/login?expired=true");
				    } else {
				        response.sendRedirect("/user/login?logout=true");
				    }
				})
				.invalidateHttpSession(true)
				);

        http.sessionManagement(session -> session
                .sessionFixation().changeSessionId()
                .maximumSessions(1)
                .expiredSessionStrategy(customSessionExpiredStrategy)
                .maxSessionsPreventsLogin(false)
                .sessionRegistry(sessionRegistry())
                );
		
		http.csrf(csrf -> csrf.disable());
		
		return http.build();
	}
}
