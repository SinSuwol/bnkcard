package com.busanbank.card.card.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.busanbank.card.card.dao.CardDao;
import com.busanbank.card.card.dto.CardDto;

import lombok.RequiredArgsConstructor;

@Service               
@RequiredArgsConstructor 
public class CardService {

    private final CardDao cardDao;

    // 전체 카드 조회 
    public List<CardDto> getCardList() {
        return cardDao.selectAll();
    }

    //카드 1건 조회 (필요 시)
    public CardDto getCard(long cardNo) {
        return cardDao.selectById(cardNo);
    }

    // 조회수  (예시)
    public void increaseViewCount(long cardNo) {
        cardDao.updateViewCount(cardNo);
    }
}