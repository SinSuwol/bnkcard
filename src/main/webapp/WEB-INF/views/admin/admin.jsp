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
<h1>관리자페이지</h1>
<hr>



<img class="img" src="https://i3.ruliweb.com/img/21/02/19/177b605e043265ad2.jpeg">


<script src="/js/adminHeader.js"></script>
<script>



document.getElementById("logoutBtn").addEventListener("click", function() {
    if (!confirm("로그아웃 하시겠습니까?")) return;

    fetch("/admin/logout", {
        method: "POST",
        credentials: "include" // 세션 쿠키 포함
    })
    .then(response => response.json())
    .then(result => {
        if (result.success) {
            alert(result.message);
            window.location.href = "/admin/adminLoginForm"; // 로그인 페이지로 이동
        } else {
            alert(result.message);
        }
    })
    .catch(error => {
        alert("로그아웃 오류: " + (error.message || "서버 오류"));
        console.error(error);
    });
});
</script>


</body>
</html>