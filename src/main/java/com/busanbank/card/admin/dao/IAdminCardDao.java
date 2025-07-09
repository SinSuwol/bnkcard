package com.busanbank.card.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.busanbank.card.card.dto.CardDto;

@Mapper
public interface IAdminCardDao {
	public List<CardDto> getCardList();
	
	public int editCard(CardDto cardDto);
}
