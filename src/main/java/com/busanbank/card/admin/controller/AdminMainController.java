package com.busanbank.card.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminMainController {

@RequestMapping("/admin")

	// 상품 목록 페이지
	@GetMapping("/adminCardList")
	public String adminCardList() {
		return "admin/adminCardList";
	}

	// 검색어 관리 페이지
	@GetMapping("/adminSearch")
	public String adminSearch() {
		return "adminSearch";
	}

	// 메인 페이지
	@GetMapping("/adminMainpage")
	public String adminMainpage() {
		return "adminMainpage";
	}
	
	
	

}
