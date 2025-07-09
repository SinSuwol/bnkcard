<%@ page contentType="text/html; charset=UTF-8" isELIgnored="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드 리스트</title>
<style>
/* ------ 카드 그리드 (3×N) ------ */
#cardGrid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 50px 40px;
	justify-items: center;
	max-width: 1200px;
	margin: 0 auto
}

.item {
	width: 220px;
	text-align: center
}

.item img {
	width: 100%;
	height: auto;
	border: 1px solid #ddd
}

/* ------ 비교함 고정 박스 ------ */
#compareBox {
	position: fixed;
	right: 20px;
	top: 100px;
	width: 160px;
	border: 1px solid #ccc;
	background: #fff;
	padding: 10px;
	z-index: 1010
}

/* ------ 비교 모달 ------ */
#compareModal {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 80%;
	max-width: 800px;
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 0 20px rgba(0, 0, 0, .3);
	z-index: 2000;
	padding: 30px
}

#modalOverlay {
	display: none;
	position: fixed;
	inset: 0;
	background: rgba(0, 0, 0, .6);
	z-index: 1999
}

#modalContent {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: center
}

#modalContent div {
	width: 200px;
	text-align: center
}

#modalContent img {
	width: 100%;
	border: 1px solid #ccc
}

/* 더보기 버튼 */
#loadMoreWrap {
	text-align: center;
	margin: 40px 0
}

/* ------ 검색 바 & 타입 버튼 ------ */
#searchInput {
	display: inline-block;
	width: 260px;
	padding: 8px 35px 8px 35px;
	border-radius: 40px;
	border: 2px solid #000;
	font-size: 15px
}

#filterBtn {
	width: 40px;
	height: 40px;
	border: none;
	border-radius: 50%;
	background: #eee;
	margin-left: 8px;
	cursor: pointer;
	font-size: 18px;
	display: inline-flex;
	align-items: center;
	justify-content: center
}

.typeBtn {
	display: inline-block;
	padding: 7px 20px;
	border: 1px solid #aaa;
	background: #fff;
	border-radius: 9999px;
	cursor: pointer;
	font-weight: 600;
	margin: 0 3px
}

.typeBtn.active {
	background: #000;
	color: #fff
}

/* ------ 고급 검색 모달 ------ */
#advOverlay {
	display: none;
	position: fixed;
	inset: 0;
	background: rgba(0, 0, 0, .6);
	z-index: 3000
}

#advModal {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 90%;
	max-width: 600px;
	background: #fff;
	border-radius: 12px;
	padding: 25px;
	z-index: 3001
}

#advModal h3 {
	margin-top: 0;
	text-align: center
}

.hot {
	display: inline-block;
	padding: 4px 12px;
	border-radius: 15px;
	background: #eee;
	font-size: 13px;
	margin: 3px;
	cursor: pointer
}

