<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<h1>회원가입</h1>
<hr>
<form id="signupForm" action="/user/regist" method="post">
	<table>
		<tr>
			<th>성명(실명)</th>
			<td><input type="text" name="name" id="name"></td>
		</tr>
		<tr>
			<th>아이디</th>
			<td><input type="text" name="username" id="username"> <button type="button" onclick="checkUsername()">중복확인</button><br>
				<div id="idErrorMsg"></div>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="password" id="password"><span> ※ 영문자,숫자, 특수문자 포함 8~12자 이내 (영문, 숫자, 특수문자 조합)</span></td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" name="passwordCheck" id="passwordCheck" onchange="checkPasswordMatch()"><span> ※ 비밀번호 재입력</span><br>
				<div id="pwErrorMsg"></div>
			</td>
		</tr>
		<tr>
			<th>주민번호</th>
			<td><input type="text" name="rrn_front" id="rrn_front"> - <input type="password" name="rrn_back" id="rrn_back"></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" name="zip_code" id="zip_code"><br>
				<input type="text" name="address1" id="address1"><br>
				<input type="text" name="address2" id="address2">
			</td>
		</tr>
	</table>
	<button type="button" onclick="validateAndSubmit()">등록</button>
	<button type="button" onclick="">취소</button>
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
		xhr.open("POST", "/user/check-username");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("username=" + username);
	}
	
	//비밀번호 확인
	function checkPasswordMatch(){
		const password = document.getElementById("password").value;
		const passwordCheck = document.getElementById("passwordCheck").value;
		const pwErrorMsg = document.getElementById("pwErrorMsg");
		
		if (!passwordCheck.trim()) {
			pwErrorMsg.textContent = "";
		    return;
		}

		if (password === passwordCheck) {
			pwErrorMsg.textContent = "비밀번호가 일치합니다.";
		    pwErrorMsg.style.color = "green";
		}
		else {
			pwErrorMsg.textContent = "비밀번호가 일치하지 않습니다.";
		    pwErrorMsg.style.color = "red";
		}
	}
	
	function validateAndSubmit(){
		const form = document.getElementById("signupForm");
		
		if (!document.getElementById("name").value.trim()) {
			alert("성명을 입력해주세요.");
			document.getElementById("name").focus();
			return;
		}

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
		
		if(!document.getElementById("password").value.trim()){
			alert("비밀번호를 입력해주세요.");
			password.focus();
			return;
		}
		if(!document.getElementById("passwordCheck").value.trim()){
			alert("비밀번호를 확인하세요.");
			password.focus();
			return;
		}
		
		if(!document.getElementById("rrn_front").value.trim() || !document.getElementById("rrn_back").value.trim()) {
			alert("주민등록번호를 입력해주세요.");
			document.getElementById("rrn_front").focus();
			return;
		}
		
		if(!document.getElementById("zip_code").value.trim() || !document.getElementById("address1").value.trim() || !document.getElementById("address2").value.trim()) {
			alert("주소를 입력해주세요.");
			document.getElementById("zip_code").focus();
			return;
		}
		
		form.submit();
	}
	
</script>
</body>
</html>