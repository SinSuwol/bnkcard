<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 상품 목록 페이지</title>
<style>
/* 공통 */
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f4f6f8;
	color: #333;
	margin: 0;
	padding: 0;
}

.inner {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

h1 {
	font-size: 1.4rem;
	margin: 30px 0 20px 0;
	color: #2c3e50;
	border-left: 4px solid #3498db;
	padding-left: 8px;
}

hr {
	border: none;
	border-top: 1px solid #ddd;
	margin: 20px 0;
}

/* 카드 목록 */
#card-list, #card-list2 {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	gap: 20px;
	list-style: none;
	padding: 0;
}

.card {
	background: white;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.06);
	padding: 16px;
	text-align: center;
	font-size: 14px;
	transition: transform 0.2s;
	position: relative;
}

.card:hover {
	transform: translateY(-4px);
}

.card img {
	max-width: 120px;
	margin: 0 auto 10px;
	display: block;
	border-radius: 8px;
	object-fit: contain;
}

.card h3 {
	font-size: 15px;
	color: #2c3e50;
	margin: 8px 0;
	font-weight: 600;
}

.card p {
	margin: 4px 0;
	font-size: 13px;
}

.card .badge {
	position: absolute;
	top: 10px;
	left: 10px;
	padding: 4px 8px;
	border-radius: 4px;
	font-size: 11px;
	font-weight: bold;
	color: #fff;
}

.card .badge.posting {
	background-color: #2ecc71;
}

.card .badge.editing {
	background-color: #f39c12;
}

/* 버튼 */
button {
	padding: 6px 12px;
	font-size: 13px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.2s, transform 0.1s;
}

#searchBtn {
	color: white;
	background-color: #ed1e1e;
}

.card button:first-of-type {
	background-color: #27ae60;
	color: #fff;
	margin-right: 4px;
}

.card button:first-of-type:hover {
	background-color: #1e874b;
}

.card button:last-of-type {
	background-color: #e74c3c;
	color: #fff;
}

.card button:last-of-type:hover {
	background-color: #c0392b;
}

button:active {
	transform: scale(0.96);
}

button[onclick="openModal()"] {
	background-color: #3498db;
	color: #fff;
	margin-bottom: 12px;
	width: 40%;
	margin: 0 auto;
	margin-top: 35px;
}

button[onclick="openModal()"]:hover {
	background-color: #2980b9;
}

.tit2 {
	margin-top: 100px;
}

/* 검색창 */
.search-container {
	display: flex;
	justify-content: center;
	margin: 20px 0;
	gap: 10px;
}

#searchInput {
	width: 240px;
	padding: 8px 12px;
	font-size: 13px;
	border: 1px solid #ccc;
	border-radius: 6px;
	outline: none;
	transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

#searchInput:focus {
	border-color: #c10c0c;
	box-shadow: 0 0 5px rgba(193, 12, 12, 0.3);
}

/* 모달 공통 */
#modalOverlay {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 999;
}

#editModal, #registerModal {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background: white;
	padding: 30px 40px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	z-index: 1000;
	width: 400px;
	max-height: 90vh;
	overflow-y: auto;
}

#editModal h3, #registerModal h3 {
	text-align: center;
	margin-bottom: 20px;
	font-size: 18px;
	color: #2c3e50;
}

.form-group {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.form-group label {
	width: 90px;
	font-weight: bold;
	font-size: 13px;
	margin-right: 10px;
}

.form-group input {
	flex: 1;
	padding: 6px;
	font-size: 13px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

.modal-buttons {
	text-align: center;
	margin-top: 20px;
}

.modal-buttons button {
	margin: 0 8px;
	padding: 6px 12px;
	font-size: 13px;
	border: none;
	border-radius: 4px;
	background-color: #007bff;
	color: white;
	cursor: pointer;
}

.modal-buttons button:hover {
	background-color: #0056b3;
}

#progressContainer {
  position: relative;
  width: 100%;
  height: 25px;
  background: #eee;
  border-radius: 10px;
  overflow: hidden;
  margin-top: 10px;
}

#progressBar {
  height: 100%;
  width: 0%;
  background: #FFA726;
  transition: width 0.2s ease;
}

#progressText {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: #333;
  font-weight: bold;
}

</style>