.adv-close {
	position: absolute;
	top: 15px;
	right: 20px;
	font-size: 22px;
	font-weight: 700;
	cursor: pointer
}
</style>
</head>
<body>

	<h2 style="text-align: center;">카드 목록</h2>

	<!-- 카드 타입 필터 -->
	<div style="text-align: center; margin-bottom: 15px;">
		<button class="typeBtn active" data-type="">전체</button>
		<button class="typeBtn" data-type="신용">신용카드</button>
		<button class="typeBtn" data-type="체크">체크카드</button>
	</div>

	<!-- 검색 바 + 필터 버튼 -->
	<div style="text-align: center; margin-bottom: 30px;">
		<span style="position: relative; display: inline-block;"> <span
			style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); font-size: 18px;">🔍</span>
			<input id="searchInput" type="text" placeholder="원하는 카드를 찾아보세요">
		</span>
		<button id="filterBtn" title="상세 검색">⚙️</button>
		<button id="searchBtn" type="button">검색</button>
	</div>

	<!-- 카드 그리드 -->
	<div id="cardGrid"></div>

	<div id="loadMoreWrap">
		<button id="loadMoreBtn" onclick="loadMore()">더보기 ▼</button>
	</div>

	<!-- 비교함 -->
	<div id="compareBox">
		<h4>비교함</h4>
		<ul id="compareList" style="list-style: none; padding: 0; margin: 0"></ul>
		<button onclick="openCompare()">비교하기</button>
	</div>

	<!-- 비교 모달 + 오버레이 -->
	<div id="compareModal">
		<h2 style="text-align: center;">카드 비교</h2>
		<div id="modalContent"></div>
		<div style="text-align: center; margin-top: 20px;">
			<button onclick="closeModal()">닫기</button>
		</div>
	</div>
	<div id="modalOverlay" onclick="closeModal()"></div>

	<!-- 고급 검색 모달 -->
	<div id="advOverlay"></div>
	<div id="advModal">
		<span class="adv-close" onclick="closeAdv()">✕</span>
		<h3>신용카드 상세 검색</h3>
		<input id="advKeyword" type="text" placeholder="원하는 카드를 찾아보세요"
			style="width: 100%; padding: 8px 12px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 8px;">
		<p style="margin: 0 0 6px; font-weight: 600">주요혜택</p>
		<div id="hotArea">
			<span class="hot">주유</span><span class="hot">여행/숙박</span><span
				class="hot">쇼핑</span><span class="hot">포인트</span><span class="hot">영화/공연</span>
		</div>
		<p style="font-size: 12px; color: #666; margin: 10px 0 20px;">혜택은
			최대 5개까지 선택할 수 있습니다.</p>
		<button id="advSearchBtn"
			style="display: block; width: 100%; padding: 10px 0; background: #000; color: #fff; border: none; border-radius: 8px; font-size: 16px; cursor: pointer">검색</button>
	</div>

	<script>
/* ---------- 전역 ---------- */
let fullCardList=[];let currentIndex=0;let currentType='';let currentKeyword='';let selectedTags=[];

/* ---------- 타입 버튼 ---------- */
document.querySelectorAll('.typeBtn').forEach(btn=>btn.addEventListener('click',()=>{document.querySelectorAll('.typeBtn').forEach(b=>b.classList.remove('active'));btn.classList.add('active');currentType=btn.dataset.type;performSearch(currentKeyword)}));

/* ---------- 기본 검색 ---------- */
document.getElementById('searchBtn').addEventListener('click',()=>{currentKeyword=document.getElementById('searchInput').value.trim();performSearch(currentKeyword)});
document.getElementById('searchInput').addEventListener('keydown',e=>{if(e.key==='Enter')document.getElementById('searchBtn').click()});

/* ---------- 고급 검색 모달 ---------- */
document.getElementById('filterBtn').addEventListener('click',openAdv);
document.querySelectorAll('#hotArea .hot').forEach(h=>h.addEventListener('click',()=>{if(selectedTags.includes(h.innerText)){selectedTags=selectedTags.filter(t=>t!==h.innerText);h.style.background='#eee'}else{if(selectedTags.length>=5){alert('최대 5개 선택 가능합니다');return;}selectedTags.push(h.innerText);h.style.background='#000';h.style.color='#fff'}}));
document.getElementById('advSearchBtn').addEventListener('click',()=>{const kw=document.getElementById('advKeyword').value.trim();currentKeyword=kw;performSearch(kw);closeAdv()});

function openAdv(){document.getElementById('advOverlay').style.display='block';document.getElementById('advModal').style.display='block'}
function closeAdv(){document.getElementById('advOverlay').style.display='none';document.getElementById('advModal').style.display='none';selectedTags=[];document.querySelectorAll('#hotArea .hot').forEach(h=>{h.style.background='#eee';h.style.color='#000'})}

document.getElementById('advOverlay').addEventListener('click',closeAdv);

