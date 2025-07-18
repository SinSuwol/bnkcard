<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<header>
	<div class="header inner flex">
		<a href="/" class="main-logo">
			<img class="logo_img" src="https://www.busanbank.co.kr/resource/img/tit/h1_busanbank_new.png" alt="메인로고">
		</a>
		<ul class="flex nav">
			<li><a href="/cardList">카드</a></li>
			<li><a href="/introduce">은행소개</a></li>
			<li><a href="/faq/list">고객센터</a></li>
			<li><a href="/admin/adminLoginForm" >관리자 로그인 페이지로</a></li>
		</ul>
		
		<div class="user-bar flex">
			<c:if test="${not empty loginUser}">
				<div class="user-info flex">
				    <a class="user-name" href="/user/mypage">${loginUser.name}</a>
				    <span class="session-timer-box" id="session-timer"></span>
				    <button id="extend-btn" onclick="extend()">연장</button>
			    </div>
			</c:if>
			<div class="login-box">
				<c:choose>
					<c:when test="${not empty loginUser}">
						<a href="/logout">로그아웃</a>
					</c:when>
					<c:otherwise>
						<a class="header-login-btn" href="/user/login">로그인</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</header>