<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카드 승인 검토</title>
<style>
/* 모달 */
#modalOverlay {
    display: none;
    position: fixed;
    top:0; left:0; right:0; bottom:0;
    background: rgba(0,0,0,0.5);
    z-index: 999;
}
#editModal {
    display: none;
    position: fixed;
    top: 15%;
    left: 50%;
    transform: translateX(-50%);
    background: white;
    padding: 20px;
    width: 500px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.3);
    z-index: 1000;
}
#editModal input, #editModal textarea {
    width: 100%;
    margin-bottom: 10px;
}
</style>
</head>
<body>

<h1>카드 승인 검토</h1>

<table border="1" cellpadding="6">
<thead>
<tr>
  <th>PER_NO</th>
  <th>CARD_NO</th>
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
<tbody id="permissionTable">
<!-- fetch로 렌더링 -->
</tbody>
</table>

<div id="modalOverlay"></div>

<div id="editModal">
    <h2>카드 상세 정보</h2>
    <form id="approvalForm">
        <input type="hidden" id="modalCardNo">
        <p>카드명: <input type="text" id="modalCardName" readonly></p>
        <p>카드 종류: <input type="text" id="modalCardType" readonly></p>
        <p>카드 브랜드: <input type="text" id="modalCardBrand" readonly></p>
        <p>연회비: <input type="number" id="modalAnnualFee" readonly></p>
        <p>발급 대상: <input type="text" id="modalIssuedTo" readonly></p>
        <p>서비스: <input type="text" id="modalService" readonly></p>
        <p>부가 서비스: <input type="text" id="modalSService" readonly></p>
        <p>상태: <input type="text" id="modalCardStatus" readonly></p>
        <p>카드 URL: <input type="text" id="modalCardUrl" readonly></p>
        <p>슬로건: <input type="text" id="modalCardSlogan" readonly></p>
        <p>주의사항: <textarea id="modalCardNotice" readonly></textarea></p>

        <div style="margin-top:10px;">
            <button type="button" onclick="approve()">등록</button>
            <button type="button" onclick="showReject()">보류/불허</button>
            <button type="button" onclick="closeModal()">닫기</button>
        </div>
    </form>

    <div id="rejectSection" style="margin-top:10px; display:none;">
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
// 리스트 조회
function loadPermissions() {
    fetch('/superadmin/permission/list')
        .then(res => res.json())
        .then(data => {
        	 console.log("DEBUG DATA", data);
            const tbody = document.getElementById('permissionTable');
            tbody.innerHTML = '';
            data.forEach(row => {
            	  console.log("ROW", row); // 👈 여기
                const regDate = row.regDate ? row.regDate.substring(0,10) : '';
                const perDate = row.perDate ? row.perDate.substring(0,10) : '';
                const reason = row.reason || '';
                const sAdmin = row.sadmin || '';
                const admin = row.admin || '';
                const perContent = row.perContent || '';

                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>\${row.perNo}</td>
                    <td>\${row.cardNo}</td>
                    <td>\${row.status}</td>
                    <td>\${reason}</td>
                    <td>\${admin}</td>
                    <td>\${sAdmin}</td>
                    <td>\${regDate}</td>
                    <td>\${perDate}</td>
                    <td>\${perContent}</td>
                    <td><button onclick="openModal(\${row.cardNo})">검토하기</button></td>
                `;
                tbody.appendChild(tr);
            });
        })
        .catch(err => {
            console.error('목록 로딩 오류:', err);
        });
}

// 모달 열기
function openModal(cardNo) {
    document.getElementById('rejectSection').style.display = 'none';
    fetch('/superadmin/permission/temp/' + cardNo)
        .then(res => res.json())
        .then(data => {
            document.getElementById('modalCardNo').value = data.cardNo;
            document.getElementById('modalCardName').value = data.cardName;
            document.getElementById('modalCardType').value = data.cardType;
            document.getElementById('modalCardBrand').value = data.cardBrand;
            document.getElementById('modalAnnualFee').value = data.annualFee;
            document.getElementById('modalIssuedTo').value = data.issuedTo;
            document.getElementById('modalService').value = data.service;
            document.getElementById('modalSService').value = data.sService;
            document.getElementById('modalCardStatus').value = data.cardStatus;
            document.getElementById('modalCardUrl').value = data.cardUrl || ''; // null 방지
            document.getElementById('modalCardSlogan').value = data.cardSlogan;
            document.getElementById('modalCardNotice').value = data.cardNotice;

            document.getElementById('modalOverlay').style.display = 'block';
            document.getElementById('editModal').style.display = 'block';
        });
}

// 모달 닫기
function closeModal() {
    document.getElementById('modalOverlay').style.display = 'none';
    document.getElementById('editModal').style.display = 'none';
}

// 등록 처리
function approve() {
    const payload = {
        cardNo: document.getElementById('modalCardNo').value,
        cardName: document.getElementById('modalCardName').value,
        cardType: document.getElementById('modalCardType').value,
        cardBrand: document.getElementById('modalCardBrand').value,
        annualFee: document.getElementById('modalAnnualFee').value,
        issuedTo: document.getElementById('modalIssuedTo').value,
        service: document.getElementById('modalService').value,
        sService: document.getElementById('modalSService').value,
        cardStatus: document.getElementById('modalCardStatus').value,
        cardUrl: document.getElementById('modalCardUrl').value,
        cardSlogan: document.getElementById('modalCardSlogan').value,
        cardNotice: document.getElementById('modalCardNotice').value
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
    })
    .catch(err => {
        console.error('등록 오류:', err);
        alert('등록에 실패했습니다.');
    });
}

// 보류/불허 폼 표시
function showReject() {
    document.getElementById('rejectSection').style.display = 'block';
}

// 보류/불허 처리
function submitReject() {
    const cardNo = document.getElementById('modalCardNo').value;
    const status = document.getElementById('rejectStatus').value;
    const reason = document.getElementById('rejectReason').value;

    if (!reason.trim()) {
        alert('사유를 입력하세요.');
        return;
    }

    const params = new URLSearchParams({
        cardNo: cardNo,
        status: status,
        reason: reason
    });

    fetch('/superadmin/permission/reject?' + params.toString(), {
        method: 'POST'
    })
    .then(res => res.json())
    .then(data => {
        alert(data.message);
        closeModal();
        loadPermissions();
    })
    .catch(err => {
        console.error('처리 오류:', err);
        alert('처리에 실패했습니다.');
    });
}

// 초기 로드
loadPermissions();
</script>
</body>
</html>
