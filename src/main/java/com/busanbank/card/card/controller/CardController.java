package com.busanbank.card.card.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.busanbank.card.card.dto.CardDto;
import com.busanbank.card.card.service.CardService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api")               
@RequiredArgsConstructor
public class CardController {

    private final CardService cardService;

    /** 전체 카드 목록 JSON  ── GET /api/cards */
    @GetMapping("/cards")
    public List<CardDto> findAll() {
        return cardService.getCardList();
    }

    /** 단건 조회          ── GET /api/cards/3 */
    @GetMapping("/cards/{cardNo}")
    public CardDto findOne(@PathVariable("cardNo") Long cardNo) {   // ★ 이름 명시
        return cardService.getCard(cardNo);
    }
	
}
