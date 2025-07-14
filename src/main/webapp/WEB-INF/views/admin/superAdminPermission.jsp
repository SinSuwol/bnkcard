<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카드 승인 검토</title>
<style>
#modalOverlay {
    display: none;
    position: fixed;
    top:0; left:0; right:0; bottom:0;
    background: rgba(0,0,0,0.5);
    z-index: 999;
}
.modalBox {
    display: none;
    position: fixed;
    top: 10%;
    width: 40%;
    background: #fff;
    padding: 15px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.3);
    z-index: 1000;
}
#modalOriginal { left: 5%; }
#modalTemp { right: 5%; }
.modalBox input, .modalBox textarea {
    width: 100%;
    margin-bottom: 5px;
}
</style>
</head>
<body>

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

<script>
function loadPermissions() {
    fetch('/superadmin/permission/list')
        .then(res => res.json())
        .then(data => {
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
        });
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
        loadPermissions();
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
        loadPermissions();
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
        loadPermissions();
    });
}



// 초기 로드
loadPermissions();
</script>

</body>
</html>
