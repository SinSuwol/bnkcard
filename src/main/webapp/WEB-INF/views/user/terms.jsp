<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 약관동의</title>
<style>
body {
	font-family: sans-serif;
}
.scroll-box {
	width: 100%;
	max-height: 200px;
	padding: 10px;
	border: 1px solid #ccc;
	overflow: auto;
	background-color: #f9f9f9;
	font-size: 14px;
	white-space: pre-wrap; /* 줄바꿈 처리 */
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
}
.terms-section {
	margin-bottom: 30px;
}
.radio-group {
	margin-top: 10px;
	text-align: right;
}
.center-text {
	text-align: center;
	font-weight: bold; /* 필요시 강조 */
}
</style>
</head>
<body>
<h1>회원가입</h1>
<h2>약관동의</h2>

<div class="terms-section">
	<h3>회원약관</h3>
	<div class="scroll-box">
		<p class="center-text">홈페이지 회원약관</p>
		<p>${term1}</p>
	</div>
	<div class="radio-group">
		<span>위의 내용에 동의하십니까?</span>
		<input type="radio" name="term1Agreement" value="Y">동의함
		<input type="radio" name="term1Agreement" value="N" checked>동의하지않음		
	</div>
</div>
<div class="terms-section">
	<h3>개인정보처리취급방침</h3>
	<div class="scroll-box">
		<p class="center-text">개인정보처리취급방침</p>
		<p>${term2}</p>
	</div>
	<div class="radio-group">
		<span>위의 내용에 동의하십니까?</span>
		<input type="radio" name="term2Agreement" value="Y">동의함
		<input type="radio" name="term2Agreement" value="N" checked>동의하지않음		
	</div>
</div>
<button type="button" onclick="nextPage()">다음</button>
<button type="button" onclick="cancelRegist()">취소</button>

<script>
	function nextPage(){
		const role = "${role}";
		
		const term1 = document.querySelector('input[name="term1Agreement"]:checked');
		const term2 = document.querySelector('input[name="term2Agreement"]:checked');
		
		if(!term1 || term1.value !== 'Y'){
			alert("회원약관에 동의해 주세요.");
			return;
		}
		
		if(!term2 || term2.value !== 'Y'){
			alert("개인정보처리취급방침에 동의해 주세요.");
			return;
		}
		
		location.href = "/regist/userRegistForm?role=" + role;
	}

	function cancelRegist(){
		alert("회원가입 신청을 취소하시겠습니까?");
		location.href = "/regist/selectMemberType";
	}
</script>
</body>
</html>