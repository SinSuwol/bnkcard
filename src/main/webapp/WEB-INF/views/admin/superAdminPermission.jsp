<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카드 승인 검토</title>
<style>
/* ===== 글로벌 ===== */
body {
  margin: 0;
  font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', sans-serif;
  background-color: #f5f7fa;
  color: #2c3e50;
  line-height: 1.6;
}

h1 {
  font-size: 22px;
  margin-bottom: 24px;
  font-weight: 600;
  color: #34495e;
}

/* ===== 테이블 스타일 ===== */
table {
  width: 50%;
  margin: 0 auto; 
  border-collapse: collapse;
  background-color: #fff;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

thead {
  background-color: #f1f3f5;
}

thead th {
  padding: 14px 12px;
  font-size: 14px;
  color: #495057;
  border-bottom: 1px solid #dee2e6;
}

tbody td {
  padding: 14px 12px;
  font-size: 14px;
  text-align: center;
  border-bottom: 1px solid #f1f3f5;
}

tbody tr:hover {
  background-color: #f8f9fa;
}

/* ===== 버튼 ===== */
button {
  color: black;
  border: none;
  padding: 8px 14px;
  font-size: 14px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.2s ease, transform 0.1s ease;
}

button:hover {
  background-color: #2980b9;
}

button:active {
  transform: scale(0.97);
}

button:disabled {
  background-color: #ced4da;
  cursor: not-allowed;
}

/* ===== 페이지네이션 ===== */
#pagination button {
  background-color: #fff;
  color: #495057;
  border: 1px solid #ced4da;
  padding: 6px 10px;
  margin: 0 2px;
  border-radius: 4px;
  font-size: 14px;
  transition: background-color 0.2s;
}

#pagination button:hover {
  background-color: #e9ecef;
}

#pagination button:disabled {
  color: #adb5bd;
  background-color: #f1f3f5;
}

/* ===== 모달 오버레이 ===== */
#modalOverlay {
  display: none;
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0, 0, 0, 0.4);
  z-index: 999;
}

/* ===== 모달 박스 ===== */
.modalBox {
  display: none;
  position: fixed;
  top: 10%;
  left: 50%;
  transform: translateX(-50%);
  width: 80%;
  max-width: 440ㅔㅌ;
  background: #fff;
  border-radius: 8px;
  padding: 20px;
  z-index: 1000;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
  overflow-y: auto;
  max-height: 85%;
}

.modalBox h2 {
  font-size: 18px;
  color: #2c3e50;
  margin-bottom: 16px;
}

/* ===== 모달 내용 ===== */
.modalBox p {
  margin-bottom: 12px;
  font-size: 14px;
  color: #212529;
}

.modalBox input,
.modalBox textarea,
.modalBox select {
  width: 100%;
  padding: 8px 10px;
  font-size: 14px;
  border: 1px solid #ced4da;
  border-radius: 4px;
  box-sizing: border-box;
}

.modalBox textarea {
  resize: vertical;
  min-height: 80px;
}

/* ===== 버튼 영역 ===== */
#approveButtons,
#updateButtons,
#deleteButtons,
#rejectSection {
  margin-top: 20px;
}

#rejectSection h3 {
  font-size: 16px;
  color: #2c3e50;
  margin-bottom: 10px;
}

#rejectSection textarea {
  margin-top: 8px;
}

/* ===== 반응형 개선 (선택 사항) ===== */
@media (max-width: 600px) {
  .modalBox {
  width: 95%;
    padding: 12px;
  }

  table thead {
    display: none;
  }

  table, table tbody, table tr, table td {
    display: block;
    width: 100%;
  }

  table tr {
    margin-bottom: 15px;
    border-bottom: 1px solid #ddd;
    background: #fff;
    padding: 10px;
  }

  table td {
    text-align: right;
    padding-left: 50%;
    position: relative;
  }

  table td::before {
    content: attr(data-label);
    position: absolute;
    left: 10px;
    top: 10px;
    font-weight: bold;
    color: #495057;
    text-align: left;
  }
}

