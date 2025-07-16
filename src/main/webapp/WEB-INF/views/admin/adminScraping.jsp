<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/adminstyle.css">
</head>
<body>
<jsp:include page="../fragments/header.jsp"></jsp:include>
	<div class="inner">
		<h1>관리자 스크래핑</h1>
		<hr>
		<button id="crawlBtn">신한카드 크롤링 실행</button>
	</div>
	
<script src="/js/adminHeader.js"></script>
<script>
document.getElementById("crawlBtn").addEventListener("click", function() {
    fetch("/admin/card/scrap", {
        method: "POST"
    })
    .then(res => res.text())
    .then(msg => {
        alert(msg);
    })
    .catch(err => {
        alert("오류 발생: " + err);
    });
});
</script>
</body>
</html>