/* ---------- 검색 실행 ---------- */
function performSearch(keyword=''){const params=new URLSearchParams();if(keyword)params.append('q',keyword);if(currentType)params.append('type',currentType);const url='/api/cards/search?'+params.toString();fetch(url).then(r=>r.json()).then(data=>{if(data.length===0){fullCardList=[];currentIndex=0;document.getElementById('cardGrid').innerHTML='<p style="text-align:center;">검색 결과가 없습니다.</p>';document.getElementById('loadMoreWrap').style.display='none';return;}fullCardList=data;currentIndex=0;document.getElementById('cardGrid').innerHTML='';drawCards();document.getElementById('loadMoreWrap').style.display=(data.length>9)?'block':'none'}).catch(err=>console.error('검색 실패',err))}

/* ---------- 초기 로딩 ---------- */
window.addEventListener('DOMContentLoaded',()=>{fetch('/api/cards').then(r=>r.json()).then(d=>{fullCardList=d;drawCards();if(fullCardList.length<=9){document.getElementById('loadMoreWrap').style.display='none'}}).catch(err=>console.error('카드 목록 로딩 실패',err))});

/* ---------- 카드 9개씩 그리기 ---------- */
function drawCards(){const grid=document.getElementById('cardGrid');const end=Math.min(currentIndex+9,fullCardList.length);for(let i=currentIndex;i<end;i++){const c=fullCardList[i];const div=document.createElement('div');div.className='item';div.innerHTML=`<img src="${c.cardUrl}" alt="${c.cardName}"><br><strong>${c.cardName}</strong><br><span style="font-size:12px;">${c.cardSlogan||''}</span><br><label><input type="checkbox" value="${c.cardNo}" onclick="toggleCompare(this)"> 비교함 담기</label>`;grid.appendChild(div);}currentIndex=end;if(currentIndex>=fullCardList.length){document.getElementById('loadMoreWrap').style.display='none'}}
function loadMore(){drawCards()}

/* ---------- 비교함 ---------- */
function toggleCompare(cb){const item=cb.closest('.item');const cardNo=cb.value;const cardName=item.querySelector('strong').innerText;const cardUrl=item.querySelector('img').src;let box=JSON.parse(sessionStorage.getItem('compareCards')||'[]');if(cb.checked){if(box.length>=3){alert('최대 3개까지만 비교할 수 있습니다.');cb.checked=false;return;}box.push({cardNo,cardName,cardUrl})}else{box=box.filter(c=>c.cardNo!==cardNo)}sessionStorage.setItem('compareCards',JSON.stringify(box));renderCompareList()}
function renderCompareList(){const list=document.getElementById('compareList');list.innerHTML='';JSON.parse(sessionStorage.getItem('compareCards')||'[]').forEach(c=>{const li=document.createElement('li');li.innerHTML=`<img src="${c.cardUrl}" style="width:60px;"><br>${c.cardName}`;list.appendChild(li)})}
renderCompareList();

/* ---------- 비교 모달 ---------- */
function openCompare(){const box=JSON.parse(sessionStorage.getItem('compareCards')||'[]');if(box.length<2){alert('최소 2개 이상 선택해야 비교가 가능합니다.');return;}document.getElementById('compareModal').style.display='block';document.getElementById('modalOverlay').style.display='block';const wrap=document.getElementById('modalContent');wrap.innerHTML='';box.forEach(c=>{fetch(`/api/cards/${c.cardNo}`).then(r=>r.json()).then(d=>{const div=document.createElement('div');div.innerHTML=`<img src="${d.cardUrl}" alt="${d.cardName}"><h4>${d.cardName}</h4><p><b>연회비:</b> ${d.annualFee?.toLocaleString()||0}원</p><p style="text-align:left;font-size:12px;"><b>주요혜택</b><br>${(d.service||'').replace(/\n/g,'<br>')}</p>`;wrap.appendChild(div)}).catch(err=>console.error('카드 상세 로딩 실패',err))})}
function closeModal(){document.getElementById('compareModal').style.display='none';document.getElementById('modalOverlay').style.display='none'}
</script>
</body>
</html>