@media (max-width: 768px) {
  body {
    padding: 16px;
  }

  h1 {
    font-size: 18px;
    text-align: center;
  }

  table {
    width: 100%;
    box-shadow: none;
  }

  thead {
    display: none;
  }

  table, tbody, tr, td {
    display: block;
    width: 100%;
  }

  tbody tr {
    margin-bottom: 16px;
    border-radius: 6px;
    border: 1px solid #dee2e6;
    background: #fff;
    padding: 12px;
  }

  tbody td {
    text-align: left;
    padding: 8px 12px;
    position: relative;
  }

  tbody td::before {
    content: attr(data-label);
    font-weight: bold;
    color: #495057;
    display: block;
    margin-bottom: 4px;
  }

  /* 모달 반응형 */
  .modalBox {
    width: 95%;
    padding: 16px;
    max-height: 90%;
    top: 5%;
  }

  .modalBox h2 {
    font-size: 16px;
    margin-bottom: 12px;
  }

  .modalBox p {
    margin-bottom: 10px;
  }

  .modalBox input,
  .modalBox textarea,
  .modalBox select {
    font-size: 13px;
    padding: 6px 8px;
  }



  #rejectSection h3 {
    font-size: 14px;
  }

  #pagination button {
    font-size: 13px;
    padding: 4px 8px;
  }
}

/* 기존 카드 정보 (왼쪽) */
#modalOriginal {
  display: none;
  position: fixed;
  top: 10%;
  left: 5%;
  transform: none;
  width: 38%;
  background: #fff;
  border-radius: 8px;
  padding: 16px;
  z-index: 1000;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
  overflow-y: auto;
  max-height: 85%;
}

/* 요청 카드 정보 (오른쪽) */
#modalTemp {
  display: none;
  position: fixed;
  top: 10%;
  right: 5%;
  transform: none;
  width: 38%;
  background: #fff;
  border-radius: 8px;
  padding: 16px;
  z-index: 1000;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
  overflow-y: auto;
  max-height: 85%;
}


</style>
<link rel="stylesheet" href="/css/adminstyle.css">
</head>
<body>
<jsp:include page="../fragments/header.jsp"></jsp:include>
<h1>카드 승인 검토</h1>

<table border="1" cellpadding="6" width="100%">
<thead>
<tr>
  <th>승인 번호</th>
  <th>카드 번호</th>
  <th>상태</th>
  <th>사유</th>
  <th>요청 관리자</th>
  <th>처리 관리자</th>
  <th>요청일</th>
  <th>처리일</th>
  <th>요청 내용</th>
  <th>작업</th>
</tr>
</thead>
<tbody id="permissionTable"></tbody>
</table>
<div id="pagination" style="margin-top:10px; text-align:center;"></div>

<div id="modalOverlay"></div>

<!-- 기존 카드 모달 -->
<div id="modalOriginal" class="modalBox">
  <h2>기존 카드 정보</h2>
  <p>카드명: <input id="originalCardName" readonly></p>
  <p>카드 종류: <input id="originalCardType" readonly></p>
  <p>브랜드: <input id="originalCardBrand" readonly></p>
  <p>연회비: <input id="originalAnnualFee" readonly></p>
  <p>발급 대상: <input id="originalIssuedTo" readonly></p>
  <p>서비스: <input id="originalService" readonly></p>
  <p>부가 서비스: <input id="originalSService" readonly></p>
  <p>상태: <input id="originalCardStatus" readonly></p>
  <p>카드 URL: <input id="originalCardUrl" readonly></p>
  <p>슬로건: <input id="originalCardSlogan" readonly></p>
  <p>주의사항: <textarea id="originalCardNotice" readonly></textarea></p>
</div>

