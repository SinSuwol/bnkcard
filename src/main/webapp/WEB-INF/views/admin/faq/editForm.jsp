<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>FAQ 수정</title>
</head>
<body>
    <h2>FAQ 수정</h2>
    <form action="edit" method="post">
        <input type="hidden" name="faqNo" value="${faq.faqNo}">
        질문: <input type="text" name="faqQuestion" value="${faq.faqQuestion}"><br>
        답변: <textarea name="faqAnswer" rows="5" cols="50">${faq.faqAnswer}</textarea><br>
        작성자: <input type="text" name="writer" value="${faq.writer}"><br>
        관리자: <input type="text" name="admin" value="${faq.admin}"><br>
        카테고리: <input type="text" name="cattegory" value="${faq.cattegory}"><br>
        <button type="submit">수정</button>
    </form>
</body>
</html>
