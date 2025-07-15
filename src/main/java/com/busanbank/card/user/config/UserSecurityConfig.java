package com.busanbank.card.user.config;

import org.springframework.beans.factory.annotation.Autowired;
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

	@Autowired
	private CustomLoginSuccessHandler customLoginSuccessHandler;
	
	@Bean
	BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean(name = "userFilterChain")
	SecurityFilterChain userFilterChain(HttpSecurity http) throws Exception {
		
		http.securityMatcher("/regist/**", "/user/**", "/loginProc", "/logout")
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
				.logoutSuccessUrl("/user/login?logout=true")
				.invalidateHttpSession(true)
				);
		
		http.csrf(csrf -> csrf.disable());
		
		return http.build();
	}
}
