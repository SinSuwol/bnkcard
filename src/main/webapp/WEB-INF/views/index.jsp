<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/carousel.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/Draggable.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/MotionPathPlugin.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/InertiaPlugin.min.js"></script>
<script type="module" src="https://unpkg.com/@splinetool/viewer@latest/build/spline-viewer.js"></script>


</head>
<body class="main-body">
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
<div class="main-wrap flex">
	<div class="section">
		<h1 class="mainTit1">동백PLUS 체크카드</h1>
		<h2 class="mainTit2">'가성비'와 '가심비'를 모두 만족하는 프리미엄 경험</h2>
		<p class="mainTit3">매일 쓰는 소비에, 매달 받는 보상</p>
		<div class="spline-wrapper">
			<img src="/image/bnk프렌즈1.gif" class="bnk-gif bnk-gif1">
			<img src="/image/bnk프렌즈2.gif" class="bnk-gif bnk-gif2">
			<img src="/image/bnk프렌즈3.gif" class="bnk-gif bnk-gif3">
			<img src="/image/bnk프렌즈4.gif" class="bnk-gif bnk-gif4">
			<div class="confetti-wrapper">
			  <ul class="particles"></ul>
			</div>
			<spline-viewer orbit class="spline" scroll-blocking="false" url="https://prod.spline.design/uHGgQogk8z9Qb0Xz/scene.splinecode"></spline-viewer>
		</div>
	</div>
	<div class="section">
	
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
			  		<p class="color-txt" style="color:red">RED</p>
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
			  		<p class="color-txt" style="color:red">RED</p>
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
		<button class="carousel-btn previous"><i class="fas fa-chevron-left"></i></button>
		<button class="carousel-btn next"><i class="fas fa-chevron-right"></i></button>

	
		</div>
    </div>
    
    <div class="section section3">
    	<div class="inner">
			<h2 class="bubble-title t1">혜택은 명확하게</h2>
			<h2 class="bubble-title t2">어디서나 간편하게</h2>
			<div class="bubble-wrap flex">
				<div class="hover-target-wrapper">
					<div class="hover-target b1">
						<img src="/image/웃는얼굴.png">
						<p>연회비 무료</p>
					</div>
					<div class="tooltip">
						<img class="tooltip-img" src="/image/툴팁1.png" alt="툴팁 이미지">
						<div class="toolip-txt-box">
							<p>동백+ 체크카드는 연회비 무료!</p>
						</div>
					</div>
				</div>
				<div class="hover-target-wrapper">
					<div class="hover-target b2">
						<img src="/image/버스.png">
						<p>후불 교통카드</p>
					</div>
					<div class="tooltip">
						<img class="tooltip-img" src="/image/툴팁2.png" alt="툴팁 이미지">
						<div class="toolip-txt-box">
							<p>후불교통카드 기능은 그대로!</p>
						</div>
					</div>
				</div>
				<div class="hover-target-wrapper">
					<div class="hover-target b3">
						<img src="/image/atm.png">
						<p>수수료 무료</p>
					</div>
					<div class="tooltip">
						<img class="tooltip-img" src="/image/툴팁1.png" alt="툴팁 이미지">
						<div class="toolip-txt-box">
							<p>동백+ 체크카드는 연회비 무료!</p>
						</div>
					</div>
				</div>
				<div class="hover-target-wrapper">
					<div class="hover-target b4">
						<img src="/image/번개.png">
						<p>즉시 캐쉬백</p>
					</div>
					<div class="tooltip">
						<img class="tooltip-img" src="/image/툴팁1.png" alt="툴팁 이미지">
						<div class="toolip-txt-box">
							<p>동백+ 체크카드는 연회비 무료!</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</div>
<footer class="site-footer">
	<div class="inner footer-inner">
	  <div class="footer-links">
	    <a href="#">개인정보처리방침</a>
	    <span>·</span>
	    <a href="#">경영공시</a>
	    <span>·</span>
	    <a href="#">고객정보취급방침</a>
	    <span>·</span>
	    <a href="#">보호금융상품등록부</a>
	    <span>·</span>
	    <a href="#">상품공시실</a>
	    <span>·</span>
	    <a href="#">전자민원접수</a>
	    <span>·</span>
	    <a href="#">전자금융이용자보호수칙</a>
	    <span>·</span>
	    <a href="#">전자금융사기피해금환급제도</a>
	  </div>
	
	  <div class="footer-sub-links">
	    <a href="#">위치기반서비스 이용약관</a>
	  </div>
	
	  <div class="footer-contact">
	    고객상담 <strong>1588-6200, 1544-6200</strong>
	    &nbsp; | &nbsp;
	    해외 <strong>82-2-1588-6200</strong>
	  </div>
	
	  <div class="copyright">
	    COPYRIGHT © 2014 BUSANBANK. ALL RIGHTS RESERVED.
	  </div>
	  <div class="footer-bottom">
	    <div class="footer-icons">
	    	<a href="https://www.facebook.com/busanbank/"><img src="https://www.busanbank.co.kr/resource/img/ico/cmn/ico_footer_fb.png" alt="Facebook" /></a>
	      	<a href="https://www.instagram.com/bnk_busanbank/"><img src="https://www.busanbank.co.kr/resource/img/ico/cmn/ico_footer_in.png" alt="Instagram" /></a>
	      	<a href="https://www.youtube.com/c/Busanbankbnk"><img src="https://www.busanbank.co.kr/resource/img/ico/cmn/ico_footer_yt.png" alt="YouTube" /></a>
	      	<a href="https://www.webwatch.or.kr/Situation/WA_Situation.html?MenuCD=110"><img src="https://www.busanbank.co.kr/resource/img/etc/wa_mark.png" alt="WAS 인증" /></a>
	      
	      
	      
	    </div>
	    <div class="footer-dropdowns">
	      <select>
	        <option>BNK금융네트워크</option>
	        <!-- 추가 옵션 -->
	      </select>
	      <select>
	        <option>FAMILY SITE</option>
	        <!-- 추가 옵션 -->
	      </select>
	    </div>
	  </div>
	</div>
</footer>

<script src="/js/carousel.js"></script>
<script>

	


	//헤더
	window.addEventListener('scroll', function() {
	    const header = document.querySelector('header');
	    if (window.scrollY > 50) {
	        header.classList.add('scrolled');
	    } else {
	        header.classList.remove('scrolled');
	    }
	});
	
	//콘페티 애니메이션
	function launchConfetti() {
  const ul = document.querySelector('.particles');
  ul.innerHTML = ''; // 기존 파티클 제거

  const count = 25;

  for (let i = 0; i < count; i++) {
    const li = document.createElement('li');
    li.style.setProperty('--i', i); // 색상용 인덱스

    const angle = Math.random() * 2 * Math.PI;
    const distance = Math.random() * 200 + 50; // 퍼지는 정도
    const x = Math.cos(angle) * distance;
    const y = Math.sin(angle) * distance;

    li.style.setProperty('--x', `${x}px`);
    li.style.setProperty('--y', `${y}px`);

    const rotation = Math.random() * 720 - 360; // -360 ~ 360도 회전
    li.style.setProperty('--r', `${rotation}deg`);

    ul.appendChild(li);
  }
}

}

setInterval(() => {
	  launchConfetti();
	}, 2000); // 2초마다 터짐
	
	
	
	
	
	//버블
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
<script>
	let remainingSeconds = ${remainingSeconds};
</script>
<script src="/js/sessionTime.js"></script>
</body>
</html>