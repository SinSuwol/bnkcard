package com.busanbank.card.user.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@Order(2)
public class UserSecurityConfig {

	@Bean
	BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean(name = "userFilterChain")
	SecurityFilterChain userFilterChain(HttpSecurity http) throws Exception {
		
		http.securityMatcher("/user/**", "/loginProc")
			.authorizeHttpRequests((auth) -> auth
				.anyRequest().authenticated()
				);
		
		http.formLogin((auth) -> auth
				.loginPage("/user/login")
				.loginProcessingUrl("/loginProc")
				.defaultSuccessUrl("/user/mypage")
				.failureUrl("/user/login?error=true")
				.permitAll()
				);
		
		http.csrf(csrf -> csrf.disable());
		
		return http.build();
	}
}
