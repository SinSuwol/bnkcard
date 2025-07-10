package com.busanbank.card.user.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.busanbank.card.user.dto.TermDto;
import com.busanbank.card.user.dto.UserDto;

@Mapper
public interface IUserDao {

	@Select("SELECT * FROM member WHERE username = #{username}")
	UserDto findByUsername(String username);
	
	@Insert("INSERT INTO member (member_no, username, password, rrn_front, rrn_gender, rrn_tail_enc, name, zip_code, address1, address2, role) "
			+ "VALUES (member_seq.nextval, #{username}, #{password}, #{rrn_front}, #{rrn_gender}, #{rrn_tail_enc}, #{name}, #{zip_code}, #{address1}, #{address2}, #{role})")
	int insertMember(UserDto user);
	
	@Select("SELECT * FROM terms WHERE term_type = #{term_type}")
	TermDto findByTermType(String term_type);
}
