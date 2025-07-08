<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>관리자 로그인 페이지</h1>
	<form action="/admin/login" method="post">
		<input type="text" name="username"><br>
		<input type="text" name="password"><br>
		<input type="submit" value="로그인">
	</form>
</body>
</html>