<!-- TEMP 카드 모달 -->
<div id="modalTemp" class="modalBox">
  <h2>요청 카드 정보</h2>
  <input type="hidden" id="modalCardNo">
  <p>카드명: <input id="modalCardName" readonly></p>
  <p>카드 종류: <input id="modalCardType" readonly></p>
  <p>브랜드: <input id="modalCardBrand" readonly></p>
  <p>연회비: <input id="modalAnnualFee" readonly></p>
  <p>발급 대상: <input id="modalIssuedTo" readonly></p>
  <p>서비스: <input id="modalService" readonly></p>
  <p>부가 서비스: <input id="modalSService" readonly></p>
  <p>상태: <input id="modalCardStatus" readonly></p>
  <p>카드 URL: <input id="modalCardUrl" readonly></p>
  <p>슬로건: <input id="modalCardSlogan" readonly></p>
  <p>주의사항: <textarea id="modalCardNotice" readonly></textarea></p>

  <div id="approveButtons" style="margin-top:10px; display:none;">
      <button onclick="approve()">등록</button>
      <button onclick="showReject()">보류/불허</button>
  </div>
  <div id="updateButtons" style="margin-top:10px; display:none;">
      <button onclick="update()">수정</button>
      <button onclick="showReject()">보류/불허</button>
  </div>
  <div id="deleteButtons" style="margin-top:10px; display:none;">
      <button onclick="remove()">삭제</button>
      <button onclick="showReject()">보류/불허</button>
  </div>
  <button onclick="closeModal()">닫기</button>

  <div id="rejectSection" style="display:none; margin-top:10px;">
      <h3>보류/불허 처리</h3>
      <select id="rejectStatus">
          <option value="보류">보류</option>
          <option value="불허">불허</option>
      </select>
      <textarea id="rejectReason" placeholder="사유를 입력하세요"></textarea>
      <button onclick="submitReject()">처리하기</button>
  </div>
</div>


<script src="/js/adminHeader.js"></script>
<script>
let currentPage = 1;

