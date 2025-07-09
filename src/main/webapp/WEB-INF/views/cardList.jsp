<%@ page contentType="text/html; charset=UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드 리스트</title>
<style>
/* ---------- 카드 그리드 ---------- */
#cardGrid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 50px 40px;
  justify-items: center;
  max-width: 1200px;
  margin: 0 auto;
}
.item { width: 220px; text-align: center }
.item img { width: 100%; border: 1px solid #ddd }

/* ---------- 비교함 ---------- */
#compareBox {
  position: fixed; right: 20px; top: 100px; width: 160px;
  padding: 10px; border: 1px solid #ccc; background: #fff; z-index: 1010;
}

/* ---------- 비교 모달 ---------- */
#compareModal {
  display: none; position: fixed; top: 50%; left: 50%;
  transform: translate(-50%, -50%);
  width: 80%; max-width: 800px; background: #fff; padding: 30px;
  border-radius: 12px; box-shadow: 0 0 20px rgba(0,0,0,.35); z-index: 2000;
}
#modalOverlay {
  display: none; position: fixed; inset: 0; background: rgba(0,0,0,.6); z-index: 1999;
}
#modalContent {
  display: flex; flex-wrap: wrap; gap: 20px; justify-content: center;
}
#modalContent div {
  width: 200px; text-align: center;
}
#modalContent img { width: 100%; border: 1px solid #ccc }

/* 더보기 */
#loadMoreWrap { text-align: center; margin: 40px 0 }

/* ---------- 검색바 + 타입버튼 ---------- */
.typeBtn {
  display: inline-block; padding: 7px 20px; margin: 0 3px; font-weight: 600;
  border: 1px solid #aaa; border-radius: 9999px; background: #fff; cursor: pointer;
}
.typeBtn.active { background: #000; color: #fff }
#searchInput {
  width: 260px; padding: 8px 35px 8px 35px; font-size: 15px;
  border: 2px solid #000; border-radius: 40px; outline: none;
  background: url("data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%23777' viewBox='0 0 16 16'><path d='M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001l3.85 3.85a1 1 0 0 0 1.415-1.415l-3.85-3.85zm-5.242 1.106a5 5 0 1 1 0-10 5 5 0 0 1 0 10z'/></svg>") no-repeat 12px center/16px;
}
#filterBtn {
  width: 40px; height: 40px; margin-left: 8px; border: none; border-radius: 50%;
  background: #eee; font-size: 18px; cursor: pointer; display: inline-flex;
  align-items: center; justify-content: center;
}

/* ---------- 상세 검색 모달 ---------- */
#advOverlay {
  display: none; position: fixed; inset: 0; background: rgba(0,0,0,.6); z-index: 3000;
}
#advModal {
  display: none;
  position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
  width: 90%; max-width: 600px; max-height: 85vh; background: #fff;
  border-radius: 12px; padding: 25px; z-index: 3001;
  box-shadow: 0 0 20px rgba(0,0,0,.35);
  flex-direction: column;
}
#advModal.show { display: flex; }

#advModal h3 { text-align: center; margin-top: 0 }
#advKeyword {
  width: 100%; box-sizing: border-box; padding: 8px 12px; margin-bottom: 15px;
  border: 1px solid #ccc; border-radius: 8px;
}
.hot {
  display: inline-block; padding: 4px 12px; margin: 3px; border-radius: 15px;
  background: #eee; font-size: 13px; cursor: pointer;
}
.hot.sel { background: #000; color: #fff }
#modalResultGrid {
  display: grid; grid-template-columns: repeat(auto-fill,minmax(140px,1fr));
  gap: 20px; justify-items: center; margin-top: 15px; flex: 1; overflow-y: auto;
}
.adv-close {
  position: absolute; top: 15px; right: 20px; font-size: 22px;
  font-weight: 700; cursor: pointer;
}
</style>
</head>
<body>

<h2 style="text-align:center;">카드 목록</h2>

<!-- 카드 타입 필터 -->
<div style="text-align:center;margin-bottom:15px;">
  <button class="typeBtn active" data-type="">전체</button>
  <button class="typeBtn" data-type="신용">신용카드</button>
  <button class="typeBtn" data-type="체크">체크카드</button>
