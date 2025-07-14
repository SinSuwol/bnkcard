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
	<h3>매일 쓰는 소비에, 매달 받는 보상</h2>
	<img style="width:200px;" src="/image/card1.png">
</div>

<div class="container">
	  <div class="spacer">
	  	<p class="txt" style="color:skyblue">SKY BLUE</p>
	  	<p class="txt" style="color:orange">ORANGE</p>
	  	<p class="txt" style="color:green">GREEN</p>
	  	<p class="txt" style="color:purple">PURPLE</p>
	  	<p class="txt" style="color:yellow">YELLOW</p>
	  	<p class="txt" style="color:pink">RED</p>
	  	<p class="txt" style="color:skyblue">SKY BLUE</p>
	  	<p class="txt" style="color:orange">ORANGE</p>
	  	<p class="txt" style="color:green">GREEN</p>
	  	<p class="txt" style="color:purple">PURPLE</p>
	  	<p class="txt" style="color:yellow">YELLOW</p>
	  	<p class="txt" style="color:pink">RED</p>
	  </div>
      <div class="wrapper">
            <div class="descriptions">
                  <div class="title">TITLE ONE</div>
                  <div class="title">TITLE TWO</div>
                  <div class="title">TITLE THREE</div>
                  <div class="title">TITLE FOUR</div>
            </div>
            <div class="content">
              <div class="track"></div>
                  <div class="item"><img class="child" src="/image/card1.png"></div>
                  <div class="item"><img class="child" src="/image/card2.png"></div>
                  <div class="item"><img class="child" src="/image/card3.png"></div>
                  <div class="item"><img class="child" src="/image/card4.png"></div>
                  <div class="item"><img class="child" src="/image/card5.png"></div>
                  <div class="item"><img class="child" src="/image/card6.png"></div>
                  <div class="item"><img class="child" src="/image/card1.png"></div>
                  <div class="item"><img class="child" src="/image/card2.png"></div>
                  <div class="item"><img class="child" src="/image/card3.png"></div>
                  <div class="item"><img class="child" src="/image/card4.png"></div>
                  <div class="item"><img class="child" src="/image/card5.png"></div>
                  <div class="item"><img class="child" src="/image/card6.png"></div>
            </div>    
           
      </div>
</div>
<div style="text-align: center"><button class="previous">previous</button> <button class="next">next</button></div>
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
</script>	
</body>
</html>