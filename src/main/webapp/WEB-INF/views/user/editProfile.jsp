<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 정보 수정</title>
<link rel="stylesheet" href="/css/style.css">
<style>
body {
    font-family: "맑은 고딕", sans-serif;
    background-color: #fff;
    color: #333;
}

.content-wrapper {
    max-width: 800px;
    margin: 100px auto 0;
    padding: 40px 30px 60px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

.content-wrapper h2 {
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 20px;
}

.content-wrapper hr {
    border: none;
    border-bottom: 1px solid #ddd;
    margin-bottom: 30px;
}

/* 폼 테이블 */
form#updateForm table {
    width: 100%;
    border-collapse: collapse;
}

form#updateForm th,
form#updateForm td {
    padding: 12px 10px;
    text-align: left;
    vertical-align: middle;
}

form#updateForm th {
    width: 30%;
    font-weight: 600;
    color: #555;
    background-color: #f7f7f7;
    border-radius: 6px 0 0 6px;
}

form#updateForm td input[type="text"],
form#updateForm td input[type="password"] {
    width: 100%;
    padding: 8px 12px;
    border: 1.5px solid #ccc;
    border-radius: 6px;
    font-size: 1rem;
    transition: border-color 0.3s ease;
}

form#updateForm td input[type="text"]:focus,
form#updateForm td input[type="password"]:focus {
    border-color: #c10c0c;
    outline: none;
    box-shadow: 0 0 5px rgba(193,12,12,0.3);
}

form#updateForm td span {
    font-size: 0.85rem;
    color: #888;
    margin-left: 8px;
}

/* 비밀번호 에러 메시지 */
#pwErrorMsg {
    color: red;
    font-weight: 600;
    font-size: 0.9rem;
    padding-left: 10px;
    margin-top: 4px;
    min-height: 20px;
}

/* 버튼 그룹 */
.button-group {
    text-align: center;
    margin-top: 40px;
}

.button-group button {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    margin: 0 8px;
}

.button-group button:first-child {
    background-color: #c10c0c;
    color: white;
}

.button-group button:last-child {
    background-color: #f2f2f2;
    color: #333;
}

</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/fragments/mainheader2.jsp" />
<!-- <div style="height: 150px;"></div> -->
<div class="content-wrapper">
	<h2>개인 정보 수정</h2>
	<hr>
	<form id="updateForm" action="/user/update" method="post">
		<table>
			<tr>
				<th>성명(실명)</th>
				<td><input type="text" name="name" id="name" value="${loginUser.name}" readonly></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="username" id="username" value="${loginUser.username}" readonly></td>
			</tr>
			<tr>
				<th>새 비밀번호</th>
				<td><input type="password" name="password" id="password" onblur="validatePassword()"><span> ※ 영문자, 숫자, 특수문자 포함 8~12자 이내 (영문, 숫자, 특수문자 조합)</span></td>
			</tr>
			<tr>
				<th>새 비밀번호 확인</th>
				<td>
					<input type="password" name="passwordCheck" id="passwordCheck" onblur="checkPasswordMatch()">
					<span> ※ 비밀번호 재입력</span>
					<div id="pwErrorMsg"></div>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type="text" name="zipCode" id="zipCode" value="${loginUser.zipCode}"><br>
					<input type="text" name="address1" id="address1" value="${loginUser.address1}"><br>
					<input type="text" name="address2" id="address2" value="${loginUser.address2}">
				</td>
			</tr>
		</table>
		<input type="hidden" name="role" value="${role}">
		<div class="button-group">
			<button type="button" onclick="editProfile()">수정</button>
			<button type="button" onclick="cancelEdit()">취소</button>
		</div>
	</form>
	<c:if test="${not empty msg}">
	    <script>
	        alert("${msg}");
	    </script>
	</c:if>
</div>
<script src="/js/header2.js"></script>
<script>
	let remainingSeconds = ${remainingSeconds};

	//비밀번호 유효성 검사
	function isPasswordValid(password){
		const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+[\]{}|\\;:'",.<>?/`~\-]).{8,12}$/;
		return pwRegex.test(password);
	}
	
	function validatePassword(){
		const oldPw = "${loginUser.password}";
		const password = document.getElementById("password");
		const pwErrorMsg = document.getElementById("pwErrorMsg");
		
		if(!password.value.trim()){
			pwErrorMsg.textContent = "";
			return;
		}

		if(oldPw === password.value){
			pwErrorMsg.textContent = "현재 비밀번호와 일치합니다.";
		    pwErrorMsg.style.color = "red";
		    password.focus();
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
	
	//수정 버튼
	function editProfile(){
		const form = document.getElementById("updateForm");
		
		//비밀번호 검사
		const password = document.getElementById("password");
		const passwordCheck = document.getElementById("passwordCheck");

		//비밀번호를 입력하였을 때
		if(password.value.trim()){
			//비밀번호 확인란 검사
			if(!passwordCheck.value.trim()){
				alert("비밀번호를 확인하세요.");
				passwordCheck.focus();
				return;
			}
			//유효성 검사
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
			
		//주소 검사
		if(!document.getElementById("zipCode").value.trim() || !document.getElementById("address1").value.trim() || !document.getElementById("address2").value.trim()) {
			alert("주소를 입력해주세요.");
			document.getElementById("zipCode").focus();
			return;
		}
		
		form.submit();
	}
	
	//취소버튼
	function cancelEdit(){
		alert("정보 수정을 취소하겠습니까?");
		location.href = "/user/mypage";
	}
</script>

<script src="/js/sessionTime.js"></script>
</body>
</html>