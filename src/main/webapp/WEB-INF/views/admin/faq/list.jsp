<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>FAQ 목록</title>
</head>
<body>
    <h2>FAQ 목록</h2>

    <form method="get" action="${pageContext.request.contextPath}/admin/faq/list">
        <input type="text" name="keyword" placeholder="검색어 입력" value="${keyword}">
        <button type="submit">검색</button>
    </form>

    <br>
    <a href="${pageContext.request.contextPath}/admin/faq/insertForm">FAQ 등록</a>

    <table border="1">
        <tr>
            <th>번호</th>
            <th>질문</th>
            <th>답변</th>
            <th>관리</th>
        </tr>
        <c:forEach var="faq" items="${faqList}">
            <tr>
                <td>${faq.faqNo}</td>
                <td>${faq.faqQuestion}</td>
                <td>${faq.faqAnswer}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/faq/editForm?faqNo=${faq.faqNo}">수정</a>
                    <a href="${pageContext.request.contextPath}/admin/faq/delete?faqNo=${faq.faqNo}">삭제</a>
                </td>
            </tr>
        </c:forEach>
    </table>

    <br>
    <div>
        <c:forEach var="i" begin="1" end="${totalPage}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <strong>[${i}]</strong>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/admin/faq/list?keyword=${keyword}&page=${i}">
                        [${i}]
                    </a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</body>
</html>
