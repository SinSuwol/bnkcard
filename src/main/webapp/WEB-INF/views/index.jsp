<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/carousel.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/Draggable.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/MotionPathPlugin.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/InertiaPlugin.min.js"></script>
<script type="module" src="https://unpkg.com/@splinetool/viewer@latest/build/spline-viewer.js"></script>
<script  src="https://code.jquery.com/jquery-3.7.1.min.js"  ></script>

</head>
<body class="main-body">
<jsp:include page="/WEB-INF/views/fragments/mainheader.jsp" />
<!-- <div class="video-wrapper">
	<div class="video-container">
	    흐릿한 배경용 영상
	    <video autoplay muted loop playsinline class="back-video">
	        <source src="/video/bannerVideo.mp4" type="video/mp4">
	    </video>
	
	    선명한 전경 영상
	    <video autoplay muted loop playsinline class="banner-video">
	        <source src="/video/bannerVideo.mp4" type="video/mp4">
	    </video>
		
	    텍스트나 버튼 등 추가 가능
	    <div class="overlay-text">
	        <h1 class="red">플러스, &nbsp</h1>
	        <h1> 그 이상의 혜택</h1>
	    </div>	
	</div>
</div> -->
<div class="slider-wrapper">
	<div class="main-slider">
	  <div>
	  	<div class="cover"></div>
	  	<img src="/image/배너슬라이드1.jpg">
	  </div>
	  <div>
	  	<div class="cover"></div>
	  	<img src="/image/배너슬라이드1.jpg">
	  </div>
	  <div>
	  	<div class="cover"></div>
	  	<img src="/image/배너슬라이드1.jpg">
	  </div>
	  <div>
	  	<div class="cover"></div>
	  	<img src="/image/배너슬라이드1.jpg">
	  </div>
	  <div>
	  	<div class="cover"></div>
	  	<img src="/image/배너슬라이드1.jpg">
	  </div>
	  
	</div>
</div>
<div class="main-wrap flex">
	<div class="section">
		<h1 class="mainTit1">동백PLUS 체크카드</h1>
		<h2 class="mainTit2">'가성비'와 '가심비'를 모두 만족하는 프리미엄 경험</h2>
		<p class="mainTit3">매일 쓰는 소비에, 매달 받는 보상</p>
		<div class="spline-wrapper">
			
			<div class="confetti-wrapper c1">
			  <ul class="particles "></ul>
			</div>
			<div class="confetti-wrapper c2">
			  <ul class="particles "></ul>
			</div>
			<div class="confetti-wrapper c3">
			  <ul class="particles2 "></ul>
			</div>
			<div class="confetti-wrapper c4">
			  <ul class="particles2 "></ul>
			</div>
			<spline-viewer orbit class="spline"  allow="scroll" url="https://prod.spline.design/uHGgQogk8z9Qb0Xz/scene.splinecode"></spline-viewer>
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
<jsp:include page="/WEB-INF/views/fragments/footer.jsp" />
<c:if test="${not empty msg}">
	    <script>alert("${msg}");</script>
	</c:if>
<script src="/js/carousel.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

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
	
	// 콘페티 애니메이션
function launchConfettiAll() {
  const containers = document.querySelectorAll('.particles');
  containers.forEach(ul => {
    ul.innerHTML = '';

    const count = 20;

    const imageParticleCount = Math.floor(Math.random() * 3) + 3; // 3~5개
    const imageIndexes = new Set();
    while (imageIndexes.size < imageParticleCount) {
      imageIndexes.add(Math.floor(Math.random() * count));
    }

    const imageUrl = '/image/동전.png';

    for (let i = 0; i < count; i++) {
      const li = document.createElement('li');
      li.style.setProperty('--i', i);

      const angle = Math.random() * 2 * Math.PI;
      const distance = Math.random() * 180 + 50;
      const x = Math.cos(angle) * distance;
      const y = Math.sin(angle) * distance;

      li.style.setProperty('--x', `\${x}px`);
      li.style.setProperty('--y', `\${y}px`);
      const rotation = Math.random() * 720 - 360;
      li.style.setProperty('--r', `\${rotation}deg`);

      if (imageIndexes.has(i)) {
        const size = Math.random() * 30 + 30;
        li.style.width = `\${size}px`;
        li.style.height = `\${size}px`;
        li.style.backgroundImage = `url(\${imageUrl})`;
        li.style.backgroundSize = 'contain';
        li.style.backgroundRepeat = 'no-repeat';
        li.style.backgroundPosition = 'center';
        li.style.backgroundColor = 'transparent';
        li.style.borderRadius = '0';
      } else {
        const size = Math.random() * 6 + 12;
        li.style.width = `\${size}px`;
        li.style.height = `\${size}px`;
      }

      ul.appendChild(li);
    }
  });
}
	

function launchConfettiAll2() {
	  const containers = document.querySelectorAll('.particles2');
	  containers.forEach(ul => {
	    ul.innerHTML = '';

	    const count = 20;

	    const imageParticleCount = Math.floor(Math.random() * 3) + 3; // 3~5개
	    const imageIndexes = new Set();
	    while (imageIndexes.size < imageParticleCount) {
	      imageIndexes.add(Math.floor(Math.random() * count));
	    }

	    const imageUrl = '/image/동전.png';

	    for (let i = 0; i < count; i++) {
	      const li = document.createElement('li');
	      li.style.setProperty('--i', i);

	      const angle = Math.random() * 2 * Math.PI;
	      const distance = Math.random() * 180 + 50;
	      const x = Math.cos(angle) * distance;
	      const y = Math.sin(angle) * distance;

	      li.style.setProperty('--x', `\${x}px`);
	      li.style.setProperty('--y', `\${y}px`);
	      const rotation = Math.random() * 720 - 360;
	      li.style.setProperty('--r', `\${rotation}deg`);

	      if (imageIndexes.has(i)) {
	        const size = Math.random() * 30 + 30;
	        li.style.width = `\${size}px`;
	        li.style.height = `\${size}px`;
	        li.style.backgroundImage = `url(\${imageUrl})`;
	        li.style.backgroundSize = 'contain';
	        li.style.backgroundRepeat = 'no-repeat';
	        li.style.backgroundPosition = 'center';
	        li.style.backgroundColor = 'transparent';
	        li.style.borderRadius = '0';
	      } else {
	        const size = Math.random() * 6 + 12;
	        li.style.width = `\${size}px`;
	        li.style.height = `\${size}px`;
	      }

	      ul.appendChild(li);
	    }
	  });
	}
		




setInterval(() => {
		launchConfettiAll();
	}, 6000); // 3초마다 터짐
	
setTimeout(() => {
	  setInterval(() => {
	    launchConfettiAll2();
	  }, 6000);
	}, 3000); // 첫 실행을 3초 뒤에 시작
	
	
	
	
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
	
	
	
	//슬라이더
	$('.main-slider').slick({
	  centerMode: true,
	  centerPadding: '0px',
	  slidesToShow: 3,
	  arrows: true,
	  infinite: true,
	  variableWidth: true
	});
	
	
	
	
	
</script>
<script>
	let remainingSeconds = ${remainingSeconds};
</script>
<script src="/js/sessionTime.js"></script>
</body>
</html>