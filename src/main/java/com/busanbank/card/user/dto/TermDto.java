package com.busanbank.card.user.dto;

import lombok.Data;

@Data
public class TermDto {

	private int term_no;
	private String term_type;
	private char is_required;
	private String content;
	private String created_at;
	private String updated_at;
}
