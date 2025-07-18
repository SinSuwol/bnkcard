<%@ page contentType="text/html; charset=UTF-8" isELIgnored="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드 리스트</title>
<link rel="stylesheet" href="/css/style.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- ✅ Slick Slider CSS + JS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<style>
/* ---------- 슬라이더 ---------- */
.slick-prev, .slick-next {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  z-index: 100;
  background: white;
  border: 1px solid #ccc;
  border-radius: 50%;
  font-size: 20px;
  width: 36px;
  height: 36px;
  cursor: pointer;
  opacity: 0.85;
}
.slick-prev:hover, .slick-next:hover {
  background: #000;
  color: #fff;
}
.slick-prev {
  left: 40px;
}
.slick-next {
  right: 40px;
}

.slider-container {
  max-width: 1000px;
  margin: 0px auto 50px;
  overflow: hidden;
  position: relative;
}
.popular-slider .slick-slide {
  padding: 10px;
  box-sizing: border-box;
}
.popular-card {
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  height: 100%;
  background: #fff;
  padding: 20px;
  text-align: center;
}
.popular-card img {
  max-width: 100%;
  height: auto;
  border-radius: 12px;
  margin-bottom: 10px;
}
.popular-title {
  font-weight;
  font-size: 16px;
  margin: 5px 0;
}
.popular-sub {
  font-size: 14px;
  color: #666;
  margin-bottom: 10px;
}

/* ---------- 카드 그리드 ---------- */
#cardGrid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 130px 170px;
	justify-items: center;
	max-width: 1060px;
	margin: 125px auto;
}

.item {
	width: 220px;
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
	cursor: pointer; /* ← 클릭 가능 커서 */
}

.item img {
	width: 300px;
	rotate: 90deg;
	margin-bottom: 50px;
	
}

/* ---------- 카드 이름 ---------- */
.item p:nth-of-type(1) {
	font-size: 20px;
	font-weight: 500;
	margin-top: 40px;
}

/* ---------- 카드 설명 ---------- */
.item p:nth-of-type(2) {
	margin-top: 10px;
	margin-bottom: 20px;
	word-break: keep-all;
}

/* ---------- 비교함 ---------- */
#compareBox {
	position: fixed;
	right: 12px;
	top: 200px;
	width: 140px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 20px;
	background: #fff;
	z-index: 1010;
}

/* ---------- 비교 모달 ---------- */
#compareModal {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 80%;
	max-width: 800px;
	background: #fff;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 0 20px rgba(0, 0, 0, .35);
	z-index: 2000;
}

.compare-label {
  display: inline-block;
  font-weight: 500;
  font-size: 14px;
  cursor: pointer;
  border-bottom: 1px solid #333333;
  padding-bottom: 2px;
  margin-top: 6px;
}

.compare-label input {
  display: none;
}

#modalOverlay {
	display: none;
	position: fixed;
	inset: 0;
	background: rgba(0, 0, 0, .6);
	z-index: 1999;
}

#modalContent {
	position: relative;
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: space-around;
}

#modalContent::after {
	content:"";
	position:absolute;
	width: 1px;
	margin-top: 20px;
	height: 500px;
	background-color: #ededed;
}

#modalContent div {
	width: 200px;
	text-align: center
}

#modalContent div .card-name {
	font-size: 20px;
}

#modalContent div .card-image-group img{
	width: 150px;
}

#modalContent img {
	width: 100%;
	border: 1px solid #ccc
}

/* 더보기 */
#loadMoreWrap {
	text-align: center;
	margin: 40px 0
}

/* ---------- 검색바 + 타입버튼 ---------- */
.typeBtn {
	display: inline-block;
	padding: 7px 20px;
	margin: 0 3px;
	font-weight: 600;
	border: 1px solid #aaa;
	border-radius: 9999px;
	background: #fff;
	cursor: pointer;
}

.typeBtn.active {
	background: #000;
	color: #fff
}

.icon_img {
	display: flex;
	justify-content: center;
	width: 100%;
}

.icon_img > div {
	position: relative;
}

.icon_img input::placeholder {
	color: #828282;
}

.icon_img > div > img {
	position: absolute;
	top: 50%;
	left: 12px;
	transform: translateY(-50%);
    width: 18px;
    height: 18px;
}


#searchInput {
	width: 400px;
	padding: 10px 35px;
	font-size: 15px;
	border: none;
	background-color: #ededed;
	border-radius: 40px;
	outline: none;
	
}

#searchInput 

