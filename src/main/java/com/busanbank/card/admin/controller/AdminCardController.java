package com.busanbank.card.admin.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.busanbank.card.admin.dao.IAdminCardDao;
import com.busanbank.card.card.dto.CardDto;

@RequestMapping("/admin/card")
@RestController	
public class AdminCardController {
	
	@Autowired
	IAdminCardDao iAdminCardDao;
	
	@GetMapping("/getCardList")
    public List<CardDto> getAllCards() {
        List<CardDto> cards = iAdminCardDao.getCardList();
        System.out.println(cards);
        return cards;
    }
	
	
}