</div>

<!-- 검색바 + 세부 조정 아이콘 -->
<div style="text-align:center;margin-bottom:30px;">
  <span style="position:relative;display:inline-block;">
    <input id="searchInput" type="text" placeholder="원하는 카드를 찾아보세요">
  </span>
  <button id="filterBtn" title="상세 검색">🎚️</button>
</div>

<!-- 카드 그리드 -->
<div id="cardGrid"></div>
<div id="loadMoreWrap"><button onclick="loadMore()">더보기 ▼</button></div>

<!-- 비교함 -->
<div id="compareBox">
  <h4>비교함</h4>
  <ul id="compareList" style="list-style:none;padding:0;margin:0"></ul>
  <button onclick="openCompare()">비교하기</button>
</div>

<!-- 비교 모달 -->
<div id="compareModal">
  <h2 style="text-align:center;">카드 비교</h2>
  <div id="modalContent"></div>
  <div style="text-align:center;margin-top:20px;"><button onclick="closeCompareModal()">닫기</button></div>
</div>
<div id="modalOverlay" onclick="closeCompareModal()"></div>

<!-- 상세 검색 모달 -->
<div id="advOverlay"></div>
<div id="advModal">
  <span class="adv-close" onclick="closeAdv()">✕</span>
  <h3>상세 검색</h3>
  <input id="advKeyword" type="text" placeholder="카드 이름 또는 키워드 입력">
  <p style="margin:0 0 6px;font-weight:600">주요혜택 (최대 5개)</p>
  <div id="hotArea">
    <span class="hot">할인</span><span class="hot">포인트</span>
    <span class="hot">여행</span><span class="hot">카페</span>
    <span class="hot">교통</span><span class="hot">병원</span>
  </div>
  <div id="modalResultGrid"></div>
  <div style="text-align:center;margin-top:15px;">
    <button id="advSearchBtn" style="width:100%;padding:10px 0;background:#000;color:#fff;
            border:none;border-radius:8px;font-size:16px;cursor:pointer">검색</button>
  </div>
</div>

<script>
let fullCardList = [], currentIndex = 0, currentType = '', currentKeyword = '', selectedTags = [];
const advModal = document.getElementById('advModal');

