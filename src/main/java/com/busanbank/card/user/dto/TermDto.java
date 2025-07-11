package com.busanbank.card.user.dto;

import lombok.Data;

@Data
public class TermDto {

	private int termNo;
	private String termType;
	private char isRequired;
	private String content;
	private String createdAt;
	private String updatedAt;
}
