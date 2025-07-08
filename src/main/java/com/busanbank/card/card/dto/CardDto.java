package com.busanbank.card.card.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class CardDto {
	private Long cardNo;
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
    private LocalDate cardIssueDate;
    private LocalDate cardDueDate;
    private String cardSlogan;
    private String cardNotice;
    private LocalDate regDate;
    private LocalDate editDate;
}
