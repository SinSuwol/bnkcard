package com.busanbank.card.busancrawler.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.busanbank.card.busancrawler.dto.ScrapCardDto;

@Mapper
public interface ScrapCardMapper {
	void insertCard(ScrapCardDto card);
}
