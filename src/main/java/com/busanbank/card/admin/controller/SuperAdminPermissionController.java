package com.busanbank.card.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.busanbank.card.admin.dto.AdminDto;
import com.busanbank.card.admin.dto.PermissionDto;
import com.busanbank.card.admin.service.SuperAdminPermissionService;
import com.busanbank.card.admin.session.AdminSession;
import com.busanbank.card.card.dto.CardDto;

@RestController
@RequestMapping("/superadmin/permission")
public class SuperAdminPermissionController {

	@Autowired
	private SuperAdminPermissionService permissionService;

	@Autowired
	private AdminSession adminSession;

	// 리스트 조회
	@GetMapping("/list")
	public List<PermissionDto> getList() {
		return permissionService.getPermissionList();
	}

	// TEMP 카드 정보 조회
	@GetMapping("/temp/{cardNo}")
	public CardDto getTempCard(@PathVariable("cardNo") Long cardNo) {
		return permissionService.getCardTemp(cardNo);
	}

	// 승인 처리
	@PostMapping("/approve")
	public Map<String, Object> approve(@RequestBody CardDto dto) {
		AdminDto loginAdmin = adminSession.getLoginUser();
		if (loginAdmin == null) {
			throw new IllegalStateException("로그인이 필요합니다.");
		}

		boolean success = permissionService.approveCard(dto, loginAdmin.getUsername());
		return Map.of("success", success, "message", success ? "카드를 승인했습니다." : "승인 실패");
	}

	// 보류/불허 처리
	@PostMapping("/reject")
	public Map<String, Object> reject(@RequestParam("cardNo") Long cardNo, @RequestParam("status") String status,
			@RequestParam("reason") String reason) {
		AdminDto loginAdmin = adminSession.getLoginUser();
		if (loginAdmin == null) {
			throw new IllegalStateException("로그인이 필요합니다.");
		}

		boolean success = permissionService.rejectCard(cardNo, status, reason, loginAdmin.getUsername());
		return Map.of("success", success, "message", success ? status + " 처리 완료" : "처리 실패");
	}
}
