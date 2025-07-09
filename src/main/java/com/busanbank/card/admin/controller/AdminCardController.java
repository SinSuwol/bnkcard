package com.busanbank.card.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.busanbank.card.admin.dao.IAdminCardDao;
import com.busanbank.card.admin.service.AdminCardService;
import com.busanbank.card.card.dto.CardDto;

@RequestMapping("/admin/card")
@RestController	
public class AdminCardController {
	
	@Autowired
	IAdminCardDao iAdminCardDao;
	
	@Autowired
	AdminCardService adminCardService;
	
	@GetMapping("/getCardList")
    public List<CardDto> getAllCards() {
        List<CardDto> cards = iAdminCardDao.getCardList();
        return cards;
    }
	
	@PutMapping("/editCard/{cardNo}")
    public String editCard(@PathVariable("cardNo") Long cardNo, @RequestBody CardDto cardDto) {
		cardDto.setCardNo(cardNo); // 카드 번호 설정
		System.out.println(cardDto);
        boolean result = adminCardService.editCard(cardDto);
        return result ? "success" : "fail";
    }
}