#filterBtn {
	width: 40px;
	height: 40px;
	margin-left: 8px;
	border: none;
	border-radius: 50%;
	background: #eee;
	font-size: 18px;
	cursor: pointer;
	display: inline-flex;
	align-items: center;
	justify-content: center;
}

/* ---------- 상세 검색 모달 ---------- */
#advOverlay {
	display: none;
	position: fixed;
	inset: 0;
	background: rgba(0, 0, 0, .6);
	z-index: 3000;
}

#advModal {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 90%;
	max-width: 600px;
	max-height: 85vh;
	background: #fff;
	border-radius: 12px;
	padding: 25px;
	z-index: 3001;
	box-shadow: 0 0 20px rgba(0, 0, 0, .35);
	flex-direction: column;
}

#advModal.show {
	display: flex
}

#advModal h3 {
	text-align: center;
	margin-top: 0
}

#advKeyword {
	width: 100%;
	padding: 8px 12px;
	margin-bottom: 15px;
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-radius: 8px;
}

.hot {
	display: inline-block;
	padding: 4px 12px;
	margin: 3px;
	border-radius: 15px;
	background: #eee;
	font-size: 13px;
	cursor: pointer;
}

.hot.sel {
	background: #000;
	color: #fff
}

#modalResultGrid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
	gap: 20px;
	justify-items: center;
	margin-top: 15px;
	flex: 1;
	overflow-y: auto;
}

.adv-close {
	position: absolute;
	top: 15px;
	right: 20px;
	font-size: 22px;
	font-weight: 700;
	cursor: pointer;
}

.compare-card {
  width: 220px;
  background: #fff;
  border-radius: 12px;
  padding: 15px;
  text-align: center;
  font-size: 13px;
  line-height: 1.5;
}
.card-image-group img {
  width: 60px;
  height: auto;
  margin: 2px;
  border-radius: 8px;
  border: 1px solid #ccc;
}

.card-name {
  font-size: 15px;
  font-weight: bold;
  margin: 6px 0 3px;
}
.card-fee {
  color: #333;
  font-size: 13px;
  margin-bottom: 5px;
}
.card-tags {
  color: #777;
  font-size: 12px;
  margin: 4px 0;
}
#modalContent .card-icons img {
  width: 20px;
  height: 20px;
  margin: 2px;
}
.card-summary {
  text-align: left;
  font-size: 12px;
  margin-top: 10px;
}

.card-summary b {
  
}

.card-icons {
	display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 10px 30px;
    margin-top: 8px;
    max-width: 200px;
    align-content: space-around;
    flex-direction: column-reverse;
}


</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/fragments/mainheader2.jsp" />


	
	<!-- 🔥 인기 카드 슬라이더 -->
<div class="slider-container">
  <div class="popular-slider autoplay">
    <!-- 인기 카드가 JS로 자동 채워짐 -->
  </div>
</div>
	

	<!-- 카드 타입 필터 -->
	<div style="text-align: center; margin-bottom: 15px;">
		<button class="typeBtn active" data-type="">전체</button>
		<button class="typeBtn" data-type="신용">신용카드</button>
		<button class="typeBtn" data-type="체크">체크카드</button>
	</div>

	<!-- 검색바 + 세부 조정 아이콘 -->
		<div class="icon_img">
		<div>
		<input id="searchInput" type="text" placeholder="원하는 카드를 찾아보세요">
			<img src="/image/benifits/search.png" alt="icon">
		</div>
			<button id="filterBtn" title="상세 검색">🎚️</button>	
		</div>
		

	<!-- 카드 그리드 -->
	<div id="cardGrid"></div>
	<div id="loadMoreWrap">
	  <button onclick="loadMore()" style="background:none; border:none; cursor:pointer;">
	    <img src="/image/benifits/more_arrow.png" alt="더보기" style="width:24px; height:auto; border: 1px solid black; border-radius: 50%; padding:10px;">
	  </button>
	</div>
	
	

	<!-- 비교함 -->
	<div id="compareBox">
		<h4>비교함</h4>
		<ul id="compareList" style="list-style: none; padding: 0; margin: 0"></ul>
		<button onclick="openCompare()">비교하기</button>
		<div style="text-align:center; margin-top:10px;">
		  <button onclick="openScrapModal()" style="font-size:13px; padding:6px 10px; background:#eee; border:1px solid #ccc; border-radius:6px; cursor:pointer;">타행카드와 비교</button>
		</div>
	</div>

	<!-- 비교 모달 -->
	<div id="compareModal">
  <h2 style="text-align: center;">카드 비교</h2>
  <div id="modalContent"></div>
  <div style="text-align: center; margin-top: 20px;">
    <button onclick="closeCompareModal()">닫기</button>
  </div>
