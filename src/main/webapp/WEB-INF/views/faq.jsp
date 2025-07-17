<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- null-safe JS 변수용 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="rs" value="${empty remainingSeconds ? 0 : remainingSeconds}" />

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>고객센터 FAQ</title>
    <link rel="stylesheet" href="${ctx}/css/style.css"><!-- 공통 css -->

    <style>
    :root {
        --bnk-red: #d6001c;
        --bnk-red-dark: #bb0018;
        --bnk-gray-bg: #f5f6f8;
        --bnk-gray-border: #d5d7db;
        --bnk-gray-text: #555;
        --bnk-gray-text-light: #777;
        --bnk-radius: 6px;
        --bnk-transition: 0.15s;
        --bnk-max-width: 1000px;
        --bnk-cat-bg: #e9ecef;
        --bnk-cat-text: #444;
        --bnk-cat-radius: 10px;
    }

    body {
        background: var(--bnk-gray-bg);
        margin: 0;
        font-family: 'Noto Sans KR', '맑은 고딕', sans-serif;
        color: #000;
    }

    /* 메인 레이아웃 */
    .main-content {
        padding-top: 130px; /* 헤더 높이 고려 */
        margin: 0 auto;
        width: 100%;
        max-width: var(--bnk-max-width);
        padding-left: 30px;
        padding-right: 30px;
        box-sizing: border-box;
    }

    .main-content h1 {
        margin-top: 0;
        font-size: 28px;
        font-weight: 700;
        color: #000;
    }

    hr {
        border: none;
        border-top: 1px solid var(--bnk-gray-border);
        margin: 16px 0 24px;
    }

    /* 검색 폼 */
    .faq-search-form {
        display: flex;
        align-items: center;
        gap: 8px;
        max-width: 400px;
    }
    .faq-search-form input[type="text"] {
        flex: 1;
        padding: 8px 10px;
        font-size: 15px;
        border: 1px solid var(--bnk-gray-border);
        border-radius: var(--bnk-radius);
        box-sizing: border-box;
    }
    .faq-search-form button {
        padding: 8px 16px;
        font-size: 15px;
        font-weight: 600;
        color: #fff;
        background: var(--bnk-red);
        border: none;
        border-radius: var(--bnk-radius);
        cursor: pointer;
        transition: background var(--bnk-transition);
    }
    .faq-search-form button:hover {
        background: var(--bnk-red-dark);
    }

    /* 테이블 래퍼 - 모바일 스크롤 */
    .faq-table-wrapper {
        margin-top: 16px;
        overflow-x: auto;
        border: 1px solid var(--bnk-gray-border);
        border-radius: var(--bnk-radius);
        background:#fff;
    }

    table.faq-table {
        width: 100%;
        border-collapse: collapse;
        min-width: 600px; /* 좁은 화면에서 가로스크롤 발생 */
        font-size: 15px;
    }

    table.faq-table thead th {
        background: var(--bnk-red);
        color: #fff;
        padding: 10px;
        text-align: left;
        font-weight: 700;
        border-bottom: 1px solid var(--bnk-red-dark);
        white-space: nowrap;
    }

    table.faq-table tbody td {
        padding: 10px;
        border-bottom: 1px solid var(--bnk-gray-border);
        vertical-align: top;
    }

    table.faq-table tbody tr:nth-child(odd) {
        background:#fafbfc;
    }

    table.faq-table tbody tr:hover {
        background:#fff3f3;
    }

    table.faq-table th:first-child,
    table.faq-table td:first-child {
        width: 60px;
        white-space: nowrap;
        text-align:center;
    }

    .faq-cat {
        display:inline-block;
        padding: 2px 10px;
        font-size: 13px;
        background: var(--bnk-cat-bg);
        color: var(--bnk-cat-text);
        border-radius: var(--bnk-cat-radius);
        white-space: nowrap;
    }

    .faq-answer {
        white-space: pre-wrap;
        line-height:1.4;
        color: var(--bnk-gray-text);
    }

    .faq-paging {
        margin-top: 24px;
        font-size: 16px;
    }
    .faq-paging a {
        margin: 0 4px;
        text-decoration: none;
        color: var(--bnk-red);
        font-weight:600;
    }
    .faq-paging a:hover {
        text-decoration: underline;
    }
    .faq-paging strong {
        margin: 0 4px;
        color: #000;
    }

    /* 🔻 아래 두 블록은 더 이상 필요 없음 (페이지별 FAB 제거)
    .chatbot-fab { ... }
    .sr-only { ... }
    */

    /* 공통 챗봇 모달 FAB 색상 덮어쓰기 (선택) */
    #chatbotFab {
        background: var(--bnk-red) !important;
    }
    #chatbotFab:hover {
        background: var(--bnk-red-dark) !important;
    }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragments/mainheader2.jsp" />

    <div class="main-content">
        <h1>고객센터 (FAQ)</h1>
        <hr>

        <!-- 검색 -->
        <form class="faq-search-form" method="get" action="${ctx}/faq/list">
            <input type="text" name="keyword" placeholder="검색어를 입력하세요" value="${keyword}">
            <button type="submit">검색</button>
        </form>

        <!-- FAQ 테이블 -->
        <div class="faq-table-wrapper">
            <table class="faq-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>질문</th>
                        <th>답변</th>
                        <th>카테고리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="faq" items="${faqList}">
                        <tr>
                            <td>${faq.faqNo}</td>
                            <td>${faq.faqQuestion}</td>
                            <td class="faq-answer">${faq.faqAnswer}</td>
                            <td><span class="faq-cat">${faq.cattegory}</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 페이징 -->
        <div class="faq-paging">
            <c:forEach var="i" begin="1" end="${totalPage}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <strong>[${i}]</strong>
                    </c:when>
                    <c:otherwise>
                        <a href="${ctx}/faq/list?keyword=${keyword}&page=${i}">[${i}]</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div><!-- /.main-content -->

    <script src="${ctx}/js/header2.js"></script>
    <script>
        // 세션 남은시간 (초), JSTL null-safe
        let remainingSeconds = ${rs};
    </script>
    <script src="${ctx}/js/sessionTime.js"></script>

    <!-- 🔽 공통 챗봇 모달 컴포넌트 include -->
     <jsp:include page="/WEB-INF/views/fragments/chatbotModal.jsp" />
</body>
</html>



<!--
추가하고 싶으면
 <jsp:include page="/WEB-INF/views/fragments/chatbotModal.jsp">
    <jsp:param name="contextPath" value="${ctx}" />
</jsp:include>
 -->

