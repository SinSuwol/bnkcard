package com.busanbank.card.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.busanbank.card.user.dao.IUserDao;
import com.busanbank.card.user.dto.UserDto;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private IUserDao userDao;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@GetMapping("/login")
	public String login(@RequestParam(name = "error", required = false) String error,
						@RequestParam(name = "logout", required = false) String logout,
						Model model) {
		if(error != null) {
			model.addAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
		}
		if(logout != null) {
			model.addAttribute("msg", "로그아웃 되었습니다.");
		}
		return "user/userLogin";
	}
	
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		
		if(session == null || session.getAttribute("loginUsername") == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "user/userLogin";
		}
		
		session.setMaxInactiveInterval(1200); //세션 시간 20분 설정
		int remainingSeconds = session.getMaxInactiveInterval();
		model.addAttribute("remainingSeconds", remainingSeconds);
		
		String username = (String) session.getAttribute("loginUsername");
		UserDto loginUser = userDao.findByUsername(username);
		
		System.out.println(loginUser);
		
		model.addAttribute("loginUser", loginUser);
		
		return "user/mypage";
	}
	
	@GetMapping("/editProfile")
	public String editProfile(HttpSession session, Model model) {
		
		session.setMaxInactiveInterval(1200); //세션 시간 20분 설정
		int remainingSeconds = session.getMaxInactiveInterval();
		model.addAttribute("remainingSeconds", remainingSeconds);
		
		String username = (String) session.getAttribute("loginUsername");
		UserDto loginUser = userDao.findByUsername(username);
		
		model.addAttribute("loginUser", loginUser);
		
		return "user/editProfile";
	}
	
	@PostMapping("/update")
	public String update(UserDto user, HttpSession session, Model model,
						RedirectAttributes rttr) {
		
		UserDto loginUser = userDao.findByUsername(user.getUsername());
		
		//로그인 사용자와 세션에 저장된 사용자가 같을 때
		if(user.getUsername().equals(session.getAttribute("loginUsername"))) {
			
			//비밀번호 변경 여부 확인
			if(user.getPassword() != null && !user.getPassword().isEmpty()) {
				
				//기존 비밀번호와 일치 여부 확인
				if(bCryptPasswordEncoder.matches(user.getPassword(), loginUser.getPassword())) {
					rttr.addFlashAttribute("msg", "기존 비밀번호와 동일합니다. 새로운 비밀번호를 입력해주세요.");
					return "redirect:/user/editProfile";
				}
				//새 비밀번호 암호화 후 update
				String encodedPassword = bCryptPasswordEncoder.encode(user.getPassword());
				user.setPassword(encodedPassword);
				
			}
			else {
				//기존값 유지
				user.setPassword(loginUser.getPassword());				
			}
			//DB 수정
			userDao.updateMember(user);
			System.out.println(user);
		}
		return "redirect:/user/mypage";
	}
}
