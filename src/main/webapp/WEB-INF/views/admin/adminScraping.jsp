<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 스크래핑</title>
<link rel="stylesheet" href="/css/adminstyle.css">
</head>
<body>
<jsp:include page="../fragments/header.jsp"></jsp:include>
	<div class="inner">
		<h1>관리자 스크래핑</h1>
		<hr>
		<button id="crawlBtn">신한카드 크롤링 실행</button>
		<button id="deleteBtn">신한카드 상품 전체삭제</button>
		<h1>타행 카드 상품</h1>
		<ul id="card-list"></ul>
	</div>
	
	
<script src="/js/adminHeader.js"></script>
<script>
//버튼눌러서 크롤링 시작
document.getElementById("crawlBtn").addEventListener("click", function() {
    fetch("/admin/card/scrap", {
        method: "POST"
    })
    .then(res => res.text())
    .then(msg => {
        alert(msg);
    })
    .catch(err => {
        alert("오류 발생: " + err);
    });
});
// 버튼눌러서 전체삭제
document.getElementById("deleteBtn").addEventListener("click", function() {
    if (!confirm("정말로 전체 삭제하시겠습니까?")) return;

    fetch("/admin/card/deleteAll", {
        method: "DELETE"
    })
    .then(res => res.text())
    .then(msg => {
        alert(msg);
        location.reload(); // 새로고침하여 리스트 반영
    })
    .catch(err => {
        alert("삭제 중 오류 발생: " + err);
    });
});


//초기화면 크롤링 카드리스트 출력
	fetch('/admin/card/getScrapList') // ← 실제 REST API 경로
        .then(res => res.json())
        .then(cards => {
            const list = document.getElementById('card-list');
            cards.forEach(card => {
                console.log(card);
                const li = document.createElement('li');
                li.className = 'card';
                li.innerHTML = `
                	<img src=\${card.scCardUrl}>
                    <h3 class="hi">\${card.scCardName}</h3>
                    <p>연회비: \${card.scAnnualFee}원</p>
                    <p>크롤링 날짜: \${card.scDate}</p>
                `;
                list.appendChild(li);
            });
        })
        .catch(err => {
            document.getElementById('card-list').innerText = '카드 정보를 불러오지 못했습니다.';
            console.error('에러:', err);
        });

</script>
</body>
</html>