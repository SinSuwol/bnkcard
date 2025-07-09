package com.busanbank.card.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.busanbank.card.admin.dao.IAdminSearchDao;

@RestController
@RequestMapping("/admin/Search")
public class AdminSearchController {

	@Autowired
	private IAdminSearchDao adminSearchDao;

	// 추천어 목록
	@GetMapping("/recommended")
	public List<Map<String, Object>> getRecommendedWords() {
		return adminSearchDao.getRecommendedWords();
	}

	// 금칙어 목록
	@GetMapping("/prohibited")
	public List<Map<String, Object>> getProhibitedWords() {
		return adminSearchDao.getProhibitedWords();
	}

	// 인기 검색어 TOP10
	@GetMapping("/top")
	public List<Map<String, Object>> getTopKeywords() {
		return adminSearchDao.getTopKeywords();
	}

	// 최근 검색어 30건
	@GetMapping("/recent")
	public List<Map<String, Object>> getRecentSearchLogs() {
		return adminSearchDao.getRecentSearchLogs();
	}

	// ========== 추천어 CRUD ==========
	// 추천어 등록
	@PostMapping("/recommended")
	public void insertRecommended(@RequestBody Map<String, Object> param) {
		adminSearchDao.insertRecommended(param);
	}

	// 추천어 수정
	@PutMapping("/recommended/{id}")
	public void updateRecommended(@PathVariable("id") Long id, @RequestBody Map<String, Object> param) {
		param.put("id", id);
		adminSearchDao.updateRecommended(param);
	}

	// 추천어 삭제
	@DeleteMapping("/recommended/{id}")
	public void deleteRecommended(@PathVariable("id") Long id) {
		adminSearchDao.deleteRecommended(id);
	}

	// ========== 금칙어 CRUD ==========

	// 금칙어 등록
	@PostMapping("/prohibited")
	public void insertProhibited(@RequestBody Map<String, Object> param) {
		adminSearchDao.insertProhibited(param);
	}

	// 금칙어 수정
	@PutMapping("/prohibited/{id}")
	public void updateProhibited(@PathVariable("id") Long id, @RequestBody Map<String, Object> param) {
		param.put("id", id);
		adminSearchDao.updateProhibited(param);
	}

	// 금칙어 삭제
	@DeleteMapping("/prohibited/{id}")
	public void deleteProhibited(@PathVariable("id") Long id) {
		adminSearchDao.deleteProhibited(id);
	}
}
