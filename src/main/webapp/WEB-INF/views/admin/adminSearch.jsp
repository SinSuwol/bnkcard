<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>검색어 관리 대시보드</title>
<link rel="stylesheet" href="/css/adminstyle.css">
<style>
/* ===== 전체 구조 ===== */


.container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 0 20px;
}

/* ===== 제목 ===== */
h1 {
  text-align: center;
  color: #2c3e50;
  margin-bottom: 40px;
}

h2 {
  margin-top: 48px;
  margin-bottom: 12px;
  color: #2c3e50;
  font-size: 20px;
  font-weight: 600;
}

/* ===== 링크 ===== */
a {
  display: inline-block;
  margin-bottom: 20px;
  color: #3498db;
  text-decoration: none;
  font-weight: 500;
}

/* ===== 버튼 ===== */
.button-group {
  margin-bottom: 12px;
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}


/* ===== 날짜 필터 ===== */
.date-filter {
  display: flex;
  align-items: center;
  gap: 10px;
  margin: 20px 0;
}

input[type="date"] {
  padding: 6px 10px;
  font-size: 14px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

/* ===== 테이블 ===== */
table {
  width: 100%;
  border-collapse: collapse;
  background-color: #fff;
  margin-bottom: 30px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
  border-radius: 6px;
  overflow: hidden;
}

th, td {
  padding: 12px;
  border: 1px solid #dee2e6;
  text-align: center;
  font-size: 14px;
}

thead {
  background-color: #f1f3f5;
}

tbody tr:hover {
  background-color: #f8f9fa;
}

/* ===== 페이지네이션 ===== */
#log-pagination {
  margin-top: 24px;
  display: flex;
  gap: 6px;
  flex-wrap: wrap;
}

#log-pagination button {
  background-color: #fff;
  border: 1px solid #ccc;
  color: #495057;
  padding: 6px 10px;
  border-radius: 4px;
  font-size: 13px;
  cursor: pointer;
}

#log-pagination button:hover {
  background-color: #e9ecef;
}

#log-pagination button[style*="bold"] {
  background-color: #3498db;
  color: white;
  border-color: #3498db;
}

</style>
</head>
<body>
<jsp:include page="../fragments/header.jsp"></jsp:include>
<div class="container">
  <h1>검색어 관리 대시보드</h1>

	<a href="/admin/Statistics">통계</a>
	<!-- 추천어 관리 -->
	<h2>추천어</h2>
	<button onclick="addRecommended()">[+] 추천어 등록</button>
	<table id="recommended-table">
		<thead>
			<tr>
				<th>No</th>
				<th>키워드</th>
				<th>등록일</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<!-- 금칙어 관리 -->
	<h2>금칙어</h2>
	<button onclick="addProhibited()">[+] 금칙어 등록</button>
	<table id="prohibited-table">
		<thead>
			<tr>
				<th>No</th>
				<th>키워드</th>
				<th>등록일</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<!-- 인기 검색어 -->
	<h2>인기 검색어 TOP10</h2>
	<table id="top-table">
		<thead>
			<tr>
				<th>키워드</th>
				<th>검색횟수</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<!-- 기간별 로그 조회 -->
	<h2>검색어 로그 조회</h2>
	<input type="date" id="fromDate"> ~
	<input type="date" id="toDate">
	<button onclick="loadLogs()">조회</button>

  <table id="logs-table">
    <thead>
      <tr>
        <th>No</th>
        <th>회원번호</th>
        <th>키워드</th>
        <th>추천어</th>
        <th>금칙어</th>
        <th>검색일자</th>
      </tr>
    </thead>
    <tbody></tbody>
  </table>
  
  
<div id="log-pagination" style="margin-top:10px;"></div>
  </div>
<script src="/js/adminHeader.js"></script>
<script>
/* 오늘 날짜 기본값 */
window.addEventListener('DOMContentLoaded', () => {
  const today = new Date().toISOString().substring(0, 10);
  document.getElementById('fromDate').value = today;
  document.getElementById('toDate').value = today;
});

/* 공통 fetch 함수 */
function fetchAndRender(url, tableSelector, rowTemplateFn) {
  fetch(url)
    .then(r => r.json())
    .then(data => {
      const tbody = document.querySelector(tableSelector + ' tbody');
      tbody.innerHTML = '';
      data.forEach(item => tbody.appendChild(rowTemplateFn(item)));
    });
}

