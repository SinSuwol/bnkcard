package com.busanbank.card.busancrawler.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.busanbank.card.busancrawler.service.SeleniumCardCrawler;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin/card")
public class CrawlController {

//    private final SeleniumCardCrawler crawler;
//
//    @GetMapping("/crawl/shinhan")
//    public String crawlShinhanCard() {
//        return crawler.crawlShinhanCard();
//    }
	@Autowired
	SeleniumCardCrawler seleniumCardCrawler;

    @PostMapping("/scrap")
    public String scrapCards() {
        return seleniumCardCrawler.crawlShinhanCards(); // 크롤링 결과 로그 문자열 반환
    }
}