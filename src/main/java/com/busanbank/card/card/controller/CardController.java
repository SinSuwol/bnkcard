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
import com.busanbank.card.busancrawler.dto.ScrapCardDto;
import com.busanbank.card.busancrawler.service.SeleniumCardCrawler;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class CardController {

	private final CardService cardService;
	private final IAdminSearchDao adminSearchDao;
	private final SeleniumCardCrawler seleniumCardCrawler;  // ✅ 추가

	@GetMapping("/cards")
	public List<CardDto> findAll() {
		return cardService.getCardList();
	}

	@GetMapping("/cards/{cardNo}")
	public ResponseEntity<?> getCard(@PathVariable("cardNo") String cardNo) {
	    if (cardNo.startsWith("scrap_")) {
	        // 타행카드 처리
	        List<ScrapCardDto> all = seleniumCardCrawler.getScrapList();
	        long timestamp = Long.parseLong(cardNo.replace("scrap_", ""));
	        ScrapCardDto match = all.stream()
	            .filter(c -> c.getScCardName().contains("Pick E")) // 이름 또는 날짜 등으로 매칭
	            .findFirst()
	            .orElse(null);
	        return ResponseEntity.ok(match);
	    } else {
	        Long realNo = Long.parseLong(cardNo);
	        return ResponseEntity.ok(cardService.getCard(realNo));
	    }
	}


	@GetMapping("/cards/search")
	public List<CardDto> searchCards(@RequestParam(value = "q", required = false) String q,
	                                 @RequestParam(value = "type", required = false) String type,
	                                 @RequestParam(value = "tags", required = false) String tags) {
	    if (q != null && adminSearchDao.isProhibitedKeyword(q) > 0) {
	        throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "해당 단어는 검색할 수 없습니다");
	    }

	    if (type == null || type.isBlank()) {
	        if ("신용".equals(q)) {
	            type = "신용";
	            q = null;
	        } else if ("체크".equals(q)) {
	            type = "체크";
	            q = null;
	        }
	    }

	    List<String> tagList = (tags == null || tags.isBlank()) ? List.of() : List.of(tags.split(","));
	    return cardService.search(q, type, tagList);
	}

	@PutMapping("/cards/{cardNo}/view")
	public ResponseEntity<Void> increaseViewCount(@PathVariable("cardNo") int cardNo) {
	    cardService.increaseViewCount(cardNo);
	    return ResponseEntity.ok().build();  
	}

	// 타행카드 전체 목록 (공개용)
	@GetMapping("/public/cards/scrap")
	public List<ScrapCardDto> publicScrapCards() {
	    return seleniumCardCrawler.getScrapList();
	}
}
