package com.busanbank.card.admin.dao;

import org.apache.ibatis.annotations.Mapper;

import com.busanbank.card.card.dto.CardDto;

@Mapper
public interface IAdminCardRegistDao {


	int insertCard(CardDto cardDto);
}
