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
</style>
</head>
<body>
<h1>${loginUser.name}님의 페이지</h1>
<div>
	<div class="header">
		<div class="title">카드 구매 내역 및 신청 내역</div>
		<a href="/user/editProfile">개인 정보 수정</a>
	</div>
	<div class="card-box highlight">
		<p>구매 상품 리스트</p>
	</div>
	<div class="card-box">
		<p>카드 신청 리스트</p>
	</div>
</div>
<div>
	<div class="header">
		<div class="title">
			<a href="#">내 문의</a>
		</div>
	</div>
</div>
</body>
</html>