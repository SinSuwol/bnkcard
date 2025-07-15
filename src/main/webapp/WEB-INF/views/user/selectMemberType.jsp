<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 회원유형선택</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f8f8f8;
	color: #222;
}

/* 헤더 아래 컨텐츠 여백 */
.content-wrapper {
	padding: 130px 40px 40px 40px; /* 헤더 고려 상단 여백 */
	max-width: 1200px;
	margin: 0 auto;
}

/* 제목 스타일 */
.content-wrapper h1 {
	font-size: 28px;
	margin-bottom: 10px;
}

.content-wrapper h2 {
	font-size: 20px;
	color: #444;
	margin-bottom: 20px;
}

/* === 회원유형 선택 박스 === */
.member-type-container {
	display: flex;
	gap: 20px;
}

.member-type {
	width: 240px;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 12px;
	text-align: left;
	text-decoration: none;
	color: #000;
	background-color: #fff;
	box-shadow: 0 2px 5px rgba(0,0,0,0.05);
	transition: all 0.2s ease;
	cursor: pointer;
}

.member-type:hover {
	box-shadow: 0 6px 16px rgba(0,0,0,0.1);
	transform: translateY(-4px);
}

.title {
	font-size: 18px;
	font-weight: 600;
	margin-bottom: 8px;
}

.desc {
	font-size: 14px;
	color: #666;
	line-height: 1.5;
}
</style>
<body>
<jsp:include page="/WEB-INF/views/fragments/mainheader.jsp" />
<div class="content-wrapper">
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
</div>
</body>
</html>