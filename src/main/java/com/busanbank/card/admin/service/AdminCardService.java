package com.busanbank.card.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.busanbank.card.admin.dao.IAdminCardDao;
import com.busanbank.card.card.dto.CardDto;

@Service
public class AdminCardService {

	@Autowired
	IAdminCardDao adminCardDao;

	@Transactional
	public boolean insertCardTemp(CardDto cardDto) {
		int updated1 = adminCardDao.insertCardTemp(cardDto);
		int updated2 = adminCardDao.insertPermission(cardDto);
		
		return updated1 > 0 && updated2 > 0;
	}


}
