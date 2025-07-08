<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>관리자페이지</h1>
<hr>

<a href="/admin/CardList">상품목록</a>
<a href="/admin/adminCardRegistForm">상품등록</a>
<a href="/admin/Impression">상품인가</a>
<a href="/admin/Search">검색어관리</a>
<a href="">스크래핑</a>
<a href="">FAQ관리</a>
<a href="/admin/Mainpage">메인페이지로</a>
<button id="logoutBtn">로그아웃</button>


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