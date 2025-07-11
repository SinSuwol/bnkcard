<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 등록 모달 예제</title>
<style>
/* 모달 오버레이 */
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

/* 모달 박스 */
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

/* 모달 내부 input 스타일 */
#editModal input {
    width: 100%;
    padding: 6px;
    margin-bottom: 10px;
    box-sizing: border-box;
}

/* 모달 내부 버튼 간격 */
#editModal button {
    margin-right: 5px;
}
</style>
</head>
<body>

<h1>카드 관리</h1>
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

<script>
// 모달 열기
function openModal() {
  document.getElementById('modalOverlay').style.display = 'block';
  document.getElementById('editModal').style.display = 'block';
}

// 모달 닫기
function closeModal() {
  document.getElementById('modalOverlay').style.display = 'none';
  document.getElementById('editModal').style.display = 'none';
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
