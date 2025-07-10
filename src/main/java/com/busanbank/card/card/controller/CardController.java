package com.busanbank.card.card.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.busanbank.card.admin.dao.IAdminSearchDao;
import com.busanbank.card.card.dto.CardDto;
import com.busanbank.card.card.service.CardService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class CardController {

	private final CardService cardService;
	private final IAdminSearchDao adminSearchDao;

	// 전체 카드 목록
	@GetMapping("/cards")
	public List<CardDto> findAll() {
		return cardService.getCardList();
	}

	// 카드디테일(단건 조회)
	@GetMapping("/cards/{cardNo}") // ← 메서드 경로
	public CardDto findOne(@PathVariable("cardNo") Long cardNo) {
		CardDto dto = cardService.getCard(cardNo);
		if (dto == null) // 없으면 404 던지기 (선택)
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "존재하지 않는 카드");
		return dto;
	}

	// 카드리스트 검색기능
	@GetMapping("/cards/search")
	public List<CardDto> searchCards(@RequestParam(value = "q", required = false) String q,
			@RequestParam(value = "type", required = false) String type,
			@RequestParam(value = "tags", required = false) String tags) {
		// 금칙어 검사
		if (q != null && adminSearchDao.isProhibitedKeyword(q) > 0) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "해당 단어는 검색할 수 없습니다");
		}

		// "할인,교통" → List<String>
		List<String> tagList = (tags == null || tags.isBlank()) ? List.of() : List.of(tags.split(","));
		return cardService.search(q, type, tagList);
	}

    
    
    //카드디테일 페이지에서 view_count 상승시키기
    @PutMapping("/cards/{cardNo}/view")
    public ResponseEntity<Void> increaseViewCount(@PathVariable("cardNo") int cardNo) {
        cardService.increaseViewCount(cardNo);
        return ResponseEntity.ok().build();  
    }
    
    
   
	
}
