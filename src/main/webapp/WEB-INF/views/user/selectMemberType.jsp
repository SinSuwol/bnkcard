<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 회원유형선택</title>
</head>
<style>
.member-type-container {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	margin-top: 30px;
}

.member-type {
	flex: 1;
	padding: 20px;
	border: 1px solid #ccc;
	border-radius: 20px;
	text-align: center;
	text-decoration: none;
	color: #000;
	transition: box-shadow 0.3s, transform 0.3s;
}

.member-type:hover {
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	transform: translateY(-5px);
}

.title {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 10px;
}

.desc {
	font-size: 14px;
	color: #555;
}
</style>
<body>
	<h1>회원가입</h1>
	<h2>회원유형선택</h2>
	<br>
	<div class="member-type-container">
		<a href="/regist/terms?role=ROLE_PERSON" class="member-type">
			<div class="title">일반회원(개인)</div>
			<div class="desc">영업점에서 인터넷뱅킹을 신청하지 않아도 홈페이지 신청 가능함</div>
		</a> <a href="/regist/terms?role=ROLE_OWNER" class="member-type">
			<div class="title">개인사업자</div>
			<div class="desc">개인이 운영하는 사업체를 가지고 계신 고객</div>
		</a> <a href="/regist/terms?role=ROLE_CORP" class="member-type">
			<div class="title">법인</div>
			<div class="desc">영리 또는 비영리를 목적으로 사업체를 가지고 계신 고객</div>
		</a>
	</div>
</body>
</html>