<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body>
<jsp:include page="../fragments/header.jsp"></jsp:include>
<div class="login-container">
    <h2>관리자 로그인</h2>
    <form id="loginForm">
        <input type="text" id="username" placeholder="아이디" required>
        <input type="password" id="password" placeholder="비밀번호" required>
        <button type="submit">로그인</button>
    </form>
</div>
<script src="/js/adminHeader.js"></script>
<script>
document.getElementById("loginForm").addEventListener("submit", function(e) {
    e.preventDefault();

    const data = {
        username: document.getElementById("username").value,
        password: document.getElementById("password").value
    };

    fetch("/admin/login", {
        method: "POST",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify(data)
    })
    .then(response => {
        if (!response.ok) {
            return response.json().then(err => {throw err;});
        }
        return response.json();
    })
    .then(result => {
        if (result.success) {
            alert(result.message);
            // 로그인 성공 시 관리자 메인 페이지로 이동
            window.location.href = "/admin";
        } else {
            alert(result.message);
        }
    })
    .catch(error => {
        alert("로그인 오류: " + (error.message || "서버 오류"));
        console.error(error);
    });
});
</script>
</body>
</html>