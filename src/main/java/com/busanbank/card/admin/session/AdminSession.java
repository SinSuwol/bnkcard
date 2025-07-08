package com.busanbank.card.admin.session;

import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.SessionScope;

import com.busanbank.card.admin.dto.AdminDto;

import jakarta.servlet.http.HttpSession;

@Component
@SessionScope
public class AdminSession {
	private AdminDto adminDto;
	private HttpSession session;
	
	//로그인 처리
		public void login(AdminDto admin, HttpSession adminsession) {
			session = adminsession;
			adminDto = admin;
			session.setAttribute("aid", adminDto.getUsername());
			session.setAttribute("aname", adminDto.getName());
		}
		//로그아웃 처리
		public void logout(HttpSession adminsession) {
			session = adminsession;
			adminDto = null;
			session.invalidate();
		}
		//현재 로그인 여부 확인
		public boolean isLoggedIn() {
			if(adminDto == null) {
				return false;
			}
			else return true;
		}
		//로그인 사용자 정보 조회
		public AdminDto getLoginUser() {
			return adminDto;
		}
}
