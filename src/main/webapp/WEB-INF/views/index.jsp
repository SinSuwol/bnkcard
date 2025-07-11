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
	<div class="video-container">
	    <!-- 흐릿한 배경용 영상 -->
	    <video autoplay muted loop playsinline class="back-video">
	        <source src="/video/bannerVideo.mp4" type="video/mp4">
	    </video>
	
	    <!-- 선명한 전경 영상 -->
	    <video autoplay muted loop playsinline class="banner-video">
	        <source src="/video/bannerVideo.mp4" type="video/mp4">
	    </video>
	
	    <!-- 텍스트나 버튼 등 추가 가능 -->
	    <div class="overlay-text">
	        <h1 class="red">플러스, &nbsp</h1>
	        <h1> 그 이상의 혜택</h1>
	    </div>
	</div>
</div>
<div class="inner main-wrap flex">
	<h1>동백PLUS 체크카드</h1>
	<h3>매일 쓰는 소비에, 매달 받는 보상</h2>
	<img style="width:200px;" src="/image/card1.png">
	<div style="height:800px;"></div>
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