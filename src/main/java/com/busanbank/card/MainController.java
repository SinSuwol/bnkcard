package com.busanbank.card;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	//여기가 페이지 이동기능 모아놓은 컨트롤러입니다.
	
	@GetMapping("/")
	public String root() {
		return "index";
	}
	
	@GetMapping("/admin")
	public String admin() {
		return "admin/admin";
	}
	
	@GetMapping("/cardList")
	public String cardList() {
		return "cardList";
	}
}
