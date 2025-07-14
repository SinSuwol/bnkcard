<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<jsp:include page="/WEB-INF/views/fragments/mainheader.jsp" />
<div class="main-content">
<h1>고객센터(faq페이지)</h1>
<hr>
</div>

<script>
	let remainingSeconds = ${remainingSeconds};
</script>
<script src="/js/sessionTime.js"></script>
</body>
</html>