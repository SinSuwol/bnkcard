package com.busanbank.card.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminMainController {

	// 상품 목록 페이지
	@GetMapping("/CardList")
	public String adminCardList() {
		return "admin/adminCardList";
	}

	// 상품 등록 페이지
	@GetMapping("/adminCardRegistForm")
	public String adminCardRegistForm() {
		return "admin/adminCardRegistForm";
	}

	// 관리자 로그인 페이지
	@GetMapping("/adminLoginForm")
	public String adminLoginForm() {
		return "admin/adminLoginForm";
	}

	// 검색어 관리 페이지
	@GetMapping("/Search")
	public String adminSearch() {
		return "admin/adminSearch";
	}

	// 검색어 관리 통계 페이지
	@GetMapping("/Statistics")
	public String adminStatistics() {
		return "admin/adminStatistics";
	}

	// 상품 인가 페이지
	@GetMapping("/Impression")
	public String adminImpression() {
		return "admin/adminImpression";
	}

	// 관리자 스크래핑 페이지
	@GetMapping("/Scraping")
	public String adminScraping() {
		return "admin/adminScraping";
	}

	// 메인 페이지
	@GetMapping("/Mainpage")
	public String adminMainpage() {
		return "admin/adminMainpage";
	}

}
