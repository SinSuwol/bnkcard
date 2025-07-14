<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/carousel.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/Draggable.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/MotionPathPlugin.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/InertiaPlugin.min.js"></script>



</head>
<body>
<jsp:include page="/WEB-INF/views/fragments/mainheader.jsp" />
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
	<h2>'가성비'와 '가심비'를 모두 만족하는 프리미엄 경험</h2>
	<p>매일 쓰는 소비에, 매달 받는 보상</p>
	<img style="width:200px;" src="/image/CARD 1.png">
	<div class="carousel">
		  <div class="spacer">
		  	<div class="txt-box">
		  		<p class="color-txt" style="color:skyblue">SKY BLUE</p>
		  		<p class="desc"> 내가 고르는 선택의 즐거움</p>
		  	</div>
		  	<div class="txt-box">
		  		<p class="color-txt" style="color:orange">ORANGE</p>
		  		<p class="desc"> 내가 고르는 선택의 즐거움</p>
		  	</div>
		  	<div class="txt-box">
		  		<p class="color-txt" style="color:green">GREEN</p>
		  		<p class="desc"> 내가 고르는 선택의 즐거움</p>
		  	</div>
		  	<div class="txt-box">
		  		<p class="color-txt" style="color:purple">PURPLE</p>
		  		<p class="desc"> 내가 고르는 선택의 즐거움</p>
		  	</div>
		  	<div class="txt-box">
		  		<p class="color-txt" style="color:yellow">YELLOW</p>
		  		<p class="desc"> 내가 고르는 선택의 즐거움</p>
		  	</div>
		  	<div class="txt-box">
		  		<p class="color-txt" style="color:pink">RED</p>
		  		<p class="desc"> 내가 고르는 선택의 즐거움</p>
		  	</div>
		  	<div class="txt-box">
		  		<p class="color-txt" style="color:skyblue">SKY BLUE</p>
		  		<p class="desc"> 내가 고르는 선택의 즐거움</p>
		  	</div>
		  	<div class="txt-box">
		  		<p class="color-txt" style="color:orange">ORANGE</p>
		  		<p class="desc"> 내가 고르는 선택의 즐거움</p>
		  	</div>
		  	<div class="txt-box">
		  		<p class="color-txt" style="color:green">GREEN</p>
		  		<p class="desc"> 내가 고르는 선택의 즐거움</p>
		  	</div>
		  	<div class="txt-box">
		  		<p class="color-txt" style="color:purple">PURPLE</p>
		  		<p class="desc"> 내가 고르는 선택의 즐거움</p>
		  	</div>
		  	<div class="txt-box">
		  		<p class="color-txt" style="color:yellow">YELLOW</p>
		  		<p class="desc"> 내가 고르는 선택의 즐거움</p>
		  	</div>
		  	<div class="txt-box">
		  		<p class="color-txt" style="color:pink">RED</p>
		  		<p class="desc"> 내가 고르는 선택의 즐거움</p>
		  	</div>
		  	
		  </div>
	      <div class="wrapper">
	           
            <div class="content">
	              <div class="track"></div>
	                  <div class="item"><img class="child" src="/image/CARD 1.png"></div>
	                  <div class="item"><img class="child" src="/image/CARD 2.png"></div>
	                  <div class="item"><img class="child" src="/image/CARD 3.png"></div>
	                  <div class="item"><img class="child" src="/image/CARD 4.png"></div>
	                  <div class="item"><img class="child" src="/image/CARD 5.png"></div>
	                  <div class="item"><img class="child" src="/image/CARD 6.png"></div>
	                  <div class="item"><img class="child" src="/image/CARD 1.png"></div>
	                  <div class="item"><img class="child" src="/image/CARD 2.png"></div>
	                  <div class="item"><img class="child" src="/image/CARD 3.png"></div>
	                  <div class="item"><img class="child" src="/image/CARD 4.png"></div>
	                  <div class="item"><img class="child" src="/image/CARD 5.png"></div>
	                  <div class="item"><img class="child" src="/image/CARD 6.png"></div>
	            </div>    
	           
	      </div>
	<button class="previous">previous</button> <button class="next">next</button>
	
	</div>
	<h2 class="bubble-title t1">혜택은 명확하게</h2>
	<h2 class="bubble-title t2">어디서나 간편하게</h2>
	<div class="bubble-wrap flex">
		<div class="hover-target-wrapper">
			<div class="hover-target b1">
				<img src="/image/웃는얼굴.png">
				<p>연회비 무료</p>
			</div>
			<div class="tooltip">툴팁1</div>
		</div>
		<div class="hover-target-wrapper">
			<div class="hover-target b2">
				<img src="/image/버스.png">
				<p>후불 교통카드</p>
			</div>
			<div class="tooltip">툴팁2</div>
		</div>
		<div class="hover-target-wrapper">
			<div class="hover-target b3">
				<img src="/image/atm.png">
				<p>수수료 무료</p>
			</div>
			<div class="tooltip">툴팁3</div>
		</div>
		<div class="hover-target-wrapper">
			<div class="hover-target b4">
				<img src="/image/번개.png">
				<p>빠른 On/Off</p>
			</div>
			<div class="tooltip">툴팁4</div>
		</div>
	</div>
</div>

<script src="/js/carousel.js"></script>
<script>
	window.addEventListener('scroll', function() {
	    const header = document.querySelector('header');
	    if (window.scrollY > 50) {
	        header.classList.add('scrolled');
	    } else {
	        header.classList.remove('scrolled');
	    }
	});
	
	
	const wrappers = document.querySelectorAll('.hover-target-wrapper');

	wrappers.forEach(wrapper => {
	  const target = wrapper.querySelector('.hover-target');
	  const tooltip = wrapper.querySelector('.tooltip');

	  target.addEventListener('mouseenter', () => {
	    tooltip.style.opacity = 1;
	  });

	  target.addEventListener('mouseleave', () => {
	    tooltip.style.opacity = 0;
	  });

	  target.addEventListener('mousemove', (e) => {
	    tooltip.style.left = `\${e.clientX + 10}px`;
	    tooltip.style.top = `\${e.clientY + 10}px`;
	  });
	});
</script>	
</body>
</html>