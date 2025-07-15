<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    #card-list , #card-list2{
        display: grid;
        grid-template-columns: repeat(4, 1fr); /* 4칸 */
        gap: 16px;
        list-style: none;
        padding: 0;
    }

    .card {
        border: 1px solid #ccc;
        padding: 12px;
        background: #f9f9f9;
        border-radius: 8px;
        text-align: center;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }
    .card img {
	    width: 100%;       /* 카드 너비에 맞춰 꽉 차게 */
	    max-width: 150px;  /* 최대 가로 크기 제한 */
	    height: auto;      /* 비율 유지 */
	    margin-bottom: 12px; /* 제목과 간격 */
	    border-radius: 6px;  /* 둥근 모서리 */
	    object-fit: contain; /* 이미지 왜곡 없이 적절히 맞춤 */
	}
	.hi{
		color:red;
	}
    /* 모달 스타일 */
    #editModal {
        display: none;
        position: fixed;
        top: 20%;
        left: 50%;
        transform: translateX(-50%);
        background: white;
        padding: 20px;
        border: 1px solid #ccc;
        box-shadow: 0 2px 10px rgba(0,0,0,0.3);
        z-index: 1000;
        width: 300px;
    }

    #modalOverlay {
        display: none;
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 999;
    }

    #editModal input {
        width: 100%;
        padding: 6px;
        margin-bottom: 10px;
        box-sizing: border-box;
    }

    #editModal button {
        margin-right: 5px;
    }
</style>
<link rel="stylesheet" href="/css/adminstyle.css">
</head>
<body>
<jsp:include page="../fragments/header.jsp"></jsp:include>
<div class="inner">
	<h1>Admin CardList 페이지</h1>
	<hr>
<button onclick="openModal()">상품 등록</button>

<!-- 모달 오버레이 -->
<div id="modalOverlay"></div>

<!-- 모달 폼 -->
<div id="editModal">
  <h2>상품 등록</h2>
  <form id="cardForm">
    <input type="text" name="cardName" placeholder="카드명">
    <input type="text" name="cardType" placeholder="카드 종류">
    <input type="text" name="cardBrand" placeholder="카드 브랜드">
    <input type="number" name="annualFee" placeholder="연회비">
    <input type="text" name="issuedTo" placeholder="발급 대상">
    <input type="text" name="service" placeholder="주요 서비스">
    <input type="text" name="sService" placeholder="부가 서비스">
    <input type="text" name="cardStatus" placeholder="상태">
    <input type="text" name="cardUrl" placeholder="카드 URL">
    <input type="date" name="cardIssueDate" placeholder="카드 발급일">
    <input type="date" name="cardDueDate" placeholder="카드 만료일">
    <input type="text" name="cardSlogan" placeholder="카드 슬로건">
    <input type="text" name="cardNotice" placeholder="카드 공지사항">
    <div>
      <button type="submit">등록하기</button>
      <button type="button" id="closeModal">닫기</button>
    </div>
  </form>
</div>

<!-- ============================================================= -->
	<h1>게시중인 카드 상품</h1>
	<ul id="card-list"></ul>
	
	<h1>수정중 기타 등등 카드 상품</h1>
	<ul id="card-list2"></ul>
	
	<!-- 모달 오버레이 -->
	<div id="modalOverlay"></div>

	<!-- 수정 모달창 -->
	<div id="editModal">
	    <h3>카드 수정</h3>
	    <input type="text" id="editCardName" placeholder="카드명">
	    <input type="text" id="editCardType" placeholder="카드 종류">
	    <input type="text" id="editCardBrand" placeholder="브랜드 (예: VISA)">
	    <input type="number" id="editAnnualFee" placeholder="연회비">
	    <input type="text" id="editIssuedTo" placeholder="발급대상">
	    <input type="text" id="editService" placeholder="주요 서비스">
	    <input type="text" id="editSService" placeholder="부가 서비스">
	    <input type="text" id="editCardStatus" placeholder="상태">
	    <input type="text" id="editCardUrl" placeholder="카드 URL">
	    <input type="date" id="editCardIssueDate" placeholder="카드 발급일">
	    <input type="date" id="editCardDueDate" placeholder="카드 만료일">
	    <input type="text" id="editCardSlogan" placeholder="카드 슬로건">
	    <input type="text" id="editCardNotice" placeholder="카드 공지사항">
	    <br>
	    <button onclick="submitEdit()">저장</button>
	    <button onclick="closeModal()">닫기</button>
	</div>
</div>


