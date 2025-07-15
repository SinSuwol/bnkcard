<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 약관동의</title>
<link rel="stylesheet" href="/css/style.css">
<style>
body {
	font-family: "맑은 고딕", sans-serif;
	background-color: #fff;
	color: #333;
}

.content-wrapper {
	max-width: 800px;
	margin: 0 auto;
	padding: 120px 30px 60px;
}

.page-title {
	font-size: 20px;
	font-weight: 600;
	color: #333;
	margin-bottom: 6px;
}

.sub-title {
	font-size: 14px;
	color: #777;
	margin-bottom: 30px;
}

.terms-section {
	margin-bottom: 40px;
	border-top: 1px solid #ddd;
	padding-top: 20px;
}

/* 회원약관과 개인정보처리취급방침 사이 줄 없애기 위해, 두번째 terms-section에선 border-top 제거 */
.terms-section+.terms-section {
	border-top: none;
	margin-top: 0; /* 필요시 조절 */
	padding-top: 0;
}

.terms-section h3 {
	font-size: 16px; /* 크기 줄임 */
	margin-bottom: 16px; /* h3과 scroll-box 사이 간격 유지 */
}

.scroll-box {
	width: 100%;
	max-height: 200px;
	padding: 4px 15px 15px; /* 상단 패딩 더 줄임 */
	border: 1px solid #ccc;
	border-radius: 0; /* 각지게 */
	background-color: #f8f8f8;
	font-size: 14px;
	white-space: pre-wrap;
	overflow-y: auto;
	line-height: 1.6;
}

.scroll-box>p:first-child {
	text-align: center;
	margin-top: 0;
	margin-bottom: 12px;
}

.radio-group {
	margin-top: 12px;
	text-align: right;
	font-size: 14px;
}

.radio-group input {
	margin-left: 8px;
	margin-right: 2px;
}

.button-group {
	text-align: center; /* 가운데 정렬 */
	margin-top: 40px;
}

.button-group button {
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	font-size: 14px;
	cursor: pointer;
	margin: 0 8px; /* 좌우 여백 */
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
	<jsp:include page="/WEB-INF/views/fragments/mainheader.jsp" />
	<div class="content-wrapper">
		<h2 class="page-title">회원가입</h2>
		<p class="sub-title">약관에 동의해 주세요</p>

		<form id="termsForm" action="/regist/userRegistForm?role=${role}"
			method="post">
			<c:forEach var="term" items="${terms}">
				<div class="terms-section">
					<h3>
						${term.termType}
						<c:if test="${term.isRequired == 'Y'}">(필수)</c:if>
						<c:if test="${term.isRequired != 'Y'}">(선택)</c:if>
					</h3>
					<div class="scroll-box">
						<p>
							<strong>${term.termType}</strong>
						</p>
						<p>${term.content}</p>
					</div>
					<div class="radio-group">
						<span>위의 내용에 동의하십니까?</span> <label> <input type="radio"
							name="terms${term.termNo}" value="Y"
							<c:if test="${term.isRequired == 'Y'}">data-required="Y"</c:if>>동의함
						</label> <label> <input type="radio" name="terms${term.termNo}"
							value="N" checked
							<c:if test="${term.isRequired == 'Y'}">data-required="Y"</c:if>>동의하지
							않음
						</label>
					</div>
				</div>
			</c:forEach>

			<div class="button-group">
				<button type="button" onclick="nextPage()">다음</button>
				<button type="button" onclick="cancelRegist()">취소</button>
			</div>
		</form>
	</div>
<script>
	function nextPage() {
	    const form = document.getElementById("termsForm");
	
	    const requiredRadios = document.querySelectorAll('input[type="radio"][data-required="Y"]');
	    const requiredNames = new Set();
	    requiredRadios.forEach(radio => requiredNames.add(radio.name));
	
	    for (const termName of requiredNames) {
	        const selected = document.querySelector(`input[name="${termName}"]:checked`);
	        if (!selected || selected.value !== 'Y') {
	            alert('필수 약관에 동의해 주세요.');
	            return;  // 동의 안 하면 submit 안 함, 함수 종료
	        }
	    }
	
	    form.submit();
	}

	function cancelRegist(){
		if (confirm("회원가입 신청을 취소하시겠습니까?")) {
			location.href = "/regist/selectMemberType";
		}
	}
</script>
</body>
</html>
