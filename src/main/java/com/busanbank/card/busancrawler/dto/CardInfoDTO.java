package com.busanbank.card.busancrawler.dto;

import lombok.Data;

@Data
public class CardInfoDTO {
    private String cardName;
    private String cardType;
    private String slogan;
    private String service;
    private Integer annualFee;
    private String cardUrl;
    // ... 혜택, 연회비, 브랜드 등 추가 가능
}