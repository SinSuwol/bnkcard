package com.busanbank.card.user.dto;

import lombok.Data;

@Data
public class UserDto {
	
	private int member_no;
	private String username;
	private String password;
	private String name;	
	private String role;
	
	//주민등록번호
	private int rrn_front;
	private int rrn_gender;
	private int rrn_tail;
	
	//주소
	private String zip_code;
	private String address1;
	private String address2;
	
}
