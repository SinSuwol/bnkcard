package com.busanbank.card.admin.controller;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.*;

@RestController
@RequestMapping("/admin/Search/stats")
public class SearchStatsController {

	private final JdbcTemplate jdbcTemplate;

	public SearchStatsController(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	// 1) 회원/비회원 검색 비율
	@GetMapping("/userType")
	public Map<String, Object> getUserTypeStats() {
		String sql = """
				    SELECT
				      CASE WHEN MEMBER_NO IS NULL THEN 'nonmember' ELSE 'member' END AS user_type,
				      COUNT(*) AS cnt
				    FROM SEARCH_LOG
				    GROUP BY CASE WHEN MEMBER_NO IS NULL THEN 'nonmember' ELSE 'member' END
				""";
		List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);

		Map<String, Object> result = new HashMap<>();
		result.put("member", 0);
		result.put("nonmember", 0);

		for (Map<String, Object> row : rows) {
			String type = (String) row.get("user_type");
			Long count = ((Number) row.get("cnt")).longValue();
			result.put(type, count);
		}
		return result;
	}

	// 2) 최근 7일간 검색 추이
	@GetMapping("/trend")
	public List<Map<String, Object>> getTrend() {
		LocalDate today = LocalDate.now();
		LocalDate sevenDaysAgo = today.minusDays(6);

		String sql = """
				    SELECT
				      TO_CHAR(SEARCH_DATE, 'YYYY-MM-DD') AS search_day,
				      COUNT(*) AS total,
				      SUM(CASE WHEN MEMBER_NO IS NULL THEN 1 ELSE 0 END) AS nonmember,
				      SUM(CASE WHEN MEMBER_NO IS NOT NULL THEN 1 ELSE 0 END) AS member
				    FROM SEARCH_LOG
				    WHERE SEARCH_DATE >= TO_DATE(?, 'YYYY-MM-DD')
				    GROUP BY TO_CHAR(SEARCH_DATE, 'YYYY-MM-DD')
				    ORDER BY search_day ASC
				""";
		return jdbcTemplate.query(sql, (rs, i) -> {
			Map<String, Object> map = new HashMap<>();
			map.put("date", rs.getString("search_day"));
			map.put("total", rs.getInt("total"));
			map.put("member", rs.getInt("member"));
			map.put("nonmember", rs.getInt("nonmember"));
			return map;
		}, sevenDaysAgo.toString());
	}

	// 3) 인기 검색어 (회원/비회원)
	@GetMapping("/top")
	public List<Map<String, Object>> getTopKeywords(@RequestParam("type") String type) {
		boolean isMember = "member".equalsIgnoreCase(type);
		String condition = isMember ? "MEMBER_NO IS NOT NULL" : "MEMBER_NO IS NULL";

		String sql = """
				    SELECT
				      KEYWORD,
				      COUNT(*) AS cnt
				    FROM SEARCH_LOG
				    WHERE %s
				    GROUP BY KEYWORD
				    ORDER BY cnt DESC
				    FETCH FIRST 5 ROWS ONLY
				""".formatted(condition);

		return jdbcTemplate.query(sql, (rs, i) -> {
			Map<String, Object> map = new HashMap<>();
			map.put("keyword", rs.getString("KEYWORD"));
			map.put("count", rs.getInt("cnt"));
			return map;
		});
	}

	// 4) 최근 1개월 기간별 검색량
	@GetMapping("/byDate")
	public List<Map<String, Object>> getStatsByDate() {
		String sql = """
					SELECT
					  TO_CHAR(SEARCH_DATE, 'YYYY-MM-DD') AS search_day,
					  COUNT(*) AS cnt
					FROM SEARCH_LOG
					WHERE SEARCH_DATE >= TRUNC(SYSDATE - 30)
					GROUP BY TO_CHAR(SEARCH_DATE, 'YYYY-MM-DD')
					ORDER BY search_day ASC
				""";

		return jdbcTemplate.query(sql, (rs, i) -> {
			Map<String, Object> map = new HashMap<>();
			map.put("date", rs.getString("search_day"));
			map.put("count", rs.getInt("cnt"));
			return map;
		});
	}

	// 5) 오늘의 시간대별 검색량
	@GetMapping("/byHour")
	public List<Map<String, Object>> getStatsByHour() {
		String sql = """
								    SELECT
				  TO_CHAR(SEARCH_DATE, 'HH24') AS hour,
				  COUNT(*) AS cnt
				FROM SEARCH_LOG
				WHERE TRUNC(SEARCH_DATE) = TRUNC(SYSDATE)
				GROUP BY TO_CHAR(SEARCH_DATE, 'HH24')
				ORDER BY hour ASC
								""";

		return jdbcTemplate.query(sql, (rs, i) -> {
			Map<String, Object> map = new HashMap<>();
			map.put("hour", rs.getString("hour"));
			map.put("count", rs.getInt("cnt"));
			return map;
		});
	}

	// 7) 최근 7일 시간대별 검색량
	@GetMapping("/byHour7Days")
	public List<Map<String, Object>> getStatsByHour7Days() {
	    String sql = """
	        SELECT
	          TO_CHAR(SEARCH_DATE, 'HH24') AS hour,
	          COUNT(*) AS cnt
	        FROM SEARCH_LOG
	        WHERE SEARCH_DATE >= TRUNC(SYSDATE) - 6
	        GROUP BY TO_CHAR(SEARCH_DATE, 'HH24')
	        ORDER BY hour ASC
	    """;

	    return jdbcTemplate.query(sql, (rs, i) -> {
	        Map<String, Object> map = new HashMap<>();
	        map.put("hour", rs.getString("hour"));
	        map.put("count", rs.getInt("cnt"));
	        return map;
	    });
	}

	  @GetMapping("/recommendedConversionRate")
	    public Map<String, Object> getRecommendedConversionRate() {
	        String sql = """
	            SELECT
	              (SELECT COUNT(*) FROM SEARCH_LOG
	               WHERE SEARCH_DATE >= TRUNC(SYSDATE) - 30) AS total_searches,
	              (SELECT COUNT(*) FROM SEARCH_LOG
	               WHERE SEARCH_DATE >= TRUNC(SYSDATE) - 30
	                 AND IS_RECOMMENDED = 'Y') AS recommended_searches
	            FROM DUAL
	        """;

	        return jdbcTemplate.queryForObject(sql, (rs, i) -> {
	            long total = rs.getLong("total_searches");
	            long recommended = rs.getLong("recommended_searches");
	            double rate = total == 0 ? 0 : (double) recommended / total * 100;

	            Map<String, Object> result = new HashMap<>();
	            result.put("total", total);
	            result.put("recommended", recommended);
	            result.put("conversionRate", Math.round(rate * 100) / 100.0); // 소수점 2자리
	            return result;
	        });
	    }

}
