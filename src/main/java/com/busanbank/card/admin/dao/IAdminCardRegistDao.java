package com.busanbank.card.admin.dao;

import org.apache.ibatis.annotations.Mapper;

import com.busanbank.card.admin.dto.PermissionParamDto;
import com.busanbank.card.card.dto.CardDto;

@Mapper
public interface IAdminCardRegistDao {

	public int insertCardTemp2(CardDto cardDto);

	public int insertPermission2(PermissionParamDto perDto);
	// 카드번호, 담당관리자
}
