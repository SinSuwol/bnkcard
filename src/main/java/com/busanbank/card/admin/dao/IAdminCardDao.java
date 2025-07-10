package com.busanbank.card.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.busanbank.card.card.dto.CardDto;

@Mapper
public interface IAdminCardDao {
	public List<CardDto> getCardList();
	
	public int insertCardTemp(CardDto cardDto);
	
	public int insertPermission(CardDto cardDto);
	//카드번호, 담당관리자
	
	
}
