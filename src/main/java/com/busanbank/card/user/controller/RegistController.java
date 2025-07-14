package com.busanbank.card.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.busanbank.card.user.dao.IUserDao;
import com.busanbank.card.user.dto.TermDto;
import com.busanbank.card.user.dto.TermsAgreementDto;
import com.busanbank.card.user.dto.UserDto;
import com.busanbank.card.user.dto.UserJoinDto;
import com.busanbank.card.user.util.AESUtil;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/regist")
public class RegistController {

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	@Autowired
	private IUserDao userDao;
	
	//회원유형선택
	@GetMapping("/selectMemberType")
	public String registForm(HttpSession session, Model model,
							 RedirectAttributes rttr) {
		
		String username = (String) session.getAttribute("loginUsername");
		UserDto loginUser = userDao.findByUsername(username);
		
		if(loginUser != null) {
			rttr.addFlashAttribute("message", "이미 로그인된 사용자입니다.");
			return "redirect:/";
		}
		
		return "user/selectMemberType";
	}
	
	//약관 동의
	@GetMapping("/terms")
	public String terms(@RequestParam("role")String role, Model model,
						HttpSession session,
						RedirectAttributes rttr) {
		
		String username = (String) session.getAttribute("loginUsername");
		UserDto loginUser = userDao.findByUsername(username);
		
		if(loginUser != null) {
			rttr.addFlashAttribute("message", "이미 로그인된 사용자입니다.");
			return "redirect:/";
		}		
		
		List<TermDto> terms = userDao.findAllTerms();
		model.addAttribute("terms", terms);
		
		model.addAttribute("role", role);
		return "user/terms";
	}
	
	//정보입력 폼 페이지
	@GetMapping("/userRegistForm")
	public String userRegistForm(@RequestParam("role")String role, Model model,
								 HttpSession session,
								 RedirectAttributes rttr) {
		
		String username = (String) session.getAttribute("loginUsername");
		UserDto loginUser = userDao.findByUsername(username);
		
		if(loginUser != null) {
			rttr.addFlashAttribute("message", "이미 로그인된 사용자입니다.");
			return "redirect:/";
		}
		
		model.addAttribute("role", role);
		return "user/userRegistForm";
	}
	
	//아이디 중복확인
	@PostMapping("/check-username")
	public @ResponseBody String checkUsername(@RequestParam("username")String username,
											  RedirectAttributes rttr) {
		UserDto user = userDao.findByUsername(username);
		if(user != null) {
			return "이미 사용중인 아이디입니다.";
		}
		return "사용가능한 아이디입니다.";
	}
	
	//유효성 검사 및 insert
	@PostMapping("/regist")
	public String regist(UserJoinDto joinUser, Model model) {
		
		//성명 검사
		if(joinUser.getName() == null) {
			model.addAttribute("msg", "성명을 입력해주세요.");
			return "user/userRegistForm";			
		}
		
		//아이디 검사
		if(joinUser.getUsername() == null) {
			model.addAttribute("msg", "아이디를 입력해주세요.");
			return "user/userRegistForm";			
		}
		
		//비밀번호 검사
		if(joinUser.getPassword() == null) {
			model.addAttribute("msg", "비밀번호를 입력해주세요.");
			return "user/userRegistForm";			
		}
		if(joinUser.getPasswordCheck() == null) {
			model.addAttribute("msg", "비밀번호를 확인하세요.");
			return "user/userRegistForm";			
		}
		if(!joinUser.getPassword().equals(joinUser.getPasswordCheck())) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "user/userRegistForm";
		}
		if(!joinUser.getPassword().matches("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\[\\]{}|\\\\;:'\",.<>?/`~\\-]).{8,12}$")) {
		    model.addAttribute("msg", "비밀번호는 영문자, 숫자, 특수문자를 포함한 8~12자리여야 합니다.");
		    return "user/userRegistForm";			
		}
		
		//주민등록번호 검사
		if(joinUser.getRrnFront() == null || joinUser.getRrnFront().length() != 6 || joinUser.getRrnBack() == null || joinUser.getRrnBack().length() != 7) {
			model.addAttribute("msg", "주민번호를 확인해주세요.");
			return "user/userRegistForm";
		}
		
		//주소 검사
		if(joinUser.getZipCode() == null || joinUser.getAddress1() == null || joinUser.getAddress2() == null) {
			model.addAttribute("msg", "주소를 입력해주세요.");
			return "user/userRegistForm";
		}
		
		UserDto user = new UserDto();
		user.setName(joinUser.getName());
		user.setUsername(joinUser.getUsername());

		String encodedPassword = bCryptPasswordEncoder.encode(joinUser.getPassword());
		user.setPassword(encodedPassword);
		
		String rrn_gender = joinUser.getRrnBack().substring(0, 1);
		String rrn_tail = joinUser.getRrnBack().substring(1);
		String encryptedRrnTail;
		try {
			encryptedRrnTail = AESUtil.encrypt(rrn_tail);
		} catch (Exception e) {
			model.addAttribute("msg", "주민번호 암호화에 실패했습니다.");
			return "user/userRegistForm";
		}
		user.setRrnFront(joinUser.getRrnFront());
		user.setRrnGender(rrn_gender);
		user.setRrnTailEnc(encryptedRrnTail);
		
		user.setZipCode(joinUser.getZipCode());
		user.setAddress1(joinUser.getAddress1());
		user.setAddress2(joinUser.getAddress2());
		
		user.setRole(joinUser.getRole());
		
		userDao.insertMember(user);
		
		System.out.println(userDao.findByUsername(user.getUsername()));
		UserDto registUser = userDao.findByUsername(user.getUsername());
		
		TermsAgreementDto term1Agree = new TermsAgreementDto();
		term1Agree.setMemberNo(registUser.getMemberNo());
		term1Agree.setTermNo(1);
		
		userDao.insertTermsAgreement(term1Agree);

		TermsAgreementDto term2Agree = new TermsAgreementDto();
		term2Agree.setMemberNo(registUser.getMemberNo());
		term2Agree.setTermNo(2);
		
		userDao.insertTermsAgreement(term2Agree);
		
		return "user/userLogin";
	}
}
