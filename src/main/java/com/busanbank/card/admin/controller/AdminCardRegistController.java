package com.busanbank.card.admin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.busanbank.card.admin.service.AdminCardRegistService;
import com.busanbank.card.card.dto.CardDto;

@RestController
public class AdminCardRegistController {

	@Autowired
	AdminCardRegistService adminCardRegistService;
	
	
	
	@PostMapping("/cardRegist")
	public ResponseEntity<Map<String, Object>> registerCard(@RequestBody CardDto cardDto) {
	    boolean result = adminCardRegistService.registerCard(cardDto);

	    Map<String, Object> response = new HashMap<>();
	    response.put("success", result);
	    response.put("message", result ? "카드가 성공적으로 등록되었습니다." : "카드 등록에 실패했습니다.");
	    if (result) {
	        response.put("data", cardDto);
	    }

	    return ResponseEntity
	            .status(result ? HttpStatus.CREATED : HttpStatus.INTERNAL_SERVER_ERROR)
	            .body(response);
	}

}
