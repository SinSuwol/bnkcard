package com.busanbank.card.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminSearchDao {

	// 조회
    List<Map<String, Object>> getRecommendedWords();	// 추천어 조회
    List<Map<String, Object>> getProhibitedWords();		// 금칙어 조회
    List<Map<String, Object>> getTopKeywords();			// 인기 검색어 조회
    List<Map<String, Object>> getRecentSearchLogs();	// 최근 검색어 30개
    
    // 추천어
    void insertRecommended(Map<String, Object> param);	// 추천어 등록
    void updateRecommended(Map<String, Object> param);	// 추천어 수정
    void deleteRecommended(Long id);					// 추천어 삭제

    // 금칙어
    void insertProhibited(Map<String, Object> param);	// 금칙어 등록
    void updateProhibited(Map<String, Object> param);	// 금칙어 수정
    void deleteProhibited(Long id);						// 금칙어 삭제
}
