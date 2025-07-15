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
			<td><input type="text" name="username" id="username"> <button type="button" onclick="checkUsername()">중복확인</button></td>
		</tr>
		<tr>
			<th></th>
			<td><div id="idErrorMsg"></div></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="password" id="password" onblur="validatePassword()"><span> ※ 영문자, 숫자, 특수문자 포함 8~12자 이내 (영문, 숫자, 특수문자 조합)</span></td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" name="passwordCheck" id="passwordCheck" onblur="checkPasswordMatch()"><span> ※ 비밀번호 재입력</span></td>
		</tr>
		<tr>
			<th></th>
			<td><div id="pwErrorMsg"></div></td>
		</tr>
		<tr>
			<th>주민번호</th>
			<td><input type="text" name="rrnFront" id="rrnFront"> - <input type="password" name="rrnBack" id="rrnBack"></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" name="zipCode" id="zipCode"><br>
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" name="address1" id="address1"><br>
				<input type="text" name="address2" id="address2">
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
	//아이디 중복확인
	const idErrorMsg = document.getElementById("idErrorMsg");
	function checkUsername(){
		const username = document.getElementById("username").value.trim();
		
		if(!username){
			idErrorMsg.textContent = "아이디를 입력해주세요.";
			idErrorMsg.style.color = "red";
			return;
		}
		
		const xhr = new XMLHttpRequest();
		xhr.onload = function(){
			const msg = xhr.responseText;
			idErrorMsg.textContent = msg;
			if(msg.includes("이미")){
				idErrorMsg.style.color = "red";
			}
			else{
				idErrorMsg.style.color = "green";				
			}
		}
		xhr.open("POST", "/regist/check-username");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("username=" + username);
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
		if(idErrorMsg.textContent === ""){
			alert("아이디 중복 확인을 해주세요.");
			return;
		}
		if(idErrorMsg.textContent === "이미 사용중인 아이디입니다."){
			alert("아이디를 확인 해주세요.");
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
			
		//주민등록번호 검사
		if(!document.getElementById("rrnFront").value.trim() || !document.getElementById("rrnBack").value.trim()) {
			alert("주민등록번호를 입력해주세요.");
			document.getElementById("rrnFront").focus();
			return;
		}
		
		//주소 검사
		if(!document.getElementById("zipCode").value.trim() || !document.getElementById("address1").value.trim() || !document.getElementById("address2").value.trim()) {
			alert("주소를 입력해주세요.");
			document.getElementById("zipCode").focus();
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