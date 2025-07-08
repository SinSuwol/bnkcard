package com.busanbank.card.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminMainController {


	// 상품 목록 페이지
	@GetMapping("/CardList")
	public String adminCardList() {
		return "admin/adminCardList";
	}

	// 검색어 관리 페이지
	@GetMapping("/Search")
	public String adminSearch() {
		return "adminSearch";
	}

	// 메인 페이지
	@GetMapping("/Mainpage")
	public String adminMainpage() {
		return "adminMainpage";
	}
	
	
	

}
