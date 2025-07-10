package com.busanbank.card.faq.dao;

import com.busanbank.card.faq.dto.FaqDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class FaqDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int countFaqs(String keyword) {
        String sql = """
            SELECT COUNT(*)
              FROM FAQ
             WHERE FAQ_QUESTION LIKE '%' || ? || '%'
                OR FAQ_ANSWER LIKE '%' || ? || '%'
        """;

        return jdbcTemplate.queryForObject(
                sql,
                Integer.class,
                keyword,
                keyword
        );
    }
    public List<FaqDto> searchFaqsWithPaging(String keyword, int startRow, int endRow) {
        String sql = """
            SELECT * FROM (
                SELECT ROWNUM AS rnum, A.* 
                  FROM (
                        SELECT FAQ_NO, FAQ_QUESTION, FAQ_ANSWER,
                               REG_DATE, WRITER, ADMIN, CATTEGORY
                          FROM FAQ
                         WHERE FAQ_QUESTION LIKE '%' || ? || '%'
                            OR FAQ_ANSWER LIKE '%' || ? || '%'
                         ORDER BY FAQ_NO
                       ) A
                 WHERE ROWNUM <= ?
            )
            WHERE rnum >= ?
        """;

        return jdbcTemplate.query(
                sql,
                (rs, rowNum) -> mapRow(rs),
                keyword,
                keyword,
                endRow,
                startRow
        );
    }

    
    
    /**
     * FAQ 전체 조회
     */
    public List<FaqDto> getAllFaqs() {
        String sql = """
            SELECT FAQ_NO, FAQ_QUESTION, FAQ_ANSWER,
                   REG_DATE, WRITER, ADMIN, CATTEGORY
              FROM FAQ
            ORDER BY FAQ_NO
        """;

        return jdbcTemplate.query(sql, (rs, rowNum) -> mapRow(rs));
    }

    /**
     * FAQ 등록
     */
    public void insertFaq(FaqDto dto) {
        String sql = """
            INSERT INTO FAQ (
                FAQ_NO, FAQ_QUESTION, FAQ_ANSWER,
                REG_DATE, WRITER, ADMIN, CATTEGORY
            )
            VALUES (
                FAQ_SEQ.NEXTVAL, ?, ?, SYSDATE, ?, ?, ?
            )
        """;

        jdbcTemplate.update(sql,
            dto.getFaqQuestion(),
            dto.getFaqAnswer(),
            dto.getWriter(),
            dto.getAdmin(),
            dto.getCattegory()
        );
    }

    /**
     * FAQ 수정
     */
    public void updateFaq(FaqDto dto) {
        String sql = """
            UPDATE FAQ
               SET FAQ_QUESTION = ?,
                   FAQ_ANSWER = ?,
                   WRITER = ?,
                   ADMIN = ?,
                   CATTEGORY = ?
             WHERE FAQ_NO = ?
        """;

        jdbcTemplate.update(sql,
            dto.getFaqQuestion(),
            dto.getFaqAnswer(),
            dto.getWriter(),
            dto.getAdmin(),
            dto.getCattegory(),
            dto.getFaqNo()
        );
    }

    /**
     * FAQ 삭제
     */
    public void deleteFaq(Long faqNo) {
        String sql = """
            DELETE FROM FAQ
             WHERE FAQ_NO = ?
        """;

        jdbcTemplate.update(sql, faqNo);
    }

    /**
     * ResultSet → FaqDto 매핑
     */
    private FaqDto mapRow(ResultSet rs) throws SQLException {
        return new FaqDto(
            (int)rs.getLong("FAQ_NO"),
            rs.getString("FAQ_QUESTION"),
            rs.getString("FAQ_ANSWER"),
            rs.getDate("REG_DATE"),
            rs.getString("WRITER"),
            rs.getString("ADMIN"),
            rs.getString("CATTEGORY")
        );
    }
    
    public FaqDto getFaqById(int faqNo) {
        String sql = """
            SELECT FAQ_NO, FAQ_QUESTION, FAQ_ANSWER,
                   REG_DATE, WRITER, ADMIN, CATTEGORY
            FROM FAQ
            WHERE FAQ_NO = ?
        """;

        return jdbcTemplate.queryForObject(
            sql,
            (rs, rowNum) -> new FaqDto(
                (int) rs.getLong("FAQ_NO"),
                rs.getString("FAQ_QUESTION"),
                rs.getString("FAQ_ANSWER"),
                rs.getDate("REG_DATE"),
                rs.getString("WRITER"),
                rs.getString("ADMIN"),
                rs.getString("CATTEGORY")
            ),
            faqNo
        );
    }

    
    public List<FaqDto> searchFaqs(String keyword) {
        String sql = """
            SELECT FAQ_NO, FAQ_QUESTION, FAQ_ANSWER,
                   REG_DATE, WRITER, ADMIN, CATTEGORY
              FROM FAQ
             WHERE FAQ_QUESTION LIKE '%' || ? || '%'
                OR FAQ_ANSWER LIKE '%' || ? || '%'
            ORDER BY FAQ_NO
        """;

        return jdbcTemplate.query(
            sql,
            (rs, rowNum) -> mapRow(rs),
            keyword,
            keyword
        );
    }
}
