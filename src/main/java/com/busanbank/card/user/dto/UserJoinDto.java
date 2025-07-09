package com.busanbank.card.user.dto;

import lombok.Data;

@Data
public class UserJoinDto {

	private String username;
	private String password;
	private String passwordCheck;
	private String name;
	
	//주민등록번호
	private String rrn_front;
	private String rrn_back;
	
	//주소
	private String zip_code;
	private String address1;
	private String address2;
}
