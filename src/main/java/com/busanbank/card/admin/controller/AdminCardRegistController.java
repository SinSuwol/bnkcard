package com.busanbank.card.admin.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AdminCardRegistController {

	
	// 상품 등록 처리
		@PostMapping("/adminInsert")
		public String adminInsert() {
			return "";
		}

}
