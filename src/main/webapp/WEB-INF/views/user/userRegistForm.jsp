<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 정보입력</title>
</head>
<body>

<h1>회원가입</h1>
<hr>
<form id="signupForm" action="/regist/regist" method="post">
	<table>
		<tr>
			<th>성명(실명)</th>
			<td><input type="text" name="name" id="name"></td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" name="username" id="username" onchange="resetUsernameCheck()" oninput="resetUsernameCheck()">
				<button type="button" id="checkBtn" onclick="checkUsername()">중복확인</button>
			</td>
		</tr>
		<tr>
			<th></th>
			<td><div id="idErrorMsg"></div></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="password" id="password" oninput="validatePassword()"><span> ※ 영문자, 숫자, 특수문자 포함 8~12자 이내 (영문, 숫자, 특수문자 조합)</span></td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" name="passwordCheck" id="passwordCheck" oninput="checkPasswordMatch()"><span> ※ 비밀번호 재입력</span></td>
		</tr>
		<tr>
			<th></th>
			<td><div id="pwErrorMsg"></div></td>
		</tr>
		<tr>
			<th>주민번호</th>
			<td><input type="text" name="rrnFront" id="rrnFront" maxlength="6" pattern="\d{6}">
			 - <input type="password" name="rrnBack" id="rrnBack" maxlength="7" pattern="\d{7}"></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" name="zipCode" id="zipCode" readonly>
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" name="address1" id="address1" readonly><br>
				<input type="text" name="extraAddress" id="extraAddress" readonly><br>
				<input type="text" name="address2" id="address2" placeholder="상세주소">
			</td>
		</tr>
	</table>
	<input type="hidden" name="role" value="${role}">
	<button type="button" onclick="validateAndSubmit()">등록</button>
	<button type="button" onclick="cancelRegist()">취소</button>
</form>
<c:if test="${not empty msg}">
    <script>
        alert("${msg}");
    </script>
</c:if>

