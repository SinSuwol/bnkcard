<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Admin CardList 페이지</h1>
<hr>
<script>
        fetch('/api/products')
            .then(res => res.json())
            .then(products => {
                const list = document.getElementById('product-list');
                products.forEach(p => {
                    const li = document.createElement('li');
                    li.textContent = `${p.name} - ${p.price}원`;
                    list.appendChild(li);
                });
            });
    </script>
</body>
</html>