package com.busanbank.card.busancrawler.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ScrapCardDto {
    private String scCardUrl;
    private String scCardSlogan;
    private String scCardName;
    private int scAnnualFee;
    private String scSService;
}