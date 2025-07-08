package com.busanbank.card.admin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.busanbank.card.admin.dto.AdminDto;
import com.busanbank.card.admin.service.AdminService;
import com.busanbank.card.admin.session.AdminSession;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/admin")
@RestController
public class AdminLoginController {

    @Autowired
    private AdminService adminService;
    
    @Autowired
    private AdminSession adminSession;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody AdminDto request, HttpSession session) {
        try {
            // 1) 인증 처리
            AdminDto admin = adminService.login(request.getUsername(), request.getPassword());

            // 2) AdminSession에 로그인 정보 세팅
            adminSession.login(admin, session);

            // 3) 세션 유효시간 설정
            session.setMaxInactiveInterval(20 * 60); // 20분

            // 4) 응답 데이터 구성
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("message", "로그인 성공");
            result.put("user", admin);

            return ResponseEntity.ok(result);

        } catch (RuntimeException e) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(result);
        }
    }

    
    @PostMapping("/logout")
    public ResponseEntity<Map<String, Object>> logout(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        if (!adminSession.isLoggedIn()) {
            result.put("success", false);
            result.put("message", "이미 로그아웃 상태입니다.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result);
        }

        adminSession.logout(session);

        result.put("success", true);
        result.put("message", "로그아웃 되었습니다.");
        return ResponseEntity.ok(result);
    }
}
