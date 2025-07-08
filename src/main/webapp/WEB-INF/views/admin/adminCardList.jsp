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
</style>
</head>
<body>


<h1>Admin CardList 페이지</h1>
<hr>
<ul id="card-list"></ul>



<script>
    fetch('/admin/card/getCardList') // ← 실제 REST API 경로
        .then(res => res.json())
        .then(cards => {
            const list = document.getElementById('card-list');
            cards.forEach(card => {
                const li = document.createElement('li');
                li.className = 'card';
                li.innerHTML = `
                    <h3>${card.cardName}</h3>
                    <p>연회비: ${card.annualFee}원</p>
                    <p>브랜드: ${card.cardBrand}</p>
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