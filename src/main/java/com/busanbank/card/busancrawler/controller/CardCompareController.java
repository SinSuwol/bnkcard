package com.busanbank.card.busancrawler.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.busanbank.card.busancrawler.dto.CardInfoDTO;
import com.busanbank.card.busancrawler.service.OtherBankCardCrawlerService;
import com.busanbank.card.card.dao.CardDao;
import com.busanbank.card.card.dto.CardDto;

@RestController
@RequestMapping("/compare")
public class CardCompareController {

    private final OtherBankCardCrawlerService crawlerService;
    private final CardDao cardDao; // 기존에 있던 DAO 사용

    public CardCompareController(OtherBankCardCrawlerService crawlerService, CardDao cardDao) {
        this.crawlerService = crawlerService;
        this.cardDao = cardDao;
    }
    
    @GetMapping("/run2")
    public CardInfoDTO compareCard(@RequestParam String shinhanCardUrl) {
        return crawlerService.crawlShinhanCard(shinhanCardUrl);
    }

    @GetMapping("/run")
    public String compareCard(@RequestParam(name = "shinhanCardUrl") String shinhanCardUrl,
                              @RequestParam(name = "cardNo") int cardNo) {

        // DB에서 cardNo로 부산은행 카드 정보 조회
        CardDto busan = cardDao.selectById(cardNo);
        if (busan == null) return " 해당 번호의 부산은행 카드 정보가 없습니다.";

        // 타행 카드 크롤링
        CardInfoDTO shinhan = crawlerService.crawlShinhanCard(shinhanCardUrl);
        if (shinhan == null) return " 타행 카드 크롤링 실패.";

        // 비교 결과 문자열 구성
        StringBuilder sb = new StringBuilder();
        sb.append("✅ 카드 비교 결과\n");
        sb.append("\n🟦 [부산은행] ").append(busan.getCardName())
          .append(" - ").append(busan.getCardSlogan()).append("\n");
        sb.append("🟥 [타행카드] ").append(shinhan.getCardName())
          .append(" - ").append(shinhan.getSlogan()).append("\n");

        return sb.toString();
    }
}
