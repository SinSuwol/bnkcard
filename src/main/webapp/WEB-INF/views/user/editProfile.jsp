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
.main-content {
  padding-top: 130px; /* 💡 fixed header + top-bar 높이 고려 */
  margin: 0 30px;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/fragments/mainheader.jsp" />
<div class="main-content">
	<h1>개인 정보 수정</h1>
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
				<td><input type="password" name="passwordCheck" id="passwordCheck" onblur="checkPasswordMatch()"><span> ※ 비밀번호 재입력</span></td>
			</tr>
			<tr>
				<th></th>
				<td><div id="pwErrorMsg"></div></td>
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
		<button type="button" onclick="editProfile()">수정</button>
		<button type="button" onclick="cancelEdit()">취소</button>
	</form>
	<c:if test="${not empty msg}">
	    <script>
	        alert("${msg}");
	    </script>
	</c:if>
</div>
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