function loadPermissions(page) {
	 if (!page) page = 1;
	    console.log('loadPermissions() 호출됨, page=', page);
	    currentPage = page;

	    const size = 10;

    fetch(`/superadmin/permission/list?page=\${page}&size=\${size}`)
        .then(res => res.json())
        .then(result => {
        	 console.log('API 응답 도착, page=', page, 'result:', result);
        	
            const data = result.content || [];
            const totalPages = result.totalPages;

            const tbody = document.getElementById('permissionTable');
            tbody.innerHTML = '';

            data.forEach(row => {
                const regDate = row.regDate ? row.regDate.substring(0,10) : '';
                const perDate = row.perDate ? row.perDate.substring(0,10) : '';
                const perContent = row.perContent || '';

                let actionHtml = '';
                if (row.status === '대기중') {
                    actionHtml = `<button onclick="openModal(\${row.cardNo}, '\${perContent}')">검토하기</button>`;
                } else {
                    actionHtml = `<span style="color:gray;">처리 완료</span>`;
                }

                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>\${row.perNo}</td>
                    <td>\${row.cardNo}</td>
                    <td>\${row.status}</td>
                    <td>\${row.reason}</td>
                    <td>\${row.admin}</td>
                    <td>\${row.sadmin}</td>
                    <td>\${regDate}</td>
                    <td>\${perDate}</td>
                    <td>\${perContent}</td>
                    <td>\${actionHtml}</td>
                `;
                tbody.appendChild(tr);
            });

            renderPagination(totalPages, page);
        });
}


function renderPagination(totalPages, page) {
    const container = document.getElementById('pagination');
    container.innerHTML = '';

    if (totalPages <= 1) return;

    for (let i = 1; i <= totalPages; i++) {
        const btn = document.createElement('button');
        btn.textContent = i;
        btn.style.margin = '0 3px';
        if (i === page) {
            btn.style.fontWeight = 'bold';
        }
        // IIFE로 캡처
        (function(pageNumber) {
            btn.addEventListener('click', function() {
                console.log('버튼 클릭: 페이지', pageNumber);
                loadPermissions(pageNumber);
            });
        })(i);
        container.appendChild(btn);
    }
}


function openModal(cardNo, perContent) {
    // 버튼 초기화
    document.getElementById('approveButtons').style.display = 'none';
    document.getElementById('updateButtons').style.display = 'none';
    document.getElementById('deleteButtons').style.display = 'none';
    document.getElementById('rejectSection').style.display = 'none';

    // 모달 초기화
    document.getElementById('modalOriginal').style.display = 'none';

    // 버튼 표시
    if (perContent === '등록') {
        document.getElementById('approveButtons').style.display = 'block';
    } else if (perContent === '수정') {
        document.getElementById('updateButtons').style.display = 'block';
    } else if (perContent === '삭제') {
        document.getElementById('deleteButtons').style.display = 'block';
    }

    // 데이터 로드
    fetch('/superadmin/permission/temp/' + cardNo)
    .then(res => res.json())
    .then(data => {
        const temp = data.temp || {};

        // TEMP 카드 정보
        document.getElementById('modalCardNo').value = temp.cardNo;
        document.getElementById('modalCardName').value = temp.cardName || '';
        document.getElementById('modalCardType').value = temp.cardType || '';
        document.getElementById('modalCardBrand').value = temp.cardBrand || '';
        document.getElementById('modalAnnualFee').value = temp.annualFee || '';
        document.getElementById('modalIssuedTo').value = temp.issuedTo || '';
        document.getElementById('modalService').value = temp.service || '';
        document.getElementById('modalSService').value = temp.sService || '';
        document.getElementById('modalCardStatus').value = temp.cardStatus || '';
        document.getElementById('modalCardUrl').value = temp.cardUrl || '';
        document.getElementById('modalCardSlogan').value = temp.cardSlogan || '';
        document.getElementById('modalCardNotice').value = temp.cardNotice || '';

        if (perContent === '수정') {
            const orig = data.original || {};
            document.getElementById('originalCardName').value = orig.cardName || '(없음)';
            document.getElementById('originalCardType').value = orig.cardType || '(없음)';
            document.getElementById('originalCardBrand').value = orig.cardBrand || '(없음)';
            document.getElementById('originalAnnualFee').value = orig.annualFee || '';
            document.getElementById('originalIssuedTo').value = orig.issuedTo || '';
            document.getElementById('originalService').value = orig.service || '';
            document.getElementById('originalSService').value = orig.sService || '';
            document.getElementById('originalCardStatus').value = orig.cardStatus || '';
            document.getElementById('originalCardUrl').value = orig.cardUrl || '';
            document.getElementById('originalCardSlogan').value = orig.cardSlogan || '';
            document.getElementById('originalCardNotice').value = orig.cardNotice || '';
            document.getElementById('modalOriginal').style.display = 'block';
        }

        document.getElementById('modalOverlay').style.display = 'block';
        document.getElementById('modalTemp').style.display = 'block';
    });

}

function closeModal() {
    document.getElementById('modalOverlay').style.display = 'none';
    document.getElementById('modalOriginal').style.display = 'none';
    document.getElementById('modalTemp').style.display = 'none';
}

// 승인 처리
function approve() { sendApprove(); }
function update() { sendApprove(); }
function sendApprove() {
    const payload = {
        cardNo: document.getElementById('modalCardNo').value,
        cardName: document.getElementById('modalCardName').value,
        cardType: document.getElementById('modalCardType').value,
        cardBrand: document.getElementById('modalCardBrand').value,
        annualFee: document.getElementById('modalAnnualFee').value,
        cardStatus: document.getElementById('modalCardStatus').value
    };
    fetch('/superadmin/permission/approve', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(payload)
    })
    .then(res => res.json())
    .then(data => {
        alert(data.message);
        closeModal();
        loadPermissions(currentPage); // 현재 페이지 다시 로드
    });
}

// 삭제 처리
function remove() {
    const cardNo = document.getElementById('modalCardNo').value;
    fetch('/superadmin/permission/delete?cardNo=' + cardNo, {
        method: 'POST'
    })
    .then(res => res.json())
    .then(data => {
        alert(data.message);
        closeModal();
        loadPermissions(currentPage); // 현재 페이지 다시 로드
    });
}

// 보류/불허 처리
function showReject() {
    document.getElementById('rejectSection').style.display = 'block';
}
function submitReject() {
    const cardNo = document.getElementById('modalCardNo').value;
    const status = document.getElementById('rejectStatus').value;
    const reason = document.getElementById('rejectReason').value;
    if (!reason.trim()) {
        alert('사유를 입력하세요.');
        return;
    }
    fetch('/superadmin/permission/reject?cardNo='+cardNo+'&status='+status+'&reason='+encodeURIComponent(reason),{
        method:'POST'
    })
    .then(res=>res.json())
    .then(data=>{
        alert(data.message);
        closeModal();
        loadPermissions(currentPage); // 현재 페이지 다시 로드
    });
}



// 초기 로드
if (currentPage === 1) {
    loadPermissions(1);
}
</script>

</body>
</html>
