<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body>
<header>
	<div class="header inner flex">
		<a href="/" class="main-logo">
			<img class="logo_img" src="https://www.busanbank.co.kr/resource/img/tit/h1_busanbank_new.png" alt="메인로고">
		</a>
		<ul class="flex nav">
			<li><a href="/cardList">카드</a></li>
			<li><a href="/introduce">은행소개</a></li>
			<li><a href="/faq">고객센터</a></li>
			<li><a href="/admin" id="load-admin">관리자 페이지로</a> <br></li>
			<li><a href="/admin/adminLoginForm" >관리자 로그인 페이지로</a></li>
		</ul>
		<div class="login-box">
			<a href="/user/login">로그인</a>
		</div>
	</div>
</header>
<div class="video-wrapper">
	<video autoplay muted loop playsinline class="banner-video">
	       <source src="/video/BCcard.mp4" type="video/mp4">
	       브라우저가 비디오 태그를 지원하지 않습니다.
	</video>
</div>
<div class="inner main-wrap">
	<h1>메인페이지</h1>
	<hr>
	<div style="height: 800px;"></div>
</div>
<script>
	window.addEventListener('scroll', function() {
	    const header = document.querySelector('header');
	    if (window.scrollY > 50) {
	        header.classList.add('scrolled');
	    } else {
	        header.classList.remove('scrolled');
	    }
	});
</script>	
</body>
</html>