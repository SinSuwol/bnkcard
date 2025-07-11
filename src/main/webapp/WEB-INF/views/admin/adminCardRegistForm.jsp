<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<link rel="stylesheet" href="/css/adminstyle.css">
</head>
<body>
<jsp:include page="../fragments/header.jsp"></jsp:include>
    <h1>상품 등록</h1>
    <form id="cardForm">
        <p>
            카드명: <input type="text" name="cardName">
        </p>
        <p>
            카드 종류: <input type="text" name="cardType">
        </p>
        <p>
            카드 브랜드: <input type="text" name="cardBrand">
        </p>
        <p>
            연회비: <input type="number" name="annualFee">
        </p>
        <p>
            발급 대상: <input type="text" name="issuedTo">
        </p>
        <p>
            주요 서비스: <input type="text" name="service">
        </p>
        <p>
            부가 서비스: <input type="text" name="sService">
        </p>
        <p>
            상태: <input type="text" name="cardStatus">
        </p>
        <p>
            카드 URL: <input type="text" name="cardUrl">
        </p>
        <p>
            카드 발급일: <input type="date" name="cardIssueDate">
        </p>
        <p>
            카드 만료일: <input type="date" name="cardDueDate">
        </p>
        <p>
            카드 슬로건: <input type="text" name="cardSlogan">
        </p>
        <p>
            카드 공지사항: <input type="text" name="cardNotice">
        </p>
        <p>
            <button type="submit">등록하기</button>
        </p>
    </form>
	<script src="/js/adminHeader.js"></script>
    <script>
        document.getElementById("cardForm").addEventListener("submit", function(e) {
            e.preventDefault();

            const form = e.target;

            // 데이터 수집
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

            // fetch로 POST 전송
            fetch("/admin/cardRegist", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => { throw new Error(text); });
                }
                return response.json();
            })
            .then(result => {
                alert(result.message);
                console.log(result);
                if (result.success) {
                    window.location.href = "/admin/CardList";
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