</div>
<div id="modalOverlay" onclick="closeCompareModal()"></div>

<div id="scrapCompareModal" style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%, -50%); width:80%; max-width:700px; background:#fff; border-radius:12px; padding:30px; box-shadow:0 0 20px rgba(0,0,0,.4); z-index:3000;">
  <h2 style="text-align:center;">타행카드 비교하기</h2>
  <div id="scrapModalList" style="max-height:400px; overflow-y:auto; margin-top:20px; display:flex; flex-wrap:wrap; gap:20px; justify-content:center;"></div>
  <div style="text-align:center; margin-top:20px;">
    <button onclick="closeScrapModal()">닫기</button>
  </div>
</div>
<div id="scrapOverlay" style="display:none; position:fixed; inset:0; background:rgba(0,0,0,.6); z-index:2999;" onclick="closeScrapModal()"></div>




	<!-- 상세 검색 모달 -->
	<div id="advOverlay"></div>
	<div id="advModal">
		<span class="adv-close" onclick="closeAdv()">✕</span>
		<h3>상세 검색</h3>
		<input id="advKeyword" type="text" placeholder="카드 이름 또는 키워드 입력">
		<p style="margin: 0 0 6px; font-weight: 600">주요혜택 (최대 5개)</p>
		
		<div id="hotArea">
		  <span class="hot" data-keyword="커피">#커피</span>
		  <span class="hot" data-keyword="편의점">#편의점</span>
		  <span class="hot" data-keyword="베이커리">#베이커리</span>
		  <span class="hot" data-keyword="영화">#영화</span>
		  <span class="hot" data-keyword="쇼핑">#쇼핑</span>
		  <span class="hot" data-keyword="외식">#외식</span>
		  <span class="hot" data-keyword="교통">#교통</span>
		  <span class="hot" data-keyword="통신">#통신</span>
		  <span class="hot" data-keyword="교육">#교육</span>
		  <span class="hot" data-keyword="레저">#레저</span>
		  <span class="hot" data-keyword="스포츠">#스포츠</span>
		  <span class="hot" data-keyword="구독">#구독</span>
		  <span class="hot" data-keyword="병원">#병원</span>
		  <span class="hot" data-keyword="약국">#약국</span>
		  <span class="hot" data-keyword="공공요금">#공공요금</span>
		  <span class="hot" data-keyword="주유">#주유</span>
		  <span class="hot" data-keyword="하이패스">#하이패스</span>
		  <span class="hot" data-keyword="배달앱">#배달앱</span>
		  <span class="hot" data-keyword="환경">#환경</span>
		  <span class="hot" data-keyword="공유모빌리티">#공유모빌리티</span>
		  <span class="hot" data-keyword="세무지원">#세무지원</span>
		  <span class="hot" data-keyword="포인트">#포인트</span>
		  <span class="hot" data-keyword="캐시백">#캐시백</span>
		  <span class="hot" data-keyword="놀이공원">#놀이공원</span>
		  <span class="hot" data-keyword="라운지">#라운지</span>
		  <span class="hot" data-keyword="발렛">#발렛</span>
		</div>
		

		<div id="modalResultGrid"></div>
		<div style="text-align: center; margin-top: 15px;">
			<button id="advSearchBtn"
				style="width: 100%; padding: 10px 0; background: #000; color: #fff; border: none; border-radius: 8px; font-size: 16px; cursor: pointer">검색</button>
		</div>
	</div>


<script src="/js/header2.js"></script>
<script>
// 🔥 인기 카드 슬라이더 데이터 불러오기
fetch('/api/cards')
  .then(r => r.json())
  .then(cards => {
    const sorted = [...cards]
      .sort((a, b) => b.viewCount - a.viewCount)
      .slice(0, 6);

    const slider = document.querySelector('.popular-slider');

    // 슬라이더가 이미 초기화되어 있다면 먼저 destroy
    if ($(slider).hasClass('slick-initialized')) {
      $(slider).slick('unslick');
    }

    slider.innerHTML = sorted.map(c => `
      <div>
        <div class="popular-card" onclick="goDetail(${c.cardNo})">
          <img src="${c.cardUrl}" alt="${c.cardName}">
          <div class="best-badge">Best</div>
          <div class="popular-title">${c.cardName}</div>
        </div>
      </div>
    `).join('');

    // 다시 슬릭 초기화
    $(slider).slick({
      slidesToShow: 3,
      slidesToScroll: 1,
      autoplay: true,
      autoplaySpeed: 2000,
      arrows: true,
      dots: false,
      infinite: true,
      draggable: false,
      swipe: false,
      prevArrow: '<button class="slick-prev">&#10094;</button>',
      nextArrow: '<button class="slick-next">&#10095;</button>'
    });
  });

