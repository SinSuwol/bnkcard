<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>카드 리스트</title>
    <style>
        .grid { display:flex; flex-wrap:wrap; gap:20px; }
        .item { width:180px; text-align:center; }
        .item img { width:100%; height:auto; border:1px solid #ddd; }
    </style>
</head>
<body>

<h2>카드 목록</h2>
<div class="grid">
    <c:forEach var="c" items="${cardList}">
        <div class="item">
            <img src="${c.cardUrl}" alt="${c.cardName}"/>
            <h4>${c.cardName}</h4>
            <p style="font-size:12px;">${c.cardSlogan}</p>
        </div>
    </c:forEach>
</div>

</body>
</html>
