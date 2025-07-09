<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>검색어 관리 대시보드</title>
<style>
  button {
    margin: 0 2px;
    padding: 4px 8px;
  }
</style>
</head>
<body>
  <h1>검색어 관리 대시보드</h1>

  <h2>추천어 목록</h2>
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

  <h2>금칙어 목록</h2>
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

  <h2>최근 검색어 (30건)</h2>
  <table id="recent-table">
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

  <script>
    // 추천어
    fetch('/admin/Search/recommended')
      .then(response => response.json())
      .then(data => {
        const tbody = document.querySelector('#recommended-table tbody');
        data.forEach(item => {
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
          tbody.appendChild(tr);
        });
      });

    // 금칙어
    fetch('/admin/Search/prohibited')
      .then(response => response.json())
      .then(data => {
        const tbody = document.querySelector('#prohibited-table tbody');
        data.forEach(item => {
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
          tbody.appendChild(tr);
        });
      });

    // 인기 검색어 TOP10
    fetch('/admin/Search/top')
      .then(response => response.json())
      .then(data => {
        const tbody = document.querySelector('#top-table tbody');
        data.forEach(item => {
          const tr = document.createElement('tr');
          tr.innerHTML = `
            <td>\${item.KEYWORD}</td>
            <td>\${item.CNT}</td>
          `;
          tbody.appendChild(tr);
        });
      });

    // 최근 검색어
    fetch('/admin/Search/recent')
      .then(response => response.json())
      .then(data => {
        const tbody = document.querySelector('#recent-table tbody');
        data.forEach(item => {
          const tr = document.createElement('tr');
          tr.innerHTML = `
            <td>\${item.SEARCH_LOG_NO}</td>
            <td>\${item.MEMBER_NO}</td>
            <td>\${item.KEYWORD}</td>
            <td>\${item.IS_RECOMMENDED}</td>
            <td>\${item.IS_PROHIBITED}</td>
            <td>\${item.SEARCH_DATE ? item.SEARCH_DATE.substring(0,10) : ''}</td>
          `;
          tbody.appendChild(tr);
        });
      });

    // 등록/수정/삭제 함수
    // 추천어 등록
    function addRecommended() {
      const keyword = prompt("추천어 입력:");
      if (keyword) {
        fetch('/admin/Search/recommended', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ keyword: keyword })
        }).then(() => location.reload());
      }
    }

    // 추천어 수정
    function editRecommended(id, oldKeyword) {
      const keyword = prompt("수정할 추천어:", oldKeyword);
      if (keyword) {
        fetch('/admin/Search/recommended/' + id, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ keyword: keyword })
        }).then(() => location.reload());
      }
    }

    // 추천어 삭제
    function deleteRecommended(id) {
      if (confirm("삭제하시겠습니까?")) {
        fetch('/admin/Search/recommended/' + id, {
          method: 'DELETE'
        }).then(() => location.reload());
      }
    }

    // 금칙어 등록
    function addProhibited() {
      const keyword = prompt("금칙어 입력:");
      if (keyword) {
        fetch('/admin/Search/prohibited', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ keyword: keyword })
        }).then(() => location.reload());
      }
    }

    // 금칙어 수정
    function editProhibited(id, oldKeyword) {
      const keyword = prompt("수정할 금칙어:", oldKeyword);
      if (keyword) {
        fetch('/admin/Search/prohibited/' + id, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ keyword: keyword })
        }).then(() => location.reload());
      }
    }

    // 금칙어 삭제
    function deleteProhibited(id) {
      if (confirm("삭제하시겠습니까?")) {
        fetch('/admin/Search/prohibited/' + id, {
          method: 'DELETE'
        }).then(() => location.reload());
      }
    }
  </script>
</body>
</html>