</script>

<script>
let fullCardList=[],currentIndex=0,currentType='',currentKeyword='',selectedTags=[];
const advModal=document.getElementById('advModal');

/* ---------- 상세 페이지 이동 ---------- */
function goDetail(no){
  location.href='/cards/detail?no='+no;
}

/* 타입 필터 */
document.querySelectorAll('.typeBtn').forEach(btn=>{
  btn.addEventListener('click',()=>{
    document.querySelectorAll('.typeBtn').forEach(b=>b.classList.remove('active'));
    btn.classList.add('active');
    currentType=btn.dataset.type;
    performSearch(currentKeyword);
  });
});

/* 상세 검색 모달 open / close */
const openAdv=()=>{
  document.getElementById('advOverlay').style.display='block';
  advModal.classList.add('show');
  document.getElementById('advKeyword').value=currentKeyword;
  document.getElementById('advKeyword').focus();
};
function closeAdv(){
  document.getElementById('advOverlay').style.display='none';
  advModal.classList.remove('show');
}

/* 검색창 진입 */
document.getElementById('filterBtn').addEventListener('mousedown',openAdv);
document.getElementById('searchInput').addEventListener('mousedown',openAdv);
document.getElementById('searchInput').addEventListener('keydown',e=>{
  if(e.key==='Enter' && !e.isComposing){e.preventDefault();openAdv();}
});

/* 태그 선택 */
document.querySelectorAll('#hotArea .hot').forEach(h => {
  h.addEventListener('click', () => {
    if (h.classList.contains('sel')) {
      h.classList.remove('sel');
      selectedTags = selectedTags.filter(t => t !== h.dataset.keyword);
    } else {
      if (selectedTags.length >= 5) {
        alert('최대 5개 선택');
        return;
      }
      h.classList.add('sel');
      selectedTags.push(h.dataset.keyword);
    }

    // ✅ 항상 performSearch 호출 (모달 안이든 밖이든)
    performSearch(currentKeyword);
  });
});


/* 상세 검색 실행 */
document.getElementById('advSearchBtn').addEventListener('click',()=>{
  currentKeyword=document.getElementById('advKeyword').value.trim();
  performSearch(currentKeyword);closeAdv();
});
document.getElementById('advKeyword').addEventListener('keydown',e=>{
  if(e.key==='Enter' && !e.isComposing){e.preventDefault();document.getElementById('advSearchBtn').click();}
});

/* 검색 */
function performSearch(keyword=''){
	
	// 🔵 1) 로그 먼저 저장
	  fetch('/admin/Search/searchlog', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    keyword: keyword
  })
}).catch(err => console.error('검색 로그 저장 실패', err));
	
	
  const params=new URLSearchParams();
  if(keyword)params.append('q',keyword);
  if(currentType)params.append('type',currentType);
  if(selectedTags.length)params.append('tags',selectedTags.join(','));

  fetch('/api/cards/search?'+params.toString())
   .then(r => {
    if (!r.ok) {
      return r.json().then(e => { throw new Error(e.message); });
    }
    return r.json();
  })
    .then(data=>{
      if(data.length===0){
        fullCardList=[];currentIndex=0;
        document.getElementById('cardGrid').innerHTML='<p style="text-align:center;">검색 결과가 없습니다.</p>';
        document.getElementById('loadMoreWrap').style.display='none';
        return;
      }
      fullCardList=data;currentIndex=0;
      document.getElementById('cardGrid').innerHTML='';
      drawCards();
      document.getElementById('loadMoreWrap').style.display=(data.length>9)?'block':'none';
    })
    .catch(err => {
        alert(err.message);
      });
}

/* 초기 로딩 */
window.addEventListener('DOMContentLoaded',()=>{
  closeAdv();closeCompareModal();
  fetch('/api/cards')
    .then(r=>r.json())
    .then(d=>{
      fullCardList=d;drawCards();
      if(fullCardList.length<=9)document.getElementById('loadMoreWrap').style.display='none';
    })
    .catch(err=>console.error('카드 목록 로딩 실패',err));
});

