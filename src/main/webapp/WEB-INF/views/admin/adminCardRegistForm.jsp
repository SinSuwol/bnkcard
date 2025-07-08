<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>상품 등록</h1>
    <form id="cardForm" onsubmit="return false;">
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

    <script>
        $("#cardForm").on("submit", function(e) {
            // 1) 폼 데이터 수집
            const data = {
                cardName: $("input[name='cardName']").val(),
                cardType: $("input[name='cardType']").val(),
                cardBrand: $("input[name='cardBrand']").val(),
                annualFee: parseInt($("input[name='annualFee']").val() || "0", 10),
                issuedTo: $("input[name='issuedTo']").val(),
                service: $("input[name='service']").val(),
                sService: $("input[name='sService']").val(),
                cardStatus: $("input[name='cardStatus']").val(),
                cardUrl: $("input[name='cardUrl']").val(),
                cardIssueDate: $("input[name='cardIssueDate']").val(),
                cardDueDate: $("input[name='cardDueDate']").val(),
                cardSlogan: $("input[name='cardSlogan']").val(),
                cardNotice: $("input[name='cardNotice']").val()
            };

            // 2) AJAX 전송
            $.ajax({
                url: "/cardRegist",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(data),
                success: function(response) {
                    alert(response.message);
                    console.log(response);
                    // 등록 성공 시 다음 페이지로 이동
                    if (response.success) {
                    	window.location.href = "/admin/CardList";
                    }
                },
                
                error: function(xhr) {
                    alert("오류가 발생했습니다: " + xhr.responseText);
                    console.error(xhr);
                }
            });
        });
    </script>
</body>
</html>