<link rel="stylesheet" href="/css/adminstyle.css">
</head>
<body>
	<jsp:include page="../fragments/header.jsp"></jsp:include>
	<div class="inner">


		<!-- 모달 오버레이 -->
		<div id="modalOverlay"></div>

		<!-- 모달 폼 -->
		<div id="registerModal">
			<h3>상품 등록</h3>
			<form id="cardForm">
				<div class="form-group">
					<label for="cardName">카드명</label> <input type="text" id="cardName"
						name="cardName" placeholder="카드명">
				</div>
				<div class="form-group">
					<label for="cardType">카드 종류</label> <input type="text"
						id="cardType" name="cardType" placeholder="카드 종류">
				</div>
				<div class="form-group">
					<label for="cardBrand">브랜드</label> <input type="text"
						id="cardBrand" name="cardBrand" placeholder="카드 브랜드">
				</div>
				<div class="form-group">
					<label for="annualFee">연회비</label> <input type="number"
						id="annualFee" name="annualFee" placeholder="연회비">
				</div>
				<div class="form-group">
					<label for="issuedTo">발급 대상</label> <input type="text"
						id="issuedTo" name="issuedTo" placeholder="발급 대상">
				</div>
				<div class="form-group">
					<label for="service">주요 서비스</label> <input type="text" id="service"
						name="service" placeholder="주요 서비스">
				</div>
				<div class="form-group">
					<label for="sService">부가 서비스</label> <input type="text"
						id="sService" name="sService" placeholder="부가 서비스">
				</div>
				<div class="form-group">
					<label for="cardStatus">상태</label> <input type="text"
						id="cardStatus" name="cardStatus" placeholder="상태">
				</div>
				<div class="form-group">
					<label for="cardUrl">카드 URL</label> <input type="text" id="cardUrl"
						name="cardUrl" placeholder="카드 URL">
				</div>
				<div class="form-group">
					<label for="cardIssueDate">카드 발급일</label> <input type="date"
						id="cardIssueDate" name="cardIssueDate" placeholder="카드 발급일">
				</div>
				<div class="form-group">
					<label for="cardDueDate">카드 만료일</label> <input type="date"
						id="cardDueDate" name="cardDueDate" placeholder="카드 만료일">
				</div>
				<div class="form-group">
					<label for="cardSlogan">카드 슬로건</label> <input type="text"
						id="cardSlogan" name="cardSlogan" placeholder="카드 슬로건">
				</div>
				<div class="form-group">
					<label for="cardNotice">카드 공지사항</label> <input type="text"
						id="cardNotice" name="cardNotice" placeholder="카드 공지사항">
				</div>

				<div class="modal-buttons">
					<button type="submit">등록</button>
					<button type="button" id="closeModal">닫기</button>
				</div>
			</form>
		</div>


		<!-- 검색창 -->
		<div class="search-container">
			<input type="text" id="searchInput" placeholder="카드명 검색">
			<button id="searchBtn">검색</button>
		</div>



		<!-- ============================================================= -->

		<!-- 학습 버튼 -->
		<button id="trainBtn" class="btn btn-warning">AI 정보 업데이트 (학습)</button>

		<!-- 프로그레스 바 -->
		<div id="progressContainer">
			<div id="progressBar"></div>
			<span id="progressText">0%</span>
		</div>
		<!-- 학습 시간 -->
		<span id="lastTrained" style="font-size: 13px; color: #555;">마지막
			학습 시간: 불러오는 중...</span>


		<h1 class="tit1">게시중인 카드 상품</h1>
		<ul id="card-list"></ul>

		<h1 class="tit2">수정중 기타 등등 카드 상품</h1>
		<ul id="card-list2"></ul>

		<!-- 모달 오버레이 -->
		<div id="modalOverlay"></div>

		<!-- 수정 모달창 -->
		<div id="editModal">
			<h3>카드 수정</h3>

			<div class="form-group">
				<label>카드명</label> <input type="text" id="editCardName">
			</div>

			<div class="form-group">
				<label>카드 종류</label> <input type="text" id="editCardType">
			</div>

			<div class="form-group">
				<label>브랜드</label> <input type="text" id="editCardBrand">
			</div>

			<div class="form-group">
				<label>연회비</label> <input type="number" id="editAnnualFee">
			</div>

			<div class="form-group">
				<label>발급대상</label> <input type="text" id="editIssuedTo">
			</div>

			<div class="form-group">
				<label>주요 서비스</label> <input type="text" id="editService">
			</div>

			<div class="form-group">
				<label>부가 서비스</label> <input type="text" id="editSService">
			</div>

			<div class="form-group">
				<label>상태</label> <input type="text" id="editCardStatus">
			</div>

			<div class="form-group">
				<label>카드 URL</label> <input type="text" id="editCardUrl">
			</div>

			<div class="form-group">
				<label>발급일</label> <input type="date" id="editCardIssueDate">
			</div>

			<div class="form-group">
				<label>만료일</label> <input type="date" id="editCardDueDate">
			</div>

			<div class="form-group">
				<label>슬로건</label> <input type="text" id="editCardSlogan">
			</div>

			<div class="form-group">
				<label>공지사항</label> <input type="text" id="editCardNotice">
			</div>

			<div class="modal-buttons">
				<button onclick="submitEdit()">저장</button>
				<button onclick="closeModal()">닫기</button>
			</div>
		</div>
		<button onclick="openModal()">상품 등록</button>
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
        document.getElementById('registerModal').style.display = 'none';
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
    	  document.getElementById('registerModal').style.display = 'block';
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
    
	//검색
	document.getElementById('searchInput').addEventListener('input', function() {
	    const query = this.value.trim().toLowerCase();
	
	    if (!query) {
	        // 입력이 비어 있으면 전체 다시 보이기
	        document.querySelectorAll('.card').forEach(card => {
	            card.style.display = '';
	        });
	        return;
	    }
	
	    function filterCards(listId) {
	        const list = document.getElementById(listId);
	        const cards = list.querySelectorAll('.card');
	        cards.forEach(card => {
	            const cardName = card.querySelector('h3.hi').textContent.toLowerCase();
	            if (cardName.includes(query)) {
	                card.style.display = '';
	            } else {
	                card.style.display = 'none';
	            }
	        });
	    }
	
	    filterCards('card-list');
	    filterCards('card-list2');
	});

	
	
	
	
	
	
	/*----------------------------------------------------------------------------------------  */
	document.addEventListener("DOMContentLoaded", () => {
    const btn = document.getElementById("trainBtn");
    const timeLabel = document.getElementById("lastTrained");

    
    function fakeProgress(callback) {
    	  const bar = document.getElementById("progressBar");
    	  const text = document.getElementById("progressText");
    	  const container = document.getElementById("progressContainer");
    	  container.style.display = "block";

    	  let percent = 0;

    	  const interval = setInterval(() => {
    	    percent += Math.random() * 8;
    	    if (percent >= 100) {
    	      percent = 100;
    	      clearInterval(interval);
    	      if (callback) callback(); // 학습 요청 보내기
    	    }

    	    bar.style.width = percent + "%";
    	    text.textContent = Math.floor(percent) + "%";
    	  }, 200);
    	}

    
    // 마지막 학습 시간 로드
    fetch("http://localhost:8000/train-card/time")
        .then(res => res.json())
        .then(data => {
            timeLabel.textContent = "마지막 학습 시간: " + data.last_trained;
        });

    // 버튼 클릭 이벤트
    btn.addEventListener("click", () => {
        if (!confirm("정말 AI 정보를 업데이트 하시겠습니까?")) return;

        btn.disabled = true;
        btn.innerText = "학습 중입니다...";

        //  프로그레스바 시작
        fakeProgress(() => {
            //  학습 요청 후 처리
            fetch("http://localhost:8000/train-card", {
                method: "POST"
            })
            .then(res => res.json())
            .then(data => {
                console.log("서버 응답:", data);
                if (data.message) {
                    alert("학습 완료: " + data.message);
                } else if (data.error) {
                    alert("오류: " + data.error);
                } else {
                    alert("응답 형식이 예상과 다릅니다.");
                }
                return fetch("http://localhost:8000/train-card/time");
            })
            .then(res => res.json())
            .then(data => {
                timeLabel.textContent = "마지막 학습 시간: " + data.last_trained;
            })
            .catch(err => {
                alert("오류 발생: " + err);
                console.error(err);
            })
            .finally(() => {
                // ✅ 학습 완료 후 버튼 복구 & 진행률 숨김
                btn.disabled = false;
                btn.innerText = "AI 정보 업데이트 (학습)";
                document.getElementById("progressContainer").style.display = "none";
            });
        });
    });
});

</script>
</body>
</html>