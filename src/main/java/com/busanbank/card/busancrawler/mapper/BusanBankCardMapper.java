package com.busanbank.card.busancrawler.mapper;

import com.busanbank.card.busancrawler.dto.CardDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BusanBankCardMapper {
    void insertCard(CardDTO dto);
}
