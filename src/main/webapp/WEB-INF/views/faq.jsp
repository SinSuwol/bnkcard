<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/style.css">
<style>
.main-content {
  padding-top: 130px; /* 💡 fixed header + top-bar 높이 고려 */
  margin: 0 30px;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/fragments/mainheader2.jsp" />
<div class="main-content">
<h1>고객센터(faq페이지)</h1>
<hr>
</div>


<c:if test="${not empty sessionScope.loginUsername}">
    <button onclick="location.href='/user/chat/page'">실시간 상담하기</button>
</c:if>


<script src="/js/header2.js"></script>
<script>
	let remainingSeconds = ${remainingSeconds};
</script>
<script src="/js/sessionTime.js"></script>
</body>
</html>