package com.busanbank.card;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.busanbank.card.card.dto.CardDto;
import com.busanbank.card.card.service.CardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor // final 필드 주입용
public class MainController {

	private final CardService cardService;
	// 여기가 페이지 이동기능 모아놓은 컨트롤러입니다.

	@GetMapping("/")
	public String root() {
		return "index";
	}

	@GetMapping("/admin")
	public String admin() {
		return "admin/admin";
	}

	@GetMapping("/cardList") // /cardList 요청
	public String cardList(Model model) {

		List<CardDto> list = cardService.getCardList();

		model.addAttribute("cardList", list);

		return "cardList";
	}
}
