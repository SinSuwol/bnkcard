package com.busanbank.card;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.busanbank.card.user.dao.IUserDao;
import com.busanbank.card.user.dto.UserDto;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor // final 필드 주입용
public class MainController {

	@Autowired
	private IUserDao userDao;	
	// 여기가 페이지 이동기능 모아놓은 컨트롤러입니다.

	@GetMapping("/")
	public String root(HttpSession session, Model model) {
		
		session.setMaxInactiveInterval(1200); //세션 시간 20분 설정
		int remainingSeconds = session.getMaxInactiveInterval();
		model.addAttribute("remainingSeconds", remainingSeconds);
		
		String username = (String) session.getAttribute("loginUsername");
		if(username == null) {			
			return "index";
		}
		
		UserDto loginUser = userDao.findByUsername(username);
		model.addAttribute("loginUser", loginUser);
		
		return "index";
	}

	@GetMapping("/admin")
	public String admin() {
		return "admin/admin";
	}

	@GetMapping("/cardList")
    public String cardListPage(HttpSession session, Model model) {
		
		session.setMaxInactiveInterval(1200); //세션 시간 20분 설정
		int remainingSeconds = session.getMaxInactiveInterval();
		model.addAttribute("remainingSeconds", remainingSeconds);
		
		String username = (String) session.getAttribute("loginUsername");
		if(username == null) {			
			return "cardList";
		}
		
		UserDto loginUser = userDao.findByUsername(username);
		model.addAttribute("loginUser", loginUser);
		
        return "cardList";      // 카드리스트
    }
	
	@GetMapping("/cards/detail")
	public String cardDetailPage(HttpSession session, Model model) {
		
		session.setMaxInactiveInterval(1200); //세션 시간 20분 설정
		int remainingSeconds = session.getMaxInactiveInterval();
		model.addAttribute("remainingSeconds", remainingSeconds);
		
		String username = (String) session.getAttribute("loginUsername");
		if(username == null) {			
			return "cardDetail";
		}
		
		UserDto loginUser = userDao.findByUsername(username);
		model.addAttribute("loginUser", loginUser);
		
	    return "cardDetail";   // 카드디테일
	}
	
	@GetMapping("/faq")
	public String faqPage(HttpSession session, Model model) {
		
		session.setMaxInactiveInterval(1200); //세션 시간 20분 설정
		int remainingSeconds = session.getMaxInactiveInterval();
		model.addAttribute("remainingSeconds", remainingSeconds);
		
		String username = (String) session.getAttribute("loginUsername");
		if(username == null) {			
			return "faq";
		}
		
		UserDto loginUser = userDao.findByUsername(username);		
		model.addAttribute("loginUser", loginUser);
		
	    return "faq";   // faq
	}
	
	@GetMapping("/introduce")
	public String introducePage(HttpSession session, Model model) {
		
		session.setMaxInactiveInterval(1200); //세션 시간 20분 설정
		int remainingSeconds = session.getMaxInactiveInterval();
		model.addAttribute("remainingSeconds", remainingSeconds);
		
		String username = (String) session.getAttribute("loginUsername");
		if(username == null) {			
			return "introduce";
		}
		
		UserDto loginUser = userDao.findByUsername(username);
		model.addAttribute("loginUser", loginUser);
		
	    return "introduce";   // 은행소개
	}
}
