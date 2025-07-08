package com.busanbank.card;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@GetMapping("/")
	public String root() {
		return "index";
	}
	
	@GetMapping("/admin")
	public String admin() {
		return "admin/admin";
	}
}
