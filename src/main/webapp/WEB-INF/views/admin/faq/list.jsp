<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>FAQ 목록</title>
</head>
<body>
    <h2>FAQ 목록</h2>
    <a href="insertForm">FAQ 등록</a>
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
                    <a href="editForm?faqNo=${faq.faqNo}">수정</a>
                    <a href="delete?faqNo=${faq.faqNo}">삭제</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
