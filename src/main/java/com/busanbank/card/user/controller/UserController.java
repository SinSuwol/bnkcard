package com.busanbank.card.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.busanbank.card.user.dao.IUserDao;
import com.busanbank.card.user.dto.UserDto;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private IUserDao userDao;
	
	@GetMapping("/login")
	public String login(@RequestParam(name = "error", required = false) String error) {
		return "user/userLogin";
	}
	
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		
		session.setMaxInactiveInterval(1200);
		
		String username = (String) session.getAttribute("loginUsername");
		UserDto loginUser = userDao.findByUsername(username);
		
		model.addAttribute("name", loginUser.getName());
		
		return "user/mypage";
	}	
}
