<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>고객센터 FAQ</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .main-content {
            padding-top: 130px;
            margin: 0 30px;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragments/mainheader2.jsp" />

    <div class="main-content">
        <h1>고객센터 (FAQ 페이지)</h1>
        <hr>

        <form method="get" action="${pageContext.request.contextPath}/faq/list">
            <input type="text" name="keyword" placeholder="검색어 입력" value="${keyword}">
            <button type="submit">검색</button>
        </form>

        <br>

        <table border="1" width="100%" cellpadding="8" cellspacing="0">
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
                        <td>${faq.faqAnswer}</td>
                        <td>${faq.cattegory}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <br>

        <div>
            <c:forEach var="i" begin="1" end="${totalPage}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <strong>[${i}]</strong>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/faq/list?keyword=${keyword}&page=${i}">
                            [${i}]
                        </a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>

    <c:if test="${not empty sessionScope.loginUsername}">
        <button onclick="location.href='/user/chat/page'">실시간 상담하기</button>
    </c:if>

    <script src="/js/header2.js"></script>
    <script>
        let remainingSeconds = ${remainingSeconds != null ? remainingSeconds : 0};
    </script>
    <script src="/js/sessionTime.js"></script>

</body>
</html>
