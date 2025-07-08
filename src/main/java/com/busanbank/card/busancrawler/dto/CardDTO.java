package com.busanbank.card.busancrawler.dto;

import lombok.Data;

@Data
public class CardDTO {
    private String cardName;
    private String cardType;
    private String cardBrand;
    private Integer viewCount;
    private Integer annualFee;
    private String issuedTo;
    private String service;
    private String sService;
    private String cardStatus;
    private String cardUrl;
    private String cardSlogan;
    private String cardNotice;
    // issuedDate, dueDate는 String으로 먼저 받아도 되고 java.sql.Date로 받아도 OK
}
