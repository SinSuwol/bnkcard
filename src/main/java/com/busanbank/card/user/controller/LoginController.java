package com.busanbank.card.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/user")
public class LoginController {

	@GetMapping("/login")
	public String login(@RequestParam(name = "error", required = false) String error) {
		return "user/login";
	}
	
	@GetMapping("/mypage")
	public String mypage() {
		return "user/mypage";
	}
}
