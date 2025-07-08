package com.busanbank.card.card.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.busanbank.card.card.dto.CardDto;

@Mapper // 스캔만 하면 xml과 자동 매핑
public interface CardDao {
	List<CardDto> selectAll(); // 카드 전체 조회
}
