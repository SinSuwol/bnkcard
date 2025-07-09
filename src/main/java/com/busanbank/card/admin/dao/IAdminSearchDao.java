package com.busanbank.card.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminSearchDao {

    List<Map<String, Object>> getRecommendedWords();
    List<Map<String, Object>> getProhibitedWords();
    List<Map<String, Object>> getSearchLogs();
    List<Map<String, Object>> getTopKeywords();
    List<Map<String, Object>> getRecentSearchLogs();
}
