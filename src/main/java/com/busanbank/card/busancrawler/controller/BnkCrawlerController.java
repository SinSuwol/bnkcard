package com.busanbank.card.busancrawler.controller;

import com.busanbank.card.busancrawler.service.BnkCrawlerService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BnkCrawlerController {

    private final BnkCrawlerService crawlerService;

    public BnkCrawlerController(BnkCrawlerService crawlerService) {
        this.crawlerService = crawlerService;
    }

    @GetMapping("/busan-crawler/test")
    public String testCrawling() {
        try {
            return crawlerService.crawlBusanBank();
        } catch (Exception e) {
            e.printStackTrace();
            return "크롤링 실패: " + e.getMessage();
        }
    }

}
