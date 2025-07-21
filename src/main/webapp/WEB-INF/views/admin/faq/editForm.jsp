<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>FAQ 수정</title>
    <link rel="stylesheet" href="/css/adminstyle.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
        }

        h2 {
            text-align: center;
            font-size: 1.8rem;
            color: #2c3e50;
            padding-top: 40px;
        }

        form {
            max-width: 600px;
            margin: 30px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.08);
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: bold;
            color: #34495e;
            margin-bottom: 6px;
        }

        input[type="text"],
        textarea {
            padding: 10px 14px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #fdfdfd;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.15);
        }

        textarea {
            min-height: 120px;
            resize: vertical;
            line-height: 1.5;
        }

        button[type="submit"] {
            background-color: #c22800;
            color: white;
            font-size: 1rem;
            padding: 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.1s ease;
        }

        button[type="submit"]:hover {
            background-color: #a31f00;
            text-decoration: underline;
            text-decoration-color: white;
            transform: translateY(-1px);
        }
        
        textarea {
    white-space: pre-wrap;  /* 줄바꿈 및 공백 유지 */
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 1rem;
    line-height: 1.5;
}
    </style>
</head>
<body>
    <jsp:include page="../../fragments/header.jsp"></jsp:include>

    <h2>FAQ 수정</h2>

    <form action="edit" method="post">
        <input type="hidden" name="faqNo" value="${faq.faqNo}">

        <div class="form-group">
            <label for="faqQuestion">질문</label>
            <input type="text" id="faqQuestion" name="faqQuestion" value="${faq.faqQuestion}">
        </div>

        <div class="form-group">
            <label for="faqAnswer">답변</label>
           <textarea id="faqAnswer" name="faqAnswer" oninput="autoResize(this)">${faq.faqAnswer}</textarea>
        </div>

        <div class="form-group">
            <label for="writer">작성자</label>
            <input type="text" id="writer" name="writer" value="${faq.writer}">
        </div>

        <div class="form-group">
            <label for="admin">관리자</label>
            <input type="text" id="admin" name="admin" value="${faq.admin}">
        </div>

        <div class="form-group">
            <label for="cattegory">카테고리</label>
            <div style="display: flex; gap: 20px;">
        <label>
            <input type="radio" name="cattegory" value="카드"
                   ${faq.cattegory == '카드' ? 'checked' : ''}> 카드
        </label>
        <label>
            <input type="radio" name="cattegory" value="예적금"
                   ${faq.cattegory == '예적금' ? 'checked' : ''}> 예적금
        </label>
    </div>
        </div>

        <button type="submit">수정</button>
    </form>

    <script src="/js/adminHeader.js"></script>
    <script>
    function autoResize(textarea) {
        textarea.style.height = "auto"; // 높이 초기화
        textarea.style.height = textarea.scrollHeight + "px"; // 내용만큼 높이 조절
    }
    
window.addEventListener("DOMContentLoaded", () => {
    const textarea = document.getElementById("faqAnswer");
    if (textarea) autoResize(textarea); // 초기값에도 적용
});
</script>
</body>
</html>