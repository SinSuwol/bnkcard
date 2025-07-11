<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
<style>
body {
	font-family: sans-serif;
	margin: 30px;
}
.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}
.title {
	font-size: 1.2em;
	font-weight: bold;
}
.card-box {
	border: 1px solid #ccc;
	padding: 30px;
	text-align: center;
	margin-bottom: 20px;
}
.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}
nav ul {
	list-style: none;
	display: flex;
	gap: 15px;
	margin: 0;
	padding: 0;
}
nav a {
	text-decoration: none;
	color: #333;
}
</style>
</head>
<body>
<div class="top-bar">
	<h1>${loginUser.name}님의 페이지</h1>
	<nav>
		<ul>
			<li>(로그인 인증 시간)</li>
			<li><a href="#" onclick="logout()">로그아웃</a></li>
		</ul>	
	</nav>
	<form id="logoutForm" action="/logout" method="post" style="display:none;"></form>
</div>
<div>
	<div class="header">
		<div class="title">카드 구매 내역 및 신청 내역</div>
		<a href="/user/editProfile">개인 정보 수정</a>
	</div>
	<div class="card-box highlight">
		<p>내 카드</p>
	</div>
	<div class="card-box">
		<p>카드 신청 내역</p>
	</div>
</div>
<div>
	<div class="header">
		<div class="title">
			<a href="#">내 문의</a>
		</div>
	</div>
</div>

<script>
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){
			document.getElementById("logoutForm").submit();
		}
	}
</script>
</body>
</html>