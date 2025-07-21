<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>FAQ 등록</title>
<link rel="stylesheet" href="/css/adminstyle.css">
<style>
h2 {
	text-align: center;
	font-size: 1.8rem;
	color: #2c3e50;
	padding-top: 40px;
}

form {
	max-width: 600px;
	margin: 30px auto;
	padding: 30px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.08);
	display: flex;
	flex-direction: column; /* 전체는 세로 */
	gap: 16px;
}

.form-group {
	display: flex;
	align-items: center; /* 수직 가운데 정렬 */
	gap: 16px;
}

.form-group label {
	width: 100px;
	font-weight: bold;
	color: #34495e;
}

.form-group input[type="text"], .form-group textarea {
	flex: 1; /* 입력창이 넓게 */
	padding: 10px 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 1rem;
	box-sizing: border-box;
}

.form-group textarea {
	resize: vertical;
}

button[type="submit"] {
	padding: 12px;
	background-color: #c22800;
	color: white;
	font-size: 1rem;
	font-weight: bold;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.3s;
}

button[type="submit"]:hover {
	background-color: #a31f00;
	text-decoration: underline;
	text-decoration-color: white;
}
</style>
</head>
<body>
	<jsp:include page="../../fragments/header.jsp"></jsp:include>

	<h2>FAQ 등록</h2>

	<form action="/admin/faq/add" method="post">
		<div class="form-group">
			<label for="faqQuestion">질문</label> <input type="text"
				id="faqQuestion" name="faqQuestion">
		</div>
		<div class="form-group">
			<label for="faqAnswer">답변</label>
			<textarea id="faqAnswer" name="faqAnswer" oninput="autoResize(this)"></textarea>
		</div>
		<div class="form-group">
			<label for="writer">작성자</label> <input type="text" id="writer"
				name="writer">
		</div>
		<div class="form-group">
			<label for="admin">관리자</label> <input type="text" id="admin"
				name="admin">
		</div>
		<div class="form-group">
			<label for="cattegory">카테고리</label>
			<div style="display: flex; gap: 20px;">
				<label><input type="radio" name="cattegory" value="카드"
					required> 카드</label> <label><input type="radio"
					name="cattegory" value="예적금"> 예적금</label>
			</div>
		</div>
		<button type="submit">등록</button>
	</form>

	<script src="/js/adminHeader.js"></script>

	<script>
    function autoResize(textarea) {
        textarea.style.height = "auto"; // 높이 초기화
        textarea.style.height = textarea.scrollHeight + "px"; // 내용만큼 높이 조절
    }
    
window.addEventListener("DOMContentLoaded", () => {
    const textarea = document.getElementById("faqAnswer");
    if (textarea) autoResize(textarea); // 초기값에도 적용
});
</script>
</body>
</html>
