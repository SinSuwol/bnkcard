<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="/css/style.css">
<style>
body {
  margin: 0;
  padding: 0;
  font-family: sans-serif;
}

.main-content {
  padding-top: 130px; /* 💡 fixed header + top-bar 높이 고려 */
  margin: 0 30px;
}

.page-section {
  margin-bottom: 30px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.section-header .title {
  font-size: 1.2em;
  font-weight: bold;
}

.card-box {
  border: 1px solid #ccc;
  padding: 30px;
  text-align: center;
  margin-bottom: 20px;
}

nav a {
  text-decoration: none;
  color: #333;
}

</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/fragments/mainheader.jsp" />
<div class="main-content">
	<div>
		<div class="section-header">
			<div class="title">내 카드</div>
			<a href="/user/editProfile">개인 정보 수정</a>
		</div>
		<div class="card-box highlight">
			<p>내 카드 리스트</p>
		</div>
		<!-- <div class="card-box">
			<p>카드 신청 내역</p>
		</div> -->
	</div>
	<div>
		<div class="section-header">
			<div class="title">
				<a href="#">내 문의</a>
			</div>
		</div>
	</div>
</div>
<script>
	let remainingSeconds = ${remainingSeconds};
</script>
<script src="/js/sessionTime.js"></script>
</body>
</html>