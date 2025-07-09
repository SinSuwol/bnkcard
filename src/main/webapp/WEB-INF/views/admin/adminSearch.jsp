<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>검색어 관리 대시보드</title>
</head>
<body>
	<h1>검색어 관리 대시보드</h1>

	<h2>추천어 목록</h2>
	<table id="recommended-table">
		<thead>
			<tr>
				<th>No</th>
				<th>키워드</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<h2>금칙어 목록</h2>
	<table id="prohibited-table">
		<thead>
			<tr>
				<th>No</th>
				<th>키워드</th>
				<th>등록일</th>
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
      `;
      tbody.appendChild(tr);
    });
  });




//금칙어
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

  </script>
</body>
</html>
