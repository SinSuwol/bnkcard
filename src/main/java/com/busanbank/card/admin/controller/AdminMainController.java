package com.busanbank.card.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.busanbank.card.admin.dto.AdminDto;
import com.busanbank.card.admin.session.AdminSession;

@Controller
@RequestMapping("/admin")
public class AdminMainController {

	@Autowired
	private AdminSession adminSession;

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
		AdminDto admin = adminSession.getLoginUser();

		if (admin == null) {
			// 로그인 안한 경우
			return "redirect:/admin/adminLoginForm";
		}
		
		 if ("SUPER_ADMIN".equals(admin.getRole())) {
	            // 상위 관리자
	            return "admin/superAdminPermission";
	        } else {
	            // 하위 관리자
	        	return "admin/adminImpression";
	        }
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
	
	
	//=========================================
	// 상위 관리자
	@GetMapping("/superAdminPermission")
	public String superAdminPermission() {
		return "admin/superAdminPermission";
	}

}