/* 카드 출력 */
function drawCards() {
  const grid = document.getElementById('cardGrid');
  const end  = Math.min(currentIndex + 9, fullCardList.length);

  for (let i = currentIndex; i < end; i++) {
    const c   = fullCardList[i];
    const div = document.createElement('div');
    div.className = 'item';              // ← 부모 div는 클릭 이벤트 없음!

    div.innerHTML = `
    	  <img src="${c.cardUrl}" alt="${c.cardName}"
    	       style="cursor:pointer"
    	       onclick="goDetail(${c.cardNo})">

    	  <p style="cursor:pointer"
    	          onclick="goDetail(${c.cardNo})">${c.cardName}</p>

    	  <p style="font-size:12px;">${c.cardSlogan || ''}</p>

    	  <label class="compare-label" onclick="event.stopPropagation();">
    	    <input type="checkbox"
    	           value="${c.cardNo}"
    	           onclick="event.stopPropagation(); toggleCompare(this)">
    	    비교함 담기
    	  </label>
    	`;
    	grid.appendChild(div);
}
  currentIndex = end;
  if (currentIndex >= fullCardList.length)
    document.getElementById('loadMoreWrap').style.display = 'none';
}
function loadMore(){drawCards();}

/* 비교함 */
function toggleCompare(cb){
  const item = cb.closest('.item');
  const cardNo = cb.value;

  const cardName = item.querySelector('p')?.innerText || '알 수 없음';
  const cardUrl  = item.querySelector('img')?.src || '';

  let box = JSON.parse(sessionStorage.getItem('compareCards') || '[]');

  if(cb.checked){
    if(box.length >= 2){
      alert('최대 2개까지만 비교');
      cb.checked = false;
      return;
    }
    box.push({cardNo, cardName, cardUrl});
  } else {
    box = box.filter(c => c.cardNo !== cardNo);
  }

  sessionStorage.setItem('compareCards', JSON.stringify(box));
  renderCompareList();
}

function renderCompareList() {
	  const list = document.getElementById('compareList');
	  list.innerHTML = '';

	  JSON.parse(sessionStorage.getItem('compareCards') || '[]').forEach(c => {
	    const li = document.createElement('li');
	    li.style.marginBottom = '10px';

	    li.innerHTML = `
	      <img src="${c.cardUrl}" style="width:80px; display:block; margin:0 auto 5px;">
	      <div style="font-size:13px; margin-bottom:4px;">${c.cardName}</div>
	      <button onclick="removeFromCompare('${c.cardNo}')" style="
	        background: #ff4d4f;
	        color: white;
	        border: none;
	        padding: 4px 8px;
	        border-radius: 6px;
	        font-size: 12px;
	        cursor: pointer;
	      ">제거</button>
	    `;

	    list.appendChild(li);
	  });
	}

renderCompareList();

function removeFromCompare(cardNo) {
	  let box = JSON.parse(sessionStorage.getItem('compareCards') || '[]');
	  box = box.filter(c => c.cardNo !== cardNo);
	  sessionStorage.setItem('compareCards', JSON.stringify(box));
	  renderCompareList();

	  // 체크박스 상태도 해제
	  const checkbox = document.querySelector(
	    `input[type="checkbox"][value="${cardNo}"]`
	  );
	  if (checkbox) checkbox.checked = false;
	}


const categoryToIcon = {
		  "커피": "coffee",
		  "편의점": "convenience-store",
		  "베이커리": "bakery",
		  "영화": "movie",
		  "쇼핑": "shopping",
		  "외식": "meal",
		  "교통": "metro",
		  "통신": "telecommunication",
		  "교육": "education",
		  "레저&스포츠": "leisure",
		  "구독": "subscribe",
		  "병원": "hospital",
		  "공공요금": "charges",
		  "주유": "gas-station",
		  "하이패스": "hipass",
		  "배달앱": "delivery",
		  "환경": "environment",
		  "공유모빌리티": "socar",
		  "세무지원": "tax",
		  "포인트&캐시백": "point",
		  "놀이공원": "amusementpark",
		  "라운지": "lounge",
		  "발렛": "valetparking"
};