/* 추천어 */
fetchAndRender('/admin/Search/recommended', '#recommended-table', item => {
  const tr = document.createElement('tr');
  tr.innerHTML = `
    <td>\${item.RECOMMENDED_NO}</td>
    <td>\${item.KEYWORD}</td>
    <td>\${item.REG_DATE ? item.REG_DATE.substring(0,10) : ''}</td>
    <td>
      <button onclick="editRecommended(\${item.RECOMMENDED_NO}, '\${item.KEYWORD}')">수정</button>
      <button onclick="deleteRecommended(\${item.RECOMMENDED_NO})">삭제</button>
    </td>
  `;
  return tr;
});

/* 금칙어 */
fetchAndRender('/admin/Search/prohibited', '#prohibited-table', item => {
  const tr = document.createElement('tr');
  tr.innerHTML = `
    <td>\${item.PROHIBITED_NO}</td>
    <td>\${item.KEYWORD}</td>
    <td>\${item.REG_DATE ? item.REG_DATE.substring(0,10) : ''}</td>
    <td>
      <button onclick="editProhibited(\${item.PROHIBITED_NO}, '\${item.KEYWORD}')">수정</button>
      <button onclick="deleteProhibited(\${item.PROHIBITED_NO})">삭제</button>
    </td>
  `;
  return tr;
});

/* 인기 검색어 */
fetchAndRender('/admin/Search/top', '#top-table', item => {
  const tr = document.createElement('tr');
  tr.innerHTML = `
    <td>\${item.KEYWORD}</td>
    <td>\${item.CNT}</td>
  `;
  return tr;
});

/* 로그 조회 */
function loadLogs(page = 1) {
  const from = document.getElementById('fromDate').value;
  const to = document.getElementById('toDate').value;

  let url = '/admin/Search/logs';
  const params = [];
  if(from) params.push('from=' + from);
  if(to) params.push('to=' + to);
  params.push('page=' + page);
  params.push('size=20'); // 페이지당 20건
  if(params.length) url += '?' + params.join('&');

  fetch(url)
    .then(res => res.json())
    .then(result => {
    	 console.log("🚀 서버 응답 확인", result);
      const tbody = document.querySelector('#logs-table tbody');
      tbody.innerHTML = '';
      result.data.forEach(item => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
          <td>\${item.SEARCH_LOG_NO}</td>
          <td>\${item.MEMBER_NO || '-'}</td>
          <td>\${item.KEYWORD}</td>
          <td>\${item.IS_RECOMMENDED}</td>
          <td>\${item.IS_PROHIBITED}</td>
          <td>\${item.SEARCH_DATE ? item.SEARCH_DATE.substring(0,10) : ''}</td>
        `;
        tbody.appendChild(tr);
      });

      // 페이지네이션 UI
      const pagination = document.getElementById('log-pagination');
pagination.innerHTML = '';
for(let i=1; i<=result.totalPages; i++) {
  const btn = document.createElement('button');
  btn.textContent = i;
  btn.onclick = () => loadLogs(i);
  if(i === result.page) {
    btn.style.fontWeight = 'bold';
  }
  pagination.appendChild(btn);
}
    });
}





/* 추천어/금칙어 CRUD */
function addRecommended() {
  const k = prompt("추천어 입력:"); if(!k) return;
  fetch('/admin/Search/recommended', {method:'POST', headers:{'Content-Type':'application/json'}, body:JSON.stringify({keyword:k})}).then(()=>location.reload());
}
function editRecommended(id, oldK) {
  const k = prompt("수정할 추천어:", oldK); if(!k) return;
  fetch('/admin/Search/recommended/'+id, {method:'PUT', headers:{'Content-Type':'application/json'}, body:JSON.stringify({keyword:k})}).then(()=>location.reload());
}
function deleteRecommended(id) {
  if(confirm("삭제하시겠습니까?"))
    fetch('/admin/Search/recommended/'+id, {method:'DELETE'}).then(()=>location.reload());
}
function addProhibited() {
  const k = prompt("금칙어 입력:"); if(!k) return;
  fetch('/admin/Search/prohibited', {method:'POST', headers:{'Content-Type':'application/json'}, body:JSON.stringify({keyword:k})}).then(()=>location.reload());
}
function editProhibited(id, oldK) {
  const k = prompt("수정할 금칙어:", oldK); if(!k) return;
  fetch('/admin/Search/prohibited/'+id, {method:'PUT', headers:{'Content-Type':'application/json'}, body:JSON.stringify({keyword:k})}).then(()=>location.reload());
}
function deleteProhibited(id) {
  if(confirm("삭제하시겠습니까?"))
    fetch('/admin/Search/prohibited/'+id, {method:'DELETE'}).then(()=>location.reload());
}
</script>
</body>
</html>
