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
</head>

<body>
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

<script>
document.addEventListener('DOMContentLoaded', function() {
    fetch('/admin/permissions')
        .then(response => response.json())
        .then(data => {
        	   console.log('전체 응답 데이터', data);
               data.forEach(p => console.log('regDate:', p.regDate));
            const tbody = document.querySelector('#permissionTable tbody');
            data.forEach(p => {
                const tr = document.createElement('tr');

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
        })
        .catch(error => {
            console.error('데이터 로딩 실패:', error);
        });
});


</script>
</body>
</html>