<script src="/js/adminHeader.js"></script>
<script>
    fetch('/admin/card/getCardList') // ← 실제 REST API 경로
        .then(res => res.json())
        .then(cards => {
            const list = document.getElementById('card-list');
            cards.forEach(card => {
                console.log(card);
                const li = document.createElement('li');
                li.className = 'card';
                li.innerHTML = `
                	<p style="color: green">\${card.cardStatus === '게시중' ? '게시중' : '&nbsp;'}</p>
                	<img src=\${card.cardUrl}>
                    <h3 class="hi">\${card.cardName}</h3>
                    <p>연회비: \${card.annualFee}원</p>
                    <p>브랜드: \${card.cardBrand}</p>
                    <p>조회수: \${card.viewCount}</p>
                    <button onclick='openEditModal(\${JSON.stringify(card)})'>수정</button>
                    <button onclick='deleteCard(\${card.cardNo})'>삭제</button>
                `;
                list.appendChild(li);
            });
        })
        .catch(err => {
            document.getElementById('card-list').innerText = '카드 정보를 불러오지 못했습니다.';
            console.error('에러:', err);
        });
    
    fetch('/admin/card/getCardList2') // ← 실제 REST API 경로
    .then(res => res.json())
    .then(cards => {
        const list = document.getElementById('card-list2');
        cards.forEach(card => {
            console.log(card);
            const li = document.createElement('li');
            li.className = 'card';
            li.innerHTML = `
            	<img src=\${card.cardUrl}>
                <h3 class="hi">\${card.cardName}</h3>
                <p>연회비: \${card.annualFee}원</p>
                <p>브랜드: \${card.cardBrand}</p>
                <p>조회수: \${card.viewCount}</p>
                <button onclick='openEditModal(\${JSON.stringify(card)})'>수정</button>
                <button onclick='deleteCard(\${card.cardNo})'>삭제</button>
            `;
            list.appendChild(li);
        });
    })
    .catch(err => {
        document.getElementById('card-list').innerText = '카드 정보를 불러오지 못했습니다.';
        console.error('에러:', err);
    });
    
 // 수정 모달 열기
    function openEditModal(card) {
	 	console.log(card)
        editingCardId = card.cardNo;
        document.getElementById('editCardName').value = card.cardName;
        document.getElementById('editCardType').value = card.cardType;
        document.getElementById('editCardBrand').value = card.cardBrand;
        document.getElementById('editAnnualFee').value = card.annualFee;
        document.getElementById('editIssuedTo').value = card.issuedTo;
        document.getElementById('editService').value = card.service;
        document.getElementById('editSService').value = card.sService;
        document.getElementById('editCardStatus').value = card.cardStatus;
        document.getElementById('editCardUrl').value = card.cardUrl;
        document.getElementById('editCardIssueDate').value = card.cardIssueDate;
        document.getElementById('editCardDueDate').value = card.cardDueDate;
        document.getElementById('editCardSlogan').value = card.cardSlogan;
        document.getElementById('editCardNotice').value = card.cardNotice;

        document.getElementById('editModal').style.display = 'block';
        document.getElementById('modalOverlay').style.display = 'block';
    }

    // 모달 닫기
    function closeModal() {
        document.getElementById('editModal').style.display = 'none';
        document.getElementById('modalOverlay').style.display = 'none';
    }

    // 수정 요청 보내기
    function submitEdit() {
        const updatedCard = {
            cardName: document.getElementById('editCardName').value,
            cardType: document.getElementById('editCardType').value,
            cardBrand: document.getElementById('editCardBrand').value,
            annualFee: parseInt(document.getElementById('editAnnualFee').value, 10),
            issuedTo: document.getElementById('editIssuedTo').value,
            service: document.getElementById('editService').value,
            sService: document.getElementById('editSService').value,
            cardStatus: document.getElementById('editCardStatus').value,
            cardUrl: document.getElementById('editCardUrl').value,
            cardIssueDate: document.getElementById('editCardIssueDate').value,
            cardDueDate: document.getElementById('editCardDueDate').value,
            cardSlogan: document.getElementById('editCardSlogan').value,
            cardNotice: document.getElementById('editCardNotice').value,
        };
		console.log(updatedCard);
        fetch(`/admin/card/editCard/\${editingCardId}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updatedCard)
        })
        .then(res => {
            if (!res.ok) throw new Error('수정 실패');
            alert('수정신청 완료');
            location.reload(); // 새로고침으로 리스트 갱신
        })
        .catch(err => {
            alert('수정신청 중 오류 발생');
            console.error(err);
        });
    }

    // 삭제 요청 (옵션)
    function deleteCard(cardNo) {
        if (!confirm('정말 삭제하시겠습니까?')) return;
        fetch(`/admin/card/deleteCard/\${cardNo}`, {
            method: 'POST'
        })
        .then(() => {
            alert('삭제신청 완료');
            location.reload();
        })
        .catch(err => {
            alert('삭제신청 실패');
            console.error(err);
        });
    }
    
    
    
    
    //=================================================
    
    function openModal() {
    	  document.getElementById('modalOverlay').style.display = 'block';
    	  document.getElementById('editModal').style.display = 'block';
    	}

 // 닫기 버튼 이벤트
 document.getElementById('closeModal').addEventListener('click', closeModal);

 // 폼 제출 이벤트
 document.getElementById("cardForm").addEventListener("submit", function(e) {
   e.preventDefault();

   const form = e.target;
   const data = {
     cardName: form.cardName.value,
     cardType: form.cardType.value,
     cardBrand: form.cardBrand.value,
     annualFee: parseInt(form.annualFee.value || "0", 10),
     issuedTo: form.issuedTo.value,
     service: form.service.value,
     sService: form.sService.value,
     cardStatus: form.cardStatus.value,
     cardUrl: form.cardUrl.value,
     cardIssueDate: form.cardIssueDate.value,
     cardDueDate: form.cardDueDate.value,
     cardSlogan: form.cardSlogan.value,
     cardNotice: form.cardNotice.value
   };

   fetch("/admin/cardRegist", {
     method: "POST",
     headers: { "Content-Type": "application/json" },
     body: JSON.stringify(data)
   })
   .then(response => {
     if (!response.ok) return response.text().then(text => { throw new Error(text); });
     return response.json();
   })
   .then(result => {
     alert(result.message);
     if (result.success) {
       closeModal();
       // 새로고침 or 리스트 갱신
       window.location.reload();
     }
   })
   .catch(error => {
     alert("오류가 발생했습니다: " + error.message);
     console.error(error);
   });
 });
    
</script>
</body>
</html>