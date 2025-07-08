package com.busanbank.card.user.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.busanbank.card.user.dto.UserDto;

@Mapper
public interface IUserDao {

	@Select("SELECT * FROM member WHERE username = #{username}")
	UserDto findByUsername(String username);
}
