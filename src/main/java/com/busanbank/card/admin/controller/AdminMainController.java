package com.busanbank.card.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminMainController {

	@GetMapping("/adminCardList")
	public String adminCardList() {
		return "admin/adminCardList";
	}
}