/* 타입 필터 */
document.querySelectorAll('.typeBtn').forEach(btn => {
  btn.addEventListener('click', () => {
    document.querySelectorAll('.typeBtn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    currentType = btn.dataset.type;
    performSearch(currentKeyword);
  });
});

/* 상세 검색 모달 열기 */
const openAdv = () => {
  document.getElementById('advOverlay').style.display = 'block';
  advModal.classList.add('show');
  document.getElementById('advKeyword').value = currentKeyword;
  document.getElementById('advKeyword').focus();
};
function closeAdv() {
  document.getElementById('advOverlay').style.display = 'none';
  advModal.classList.remove('show');
}

/* 검색창 진입 */
document.getElementById('filterBtn').addEventListener('mousedown', openAdv);
document.getElementById('searchInput').addEventListener('mousedown', openAdv);
document.getElementById('searchInput').addEventListener('keydown', e => {
  if (e.key === 'Enter' && !e.isComposing) {
    e.preventDefault();
    openAdv();
  }
});

/* 태그 선택 */
document.querySelectorAll('#hotArea .hot').forEach(h => {
  h.addEventListener('click', () => {
    if (h.classList.contains('sel')) {
      h.classList.remove('sel');
      selectedTags = selectedTags.filter(t => t !== h.innerText);
    } else {
      if (selectedTags.length >= 5) { alert('최대 5개 선택'); return; }
      h.classList.add('sel');
      selectedTags.push(h.innerText);
    }

    if (!advModal.classList.contains('show')) {
      performSearch(currentKeyword);
    }
  });
});

/* 상세 검색 실행 */
document.getElementById('advSearchBtn').addEventListener('click', () => {
  currentKeyword = document.getElementById('advKeyword').value.trim();
  performSearch(currentKeyword);
  closeAdv();
});
document.getElementById('advKeyword').addEventListener('keydown', e => {
  if (e.key === 'Enter' && !e.isComposing) {
    e.preventDefault();
    document.getElementById('advSearchBtn').click();
  }
});

/* 검색 */
function performSearch(keyword = '') {
  const params = new URLSearchParams();
  if (keyword) params.append('q', keyword);
  if (currentType) params.append('type', currentType);
  if (selectedTags.length) params.append('tags', selectedTags.join(','));

  fetch('/api/cards/search?' + params.toString())
    .then(r => r.json())
    .then(data => {
      if (data.length === 0) {
        fullCardList = []; currentIndex = 0;
        document.getElementById('cardGrid').innerHTML = '<p style="text-align:center;">검색 결과가 없습니다.</p>';
        document.getElementById('loadMoreWrap').style.display = 'none';
        return;
      }
      fullCardList = data; currentIndex = 0;
      document.getElementById('cardGrid').innerHTML = '';
      drawCards();
      document.getElementById('loadMoreWrap').style.display = (data.length > 9) ? 'block' : 'none';
    })
    .catch(err => console.error('검색 실패', err));
}

/* 초기 로딩 */
window.addEventListener('DOMContentLoaded', () => {
  closeAdv(); closeCompareModal();
  fetch('/api/cards')
    .then(r => r.json())
    .then(d => {
      fullCardList = d;
      drawCards();
      if (fullCardList.length <= 9) document.getElementById('loadMoreWrap').style.display = 'none';
    })
    .catch(err => console.error('카드 목록 로딩 실패', err));
});

/* 카드 출력 */
function drawCards() {
  const grid = document.getElementById('cardGrid');
  const end = Math.min(currentIndex + 9, fullCardList.length);
  for (let i = currentIndex; i < end; i++) {
    const c = fullCardList[i];
    const div = document.createElement('div');
    div.className = 'item';
    div.innerHTML = `
      <img src="${c.cardUrl}" alt="${c.cardName}"><br>
      <strong>${c.cardName}</strong><br>
      <span style="font-size:12px;">${c.cardSlogan || ''}</span><br>
      <label><input type="checkbox" value="${c.cardNo}" onclick="toggleCompare(this)"> 비교함 담기</label>`;
    grid.appendChild(div);
  }
  currentIndex = end;
  if (currentIndex >= fullCardList.length) {
    document.getElementById('loadMoreWrap').style.display = 'none';
  }
}
function loadMore() { drawCards(); }

/* 비교함 */
function toggleCompare(cb) {
  const item = cb.closest('.item'); const cardNo = cb.value;
  const cardName = item.querySelector('strong').innerText;
  const cardUrl = item.querySelector('img').src;
  let box = JSON.parse(sessionStorage.getItem('compareCards') || '[]');
  if (cb.checked) {
    if (box.length >= 3) { alert('최대 3개까지만 비교'); cb.checked = false; return; }
    box.push({ cardNo, cardName, cardUrl });
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
    li.innerHTML = `<img src="${c.cardUrl}" style="width:60px"><br>${c.cardName}`;
    list.appendChild(li);
  });
}
renderCompareList();

/* 비교 모달 */
function openCompare() {
  const box = JSON.parse(sessionStorage.getItem('compareCards') || '[]');
  if (box.length < 2) { alert('최소 2개 이상 선택'); return; }
  document.getElementById('compareModal').style.display = 'block';
  document.getElementById('modalOverlay').style.display = 'block';
  const wrap = document.getElementById('modalContent'); wrap.innerHTML = '';
  box.forEach(c => {
    fetch(`/api/cards/${c.cardNo}`)
      .then(r => r.json())
      .then(d => {
        const div = document.createElement('div');
        div.innerHTML = `
          <img src="${d.cardUrl}" alt="${d.cardName}">
          <h4>${d.cardName}</h4>
          <p><b>연회비:</b> ${d.annualFee?.toLocaleString() || 0}원</p>
          <p style="text-align:left;font-size:12px;">
            <b>주요혜택</b><br>${(d.service || '').replace(/\n/g, '<br>')}
          </p>`;
        wrap.appendChild(div);
      })
      .catch(err => console.error(err));
  });
}
function closeCompareModal() {
  document.getElementById('compareModal').style.display = 'none';
  document.getElementById('modalOverlay').style.display = 'none';
}
</script>
</body>
</html>
