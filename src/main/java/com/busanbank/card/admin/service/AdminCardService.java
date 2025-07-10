package com.busanbank.card.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.busanbank.card.admin.dao.IAdminCardDao;
import com.busanbank.card.admin.dto.PermissionParamDto;
import com.busanbank.card.card.dto.CardDto;

@Service
public class AdminCardService {

	@Autowired
	IAdminCardDao adminCardDao;

	@Transactional
	public boolean insertCardTemp(CardDto cardDto, String s) {
		PermissionParamDto perDto = new PermissionParamDto();
		perDto.setCardNo(cardDto.getCardNo());
		perDto.setPerContent(s);
		
		
		int updated1 = adminCardDao.insertCardTemp(cardDto);
		int updated2 = adminCardDao.insertPermission(perDto);
		
		return updated1 > 0 && updated2 > 0;
	}


}
