<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>FAQ 목록</title>
    <link rel="stylesheet" href="/css/adminstyle.css">
    <style>
        /* 제목 */
       h2 {
            text-align: center;
            font-size: 1.8rem;
            color: #2c3e50;
            padding-top: 40px;
            margin-bottom:30px;
        }

        /* 검색 폼 */
        form {
            margin-bottom: 20px;
            text-align: center;
        }

        form input[type="text"] {
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 240px;
        }

        form button {
            padding: 8px 14px;
            background-color: white;
            color: black;
            border: 1px solid black;
            border-radius: 4px;
            margin-left: 8px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        form button:hover {
            text-decoration: underline;
            text-decoration-color: white;
        }

        /* 등록 버튼 */
        a[href$="insertForm"] {
            display: block;
            width: fit-content;
            margin: 0 auto 16px;
            background-color: #c22800;
            color: white;
            padding: 8px 12px;
            text-decoration: none;
            border-radius: 4px;
        }

        a[href$="insertForm"]:hover {
            text-decoration: underline;
            text-decoration-color: white;
        }

        /* 테이블 */
        table {
            width: 60%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
            margin: 0 auto;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
        	font-size:24px;
            background-color: #f2f2f2;
            color: #2c3e50;
            white-space: nowrap; 
        }

        /* 관리 링크 */
        td a {
            margin-right: 10px;
            color: #c22800;
            text-decoration: none;
        }

        td a:hover {
            text-decoration: underline;
        }

        /* 페이징 */
        div.pagination {
            text-align: center;
            margin-top: 20px;
            font-size: 1rem;
        }

        div.pagination a,
        div.pagination strong {
            display: inline-block;
            margin: 0 5px;
            color: #555;
            text-decoration: none;
        }

        div.pagination a:hover {
            font-weight: bold;
            color: #000;
        }

        div.pagination strong {
            color: #e74c3c;
        }
    </style>
</head>
<body>
<jsp:include page="../../fragments/header.jsp"></jsp:include>
<h2>FAQ 목록</h2>

<form method="get" action="${pageContext.request.contextPath}/admin/faq/list">
    <input type="text" name="keyword" placeholder="검색어 입력" value="${keyword}">
    <button type="submit">검색</button>
</form>

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

<div class="pagination">
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

<script src="/js/adminHeader.js"></script>
</body>
</html>
