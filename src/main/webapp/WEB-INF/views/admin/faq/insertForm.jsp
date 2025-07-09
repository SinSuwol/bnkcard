<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>FAQ 등록</title>
</head>
<body>
    <h2>FAQ 등록</h2>
    <form action="/admin/faq/add" method="post">
        질문: <input type="text" name="faqQuestion"><br>
        답변: <textarea name="faqAnswer" rows="5" cols="50"></textarea><br>
        작성자: <input type="text" name="writer"><br>
        관리자: <input type="text" name="admin"><br>
        카테고리: <input type="text" name="cattegory"><br>
        <button type="submit">등록</button>
    </form>
</body>
</html>
