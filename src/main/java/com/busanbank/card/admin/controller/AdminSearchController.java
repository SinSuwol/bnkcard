package com.busanbank.card.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
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

	    // 전체 검색 로그
	    @GetMapping("/logs")
	    public List<Map<String, Object>> getSearchLogs() {
	        return adminSearchDao.getSearchLogs();
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
	
}
