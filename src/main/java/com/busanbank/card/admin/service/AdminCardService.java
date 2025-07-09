package com.busanbank.card.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.busanbank.card.admin.dao.IAdminCardDao;
import com.busanbank.card.card.dto.CardDto;

@Service
public class AdminCardService {

	@Autowired
	IAdminCardDao adminCardDao;

	public boolean editCard(CardDto cardDto) {
		int updated = adminCardDao.editCard(cardDto);
		return updated > 0;
	}


}