<script>
	let usernameChecked = false; // 중복확인 완료 여부
	
	//아이디 입력이 바뀌었을 때 중복확인 상태 초기화
	function resetUsernameCheck() {
		usernameChecked = false;
		const checkBtn = document.getElementById("checkBtn");
		checkBtn.disabled = false;
		
		const idErrorMsg = document.getElementById("idErrorMsg");
		idErrorMsg.textContent = "아이디 중복 확인을 해주세요.";
		idErrorMsg.style.color = "red";
	}
	
	//아이디 중복확인
	function checkUsername(){
		const username = document.getElementById("username").value.trim();
		const idErrorMsg = document.getElementById("idErrorMsg");
		const checkBtn = document.getElementById("checkBtn");
		
		if(!username){
			idErrorMsg.textContent = "아이디를 입력해주세요.";
			idErrorMsg.style.color = "red";
			return;
		}
		
		const xhr = new XMLHttpRequest();
		xhr.onload = function(){
			const res = JSON.parse(xhr.responseText);
			idErrorMsg.textContent = res.msg;
			if(res.valid){
				idErrorMsg.style.color = "green";
				usernameChecked = true;
                checkBtn.disabled = true; // 중복확인 완료 → 버튼 비활성화
			}
			else{
				idErrorMsg.style.color = "red";	
				usernameChecked = false;
			}
		}
		xhr.open("POST", "/regist/check-username");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("username=" + username);
	}
	
	function changeUsername(){
		idErrorMsg.textContent = "아이디 중복 확인을 해주세요.";
		idErrorMsg.style.color = "red";
	}

	//비밀번호 유효성 검사
	function isPasswordValid(password){
		const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+[\]{}|\\;:'",.<>?/`~\-]).{8,12}$/;
		return pwRegex.test(password);
	}
	
	function validatePassword(){
		const password = document.getElementById("password");
		const pwErrorMsg = document.getElementById("pwErrorMsg");
		
		if(!password.value.trim()){
			pwErrorMsg.textContent = "";
			return;
		}
		if(!isPasswordValid(password.value)){
			pwErrorMsg.textContent = "비밀번호는 영문자, 숫자, 특수문자를 포함한 8~12자리여야 합니다.";
		    pwErrorMsg.style.color = "red";
		    password.focus();
		}
		else{
			pwErrorMsg.textContent = "사용가능한 비밀번호입니다.";	
			pwErrorMsg.style.color = "green";
		}
	}
	//비밀번호 확인
	function checkPasswordMatch(){
		const password = document.getElementById("password");
		const passwordCheck = document.getElementById("passwordCheck");
		const pwErrorMsg = document.getElementById("pwErrorMsg");
		
		if (!passwordCheck.value.trim()) {
			pwErrorMsg.textContent = "";
		    return;
		}
		if (password.value === passwordCheck.value) {
			pwErrorMsg.textContent = "비밀번호가 일치합니다.";
		    pwErrorMsg.style.color = "green";
		}
		else {
			pwErrorMsg.textContent = "비밀번호가 일치하지 않습니다.";
		    pwErrorMsg.style.color = "red";
		    passwordCheck.focus();
		}
	}
	
	function validateAndSubmit(){
		const form = document.getElementById("signupForm");
		
		//성명 유효성 검사
		const nameInput = document.getElementById("name");
		const nameValue = nameInput.value.trim();
		const nameRegex = /^[가-힣]{2,20}$/;

		if (!nameValue) {
			alert("성명을 입력해주세요.");
			nameInput.focus();
			return;
		}
		if (!nameRegex.test(nameValue)) {
			alert("성명은 한글 2~20자여야 합니다.");
			nameInput.focus();
			return;
		}
		//성명 검사
		if (!document.getElementById("name").value.trim()) {
			alert("성명을 입력해주세요.");
			document.getElementById("name").focus();
			return;
		}

		//아이디 검사
		if (!document.getElementById("username").value.trim()) {
			alert("아이디를 입력해주세요.");
			document.getElementById("username").focus();
			return;
		}
		if (!usernameChecked) {
			alert("아이디 중복 확인을 해주세요.");
			document.getElementById("checkBtn").focus();
			return;
		}
		
		//비밀번호 검사
		const password = document.getElementById("password");
		const passwordCheck = document.getElementById("passwordCheck");

		if(!password.value.trim()){
			alert("비밀번호를 입력해주세요.");
			password.focus();
			return;
		}
		if(!passwordCheck.value.trim()){
			alert("비밀번호를 확인하세요.");
			passwordCheck.focus();
			return;
		}
		if (password.value !== passwordCheck.value) {
			alert("비밀번호가 일치하지 않습니다.");
			passwordCheck.focus();
			return;
		}
		
		// 주민등록번호 유효성 검사
		const rrnFront = document.getElementById("rrnFront");
		const rrnBack = document.getElementById("rrnBack");

		const rrnFrontValue = rrnFront.value.trim();
		const rrnBackValue = rrnBack.value.trim();

		const rrnRegex6 = /^\d{6}$/;
		const rrnRegex7 = /^\d{7}$/;

		if (!rrnRegex6.test(rrnFrontValue)) {
			alert("주민등록번호 앞자리는 6자리 숫자여야 합니다.");
			rrnFront.focus();
			return;
		}

		if (!rrnRegex7.test(rrnBackValue)) {
			alert("주민등록번호 뒷자리는 7자리 숫자여야 합니다.");
			rrnBack.focus();
			return;
		}
		//주민등록번호 검사
		if(!document.getElementById("rrnFront").value.trim() || !document.getElementById("rrnBack").value.trim()) {
			alert("주민등록번호를 입력해주세요.");
			document.getElementById("rrnFront").focus();
			return;
		}
		
		//주소 검사
		if(!document.getElementById("zipCode").value.trim() || !document.getElementById("address1").value.trim()) {
			alert("주소를 입력해주세요.");
			document.getElementById("zipCode").focus();
			return;
		}
		if(!document.getElementById("address2").value.trim()){			
			alert("상세주소를 입력해주세요.");
			document.getElementById("address2").focus();
			return;
		}
		
		form.submit();
	}
	
	function cancelRegist(){
		alert("회원가입 신청을 취소하시겠습니까?");
		location.href = "/regist/selectMemberType";
	}
	
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/postcode.js"></script>
</body>
</html>