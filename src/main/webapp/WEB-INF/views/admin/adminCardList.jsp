<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    #card-list {
        display: grid;
        grid-template-columns: repeat(4, 1fr); /* 4칸 */
        gap: 16px;
        list-style: none;
        padding: 0;
    }

    .card {
        border: 1px solid #ccc;
        padding: 12px;
        background: #f9f9f9;
        border-radius: 8px;
        text-align: center;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }
    .card img {
	    width: 100%;       /* 카드 너비에 맞춰 꽉 차게 */
	    max-width: 150px;  /* 최대 가로 크기 제한 */
	    height: auto;      /* 비율 유지 */
	    margin-bottom: 12px; /* 제목과 간격 */
	    border-radius: 6px;  /* 둥근 모서리 */
	    object-fit: contain; /* 이미지 왜곡 없이 적절히 맞춤 */
	}
</style>
<link rel="stylesheet" href="/css/style.css">
</head>
<body>

<div class="inner">
	<h1>Admin CardList 페이지</h1>
	<hr>
	<ul id="card-list"></ul>
</div>



<script>
    fetch('/admin/card/getCardList') // ← 실제 REST API 경로
        .then(res => res.json())
        .then(cards => {
            const list = document.getElementById('card-list');
            cards.forEach(card => {
                console.log(card);
                const li = document.createElement('li');
                li.className = 'card';
                li.innerHTML = `
                	<img src=\${card.cardUrl}>
                    <h3>\${card.cardName}</h3>
                    <p>연회비: \${card.annualFee}원</p>
                    <p>브랜드: \${card.cardBrand}</p>
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