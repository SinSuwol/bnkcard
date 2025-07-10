package com.busanbank.card.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.busanbank.card.user.dao.IUserDao;
import com.busanbank.card.user.dto.UserDto;
import com.busanbank.card.user.dto.UserJoinDto;
import com.busanbank.card.user.util.AESUtil;

@Controller
@RequestMapping("/regist")
public class RegistController {

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	@Autowired
	private IUserDao userDao;
	
	//회원유형선택
	@GetMapping("/selectMemberType")
	public String registForm() {
		return "user/selectMemberType";
	}
	
	//약관 동의
	@GetMapping("/terms")
	public String terms(@RequestParam("role")String role, Model model) {
		model.addAttribute("role", role);
		return "user/terms";
	}
	
	//정보입력 폼 페이지
	@GetMapping("/userRegistForm")
	public String userRegistForm(@RequestParam("role")String role, Model model) {
		model.addAttribute("role", role);
		return "user/userRegistForm";
	}
	
	//아이디 중복확인
	@PostMapping("/check-username")
	public @ResponseBody String checkUsername(@RequestParam("username")String username) {
		UserDto user = userDao.findByUsername(username);
		if(user != null) {
			return "이미 사용중인 아이디입니다.";
		}
		return "사용가능한 아이디입니다.";
	}
	
	//유효성 검사 및 insert
	@PostMapping("/regist")
	public String regist(UserJoinDto joinUser, Model model) {
		
		if(!joinUser.getPassword().equals(joinUser.getPasswordCheck())) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "user/userRegistForm";
		}
		String encodedPassword = bCryptPasswordEncoder.encode(joinUser.getPassword());
		
		if(joinUser.getRrn_front() == null || joinUser.getRrn_front().length() != 6 || joinUser.getRrn_back() == null || joinUser.getRrn_back().length() != 7) {
			model.addAttribute("msg", "주민번호를 확인해주세요.");
			return "user/userRegistForm";
		}
		
		String rrn_gender = joinUser.getRrn_back().substring(0, 1);
		String rrn_tail = joinUser.getRrn_back().substring(1);
		String encryptedRrnTail;
        try {
            encryptedRrnTail = AESUtil.encrypt(rrn_tail);
        } catch (Exception e) {
            model.addAttribute("msg", "주민번호 암호화에 실패했습니다.");
            return "user/userRegistForm";
        }
		
		UserDto user = new UserDto();
		user.setName(joinUser.getName());
		user.setUsername(joinUser.getUsername());
		user.setPassword(encodedPassword);
		
		user.setRrn_front(joinUser.getRrn_front());
		user.setRrn_gender(rrn_gender);
		user.setRrn_tail_enc(encryptedRrnTail);
		
		user.setZip_code(joinUser.getZip_code());
		user.setAddress1(joinUser.getAddress1());
		user.setAddress2(joinUser.getAddress2());
		
		user.setRole(joinUser.getRole());
		
		userDao.insertMember(user);
		
		return "user/userLogin";
	}
}