/* 비교 모달 */
function openCompare() {
  const box = JSON.parse(sessionStorage.getItem('compareCards') || '[]');
  if (box.length < 2) {
    alert('최소 2개 이상 선택');
    return;
  }

  document.getElementById('compareModal').style.display = 'block';
  document.getElementById('modalOverlay').style.display = 'block';

  const wrap = document.getElementById('modalContent');
  wrap.innerHTML = '';

  box.forEach(c => {
    fetch(`/api/cards/${c.cardNo}`)
      .then(r => r.json())
      .then(d => {
        const div = document.createElement('div');
        div.className = 'compare-card';

        // 해시태그 추출
        const tagStr = (d.cardType || '') + ',' + (d.service || '') + ',' + (d.sService || '') + ',' + (d.issuedTo || '');
        const tags = Object.keys(categoryToIcon).filter(t => tagStr.includes(t));

        // 아이콘
        const iconHtml = tags.map(name => {
          const icon = categoryToIcon[name];
          return `<img src="/image/benifits/${icon}.png" alt="${name}">`;
        }).join('');
        const tagHtml = tags.map(t => `#${t}`).join(' ');

        // 카드 이미지 (최대 3장)
        const images = (d.cardUrl || d.scCardUrl || '').split(',');
		const imageHtml = images.slice(0, 3).map(url =>
		  `<img src="${url.trim()}" alt="">`
		).join('');

        // ✅ 요약 혜택: benefits 또는 scbenefits 우선 사용
        let summary = '';
		if (d.benefits || d.scBenefits) {
		  summary = (d.benefits || d.scBenefits)
		    .replace(/<br\s*\/?>/gi, '<br>');
		} else if (d.service) {
		  summary = d.service
		    .replace(/◆/g, '•')
		    .split(/\n|<br>/)
		    .filter(line => line.trim())
		    .slice(0, 5)
		    .join('<br>');
		}

        // 연회비: 일반 or 스크랩 카드용
        const fee = d.annualFee ?? d.scAnnualFee ?? 0;

        // 카드명: 일반 or 스크랩 카드용
        const name = d.cardName || d.scCardName;

        div.innerHTML = `
          <div class="card-image-group">${imageHtml}</div>
          <div class="card-name">${name}</div>
          <div class="card-tags">${tagHtml}</div>
          <div class="card-fee"><b>연회비:</b> ${fee.toLocaleString()}원</div>
          <div class="card-summary"><b>요약 혜택</b><br>${summary}</div>
          <div class="card-explain">혜택 특성</div>
          <div class="card-icons">${iconHtml}</div>
        `;
        wrap.appendChild(div);
      });
  });
}




function closeCompareModal(){
  document.getElementById('compareModal').style.display='none';
  document.getElementById('modalOverlay').style.display='none';
}

function openScrapModal() {
	fetch('/api/public/cards/scrap')
	    .then(res => res.json())
	    .then(data => {
	      const listDiv = document.getElementById('scrapModalList');
	      listDiv.innerHTML = '';
	      data.forEach(card => {
	        const div = document.createElement('div');
	        div.style.cssText = 'width:160px; text-align:center; border:1px solid #ddd; padding:10px; border-radius:10px; background:#f9f9f9;';
	        div.innerHTML = `
	          <div><b>${card.scCardName}</b></div>
	          <div style="font-size:12px; color:#666; margin:5px 0 10px;">${card.scCardSlogan || ''}</div>
	          <button onclick='addScrapToCompare("${card.scCardUrl}", "${card.scCardName}")' style="font-size:12px; padding:4px 8px; border-radius:6px; background:#000; color:#fff; border:none; cursor:pointer;">비교함 담기</button>
	        `;
	        listDiv.appendChild(div);
	      });
	      document.getElementById('scrapCompareModal').style.display = 'block';
	      document.getElementById('scrapOverlay').style.display = 'block';
	    });
	}

	function closeScrapModal() {
	  document.getElementById('scrapCompareModal').style.display = 'none';
	  document.getElementById('scrapOverlay').style.display = 'none';
	}

	function addScrapToCompare(url, name) {
	  const slot = document.getElementById('compareList');
	  const box = JSON.parse(sessionStorage.getItem('compareCards') || '[]');
	  if (box.length >= 2) {
	    alert('최대 2개까지만 비교 가능합니다.');
	    return;
	  }
	  box.push({cardNo: 'scrap_' + Date.now(), cardName: name, cardUrl: url});
	  sessionStorage.setItem('compareCards', JSON.stringify(box));
	  renderCompareList();
	  closeScrapModal();
	}

</script>

<script>
   let remainingSeconds = <%= request.getAttribute("remainingSeconds") %>;
</script>

<script src="/js/sessionTime.js"></script>
</body>
</html>
