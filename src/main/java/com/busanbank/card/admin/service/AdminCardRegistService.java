package com.busanbank.card.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.busanbank.card.admin.dao.IAdminCardRegistDao;
import com.busanbank.card.card.dto.CardDto;

@Service
public class AdminCardRegistService {

	@Autowired
	IAdminCardRegistDao adminCardRegistDao;

	// 상품 등록
	public boolean registerCard(CardDto cardDto) {
		int insertedCount = adminCardRegistDao.insertCard(cardDto);
		return insertedCount > 0;
	}

}
