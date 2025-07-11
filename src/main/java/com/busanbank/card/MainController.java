package com.busanbank.card;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor // final 필드 주입용
public class MainController {


	// 여기가 페이지 이동기능 모아놓은 컨트롤러입니다.

	@GetMapping("/")
	public String root() {
		return "index";
	}

	@GetMapping("/admin")
	public String admin() {
		return "admin/admin";
	}

	@GetMapping("/cardList")
    public String cardListPage() {
        return "cardList";      // 카드리스트
    }
	
	@GetMapping("/cards/detail")
	public String cardDetailPage() {
	    return "cardDetail";   // 카드디테일
	}
	
	@GetMapping("/faq")
	public String faqPage() {
	    return "faq";   // faq
	}
	
	@GetMapping("/introduce")
	public String introducePage() {
	    return "introduce";   // 은행소개
	}
}
