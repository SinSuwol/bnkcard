<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>메인페이지</h1>
<hr>
<a href="#" id="load-admin">관리자 페이지로</a>

<script>
document.getElementById("load-admin").addEventListener("click", async (e) => {
    e.preventDefault();
    contentDiv.textContent = "불러오는 중...";
    const response = await fetch("/api/admin");
    const data = await response.json();
    contentDiv.textContent = data.message;
});
</script>
</body>
</html>