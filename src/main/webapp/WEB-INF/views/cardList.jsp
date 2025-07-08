<%@ page contentType="text/html; charset=UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>카드 리스트</title>
    <style>
        /* ------- 카드 그리드 ------- */
        #cardGrid      { display:flex; flex-wrap:wrap; gap:20px; justify-content:center; }
        .item          { width:180px; text-align:center; }
        .item img      { width:100%; height:auto; border:1px solid #ddd; }

        /* ------- 비교함 ------- */
        #compareBox    { position:fixed; right:20px; top:100px; width:160px;
                         border:1px solid #ccc; background:#fff; padding:10px; z-index:1010; }

        /* ------- 모달 / 오버레이 ------- */
        #compareModal  { display:none; position:fixed; top:50%; left:50%;
                         transform:translate(-50%,-50%); width:80%; max-width:800px;
                         background:#fff; border-radius:12px; box-shadow:0 0 20px rgba(0,0,0,.3);
                         z-index:2000; padding:30px; }
        #modalOverlay  { display:none; position:fixed; inset:0;
                         background:rgba(0,0,0,.6); z-index:1999; }
        #modalContent  { display:flex; flex-wrap:wrap; gap:20px; justify-content:center; }
        #modalContent div { width:200px; text-align:center; }
        #modalContent img { width:100%; border:1px solid #ccc; }
    </style>
</head>
<body>

<h2 style="text-align:center;">카드 목록</h2>

<!-- (1) 카드들이 그려질 자리 -->
<div id="cardGrid"></div>

<!-- (2) 비교함 사이드 박스 -->
<div id="compareBox">
    <h4>비교함</h4>
    <ul id="compareList" style="list-style:none; padding:0; margin:0;"></ul>
    <button type="button" onclick="openCompare()">비교하기</button>
</div>

<!-- (3) 모달 + 오버레이 -->
<div id="compareModal">
    <h2 style="text-align:center;">카드 비교</h2>
    <div id="modalContent"></div>
    <div style="text-align:center; margin-top:20px;">
        <button type="button" onclick="closeModal()">닫기</button>
    </div>
</div>
<div id="modalOverlay" onclick="closeModal()"></div>

<script>
/* ================================================================
   0. 첫 진입 : 전체 카드 목록 Ajax 로딩
   ================================================================ */

document.addEventListener("DOMContentLoaded", () => {
    fetch("/api/cards")
        .then(res => res.json())
        .then(drawCards)
        .catch(err => console.error("카드 목록 로딩 실패", err));
});

/* 그리드에 카드 DOM 생성 */
function drawCards(list){
    const grid = document.getElementById("cardGrid");
    list.forEach(c => {
        const div = document.createElement("div");
        div.className = "item";
        div.innerHTML = `
           <img src="${c.cardUrl}" alt="${c.cardName}"><br>
           <strong>${c.cardName}</strong><br>
           <span style="font-size:12px;">${c.cardSlogan || ''}</span><br>
           <label>
               <input type="checkbox" value="${c.cardNo}" onclick="toggleCompare(this)">
               비교함 담기
           </label>
        `;
        grid.appendChild(div);
    });
}

/* ================================================================
   1. 비교함 사이드-박스
   ================================================================ */
   function toggleCompare(cb){
	    const item     = cb.closest('.item');
	    const cardNo   = cb.value;
	    const cardName = item.querySelector('strong').innerText;
	    const cardUrl  = item.querySelector('img').src;   // 추가 👍

	    let box = JSON.parse(sessionStorage.getItem('compareCards') || '[]');

	    if (cb.checked) {
	        if (box.length >= 3) { alert('최대 3개까지…'); cb.checked = false; return; }
	        box.push({cardNo, cardName, cardUrl});        // url 함께 저장
	    } else {
	        box = box.filter(c => c.cardNo !== cardNo);
	    }
	    sessionStorage.setItem('compareCards', JSON.stringify(box));
	    renderCompareList();
	}

	function renderCompareList(){
	    const list = document.getElementById('compareList');
	    list.innerHTML = '';
	    JSON.parse(sessionStorage.getItem('compareCards') || '[]')
	      .forEach(c => {
	          const li = document.createElement('li');
	          li.innerHTML = `<img src="${c.cardUrl}" style="width:60px;"><br>${c.cardName}`;
	          list.appendChild(li);
	      });
	}
renderCompareList();   // 초기 렌더

/* ================================================================
   2. 모달 열기 / 닫기
   ================================================================ */
function openCompare(){
    const box = JSON.parse(sessionStorage.getItem("compareCards") || "[]");
    if(box.length < 2){
        alert("최소 2개 이상 선택해야 비교가 가능합니다.");
        return;
    }
    document.getElementById("compareModal").style.display = "block";
    document.getElementById("modalOverlay").style.display = "block";

    const wrap = document.getElementById("modalContent");
    wrap.innerHTML = "";

    /* 선택된 카드 상세 Ajax */
    box.forEach(c=>{
        fetch(`/api/cards/${c.cardNo}`)
            .then(r => r.json())
            .then(d => {
                const div = document.createElement("div");
                div.innerHTML = `
                  <img src="${d.cardUrl}" alt="${d.cardName}">
                  <h4>${d.cardName}</h4>
                  <p><b>연회비:</b> ${d.annualFee?.toLocaleString() || 0}원</p>
                  <p style="text-align:left; font-size:12px;">
                      <b>주요혜택</b><br>${(d.service || '').replace(/\n/g, "<br>")}
                  </p>
                `;
                wrap.appendChild(div);
            })
            .catch(err => console.error("카드 상세 로딩 실패", err));
    });
}

function closeModal(){
    document.getElementById("compareModal").style.display = "none";
    document.getElementById("modalOverlay").style.display = "none";
}
</script>
</body>
</html>