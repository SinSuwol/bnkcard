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

	//수정,등록 용
	@Transactional
	public boolean insertCardTemp(CardDto cardDto, String s, String adminId) {
		PermissionParamDto perDto = new PermissionParamDto();
		perDto.setCardNo(cardDto.getCardNo());
		perDto.setPerContent(s);
		perDto.setAdmin(adminId);
		
		int updated1 = adminCardDao.insertCardTemp(cardDto);
		int updated2 = adminCardDao.insertPermission(perDto);
		
		return updated1 > 0 && updated2 > 0;
	}
	
	//삭제용
	public boolean insertCardTemp2(Long i, String s, String adminId) {
		PermissionParamDto perDto = new PermissionParamDto();
		perDto.setCardNo(i);
		perDto.setPerContent(s);
		perDto.setAdmin(adminId);
		
		System.out.println(i + s);
		
		int updated2 = adminCardDao.insertPermission(perDto);
		
		return updated2 > 0;
	}


}
