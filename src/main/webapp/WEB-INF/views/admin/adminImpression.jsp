<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상품 인가 목록</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
<link rel="stylesheet" href="/css/adminstyle.css">
</head>
<body>
<jsp:include page="../fragments/header.jsp"></jsp:include>
<h2>상품 인가 목록</h2>

<table id="permissionTable">
    <thead>
    <tr>
        <th>번호</th>
        <th>카드 번호</th>
        <th>상태</th>
        <th>이유</th>
        <th>요청한 담당관리자</th>
        <th>결정한 상위 관리자</th>
        <th>요청 날짜</th>
        <th>인가 날짜</th>
        <th>인가 내용</th>
    </tr>
    </thead>
    <tbody>
    <!-- 데이터는 fetch로 채워짐 -->
    </tbody>
</table>

<div id="noDataMessage" style="display: none; margin-top: 10px;">상품 인가 목록이 없습니다.</div>

<div id="pagination" style="margin-top: 10px; display: none;">
    <button id="prevPage">이전</button>
    <span id="pageInfo"></span>
    <button id="nextPage">다음</button>
</div>

<script src="/js/adminHeader.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
    	const tbody = document.querySelector('#permissionTable tbody');
        const thead = document.querySelector('#permissionTable thead');
        const noDataMessage = document.getElementById('noDataMessage');
        const pagination = document.getElementById('pagination');
        const searchInput = document.getElementById('searchInput');
            
        fetch('/admin/permissions')
        	.then(response => response.json())
        	.then(data => {
            	console.log('전체 응답 데이터', data);
                allData = data;
                renderTable(allData);
            })
            .catch(error => {
            	console.error('데이터 로딩 실패:', error);
            });
            
        // 날짜 포맷팅 함수
        function formatDate(dateString) {
        	if (!dateString) return '';
            const date = new Date(dateString);
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hour = String(date.getHours()).padStart(2, '0');
            const minute = String(date.getMinutes()).padStart(2, '0');
            const second = String(date.getSeconds()).padStart(2, '0');
            return `\${year}-\${month}-\${day} \${hour}:\${minute}:\${second}`;
        }

        function renderTable(data){
        	tbody.innerHTML = '';
            	 
            // 데이터가 없으면 메시지 보여주고 테이블 숨김
            if (data.length === 0) {
            	thead.style.display = 'none';
                document.getElementById('permissionTable').style.display = 'none';
                noDataMessage.style.display = 'block';
                pagination.style.display = 'none';
                return;
            }
             	
            // 데이터가 있으면 테이블과 thead 보이게, 메시지 숨기기
            thead.style.display = '';
            document.getElementById('permissionTable').style.display = '';
            noDataMessage.style.display = 'none';

            // 테이블 행 모두 생성
            data.forEach(p => {
            	const tr = document.createElement('tr');
            	const regDate = formatDate(p.regDate);
                const perDate = formatDate(p.perDate);
            	
                tr.innerHTML = `
                	<td>\${p.perNo}</td>
                    <td>\${p.cardNo}</td>
                    <td>\${p.status}</td>
                    <td>\${p.reason}</td>
                    <td>\${p.admin}</td>
                    <td>\${p.sadmin}</td>
                    <td>\${regDate}</td>
                    <td>\${perDate}</td>
                    <td>\${p.perContent}</td>
                `;
                tbody.appendChild(tr);
        });
                
        setupPagination();
	}
            
    // 페이징 기능 구현
    const itemsPerPage = 10;
    let currentPage = 1;
            
    function setupPagination(){
            	
		const rows = tbody.querySelectorAll('tr');
	    const pageInfo = document.getElementById('pageInfo');
	    const prevBtn = document.getElementById('prevPage');
	    const nextBtn = document.getElementById('nextPage');
	
	    const totalPages = Math.ceil(rows.length / itemsPerPage);

	    if (rows.length <= itemsPerPage) {
	        pagination.style.display = 'none';
	        return;
	    }
	    
	 	pagination.style.display = 'block';
	 	
	 	// 페이지 번호 버튼 영역 초기화
	    pageInfo.innerHTML = '';
	 	
	 	// 현재 페이지 전역 변수
	    currentPage = 1;
	    
	    function renderPage(page) {
	    	const start = (page - 1) * itemsPerPage;
	        const end = start + itemsPerPage;
	                
	        rows.forEach((row, idx) => {
	        	row.style.display = (idx >= start && idx < end) ? '' : 'none';
	        });
	           
	        currentPage = page;

	        // 페이지 번호 버튼들 다시 생성
	        pageInfo.innerHTML = '';
	        
	        for (let i = 1; i <= totalPages; i++) {
	            const btn = document.createElement('button');
	            btn.textContent = i;
	            btn.style.margin = '0 3px';
	            if (i === currentPage) {
	                btn.disabled = true; // 현재 페이지는 비활성화
	                btn.style.fontWeight = 'bold';
	            }
	            btn.onclick = () => {
	                renderPage(i);
	            };
	            pageInfo.appendChild(btn);
	        }
	        
	     	// 이전/다음 버튼은 숨기거나 비활성화 처리 (필요시)
	        prevBtn.style.display = 'none';
	        nextBtn.style.display = 'none';
	    }
	    
	    renderPage(currentPage);
	}
});

</script>
</body>
</html>
