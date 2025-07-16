package com.busanbank.card.busancrawler.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.busanbank.card.busancrawler.dto.ScrapCardDto;

@Mapper
public interface ScrapCardMapper {
	void insertCards(@Param("cards") List<ScrapCardDto> cards);
}
