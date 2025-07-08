<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<h1>로그인 페이지</h1>
<hr>
<form action="/loginProc" method="post">
	<input type="text" name="username" placeholder="아이디를 입력하세요."><br>
	<input type="password" name="password" placeholder="비밀번호를 입력하세요."><br>
	<input type="submit" value="로그인">
</form>
</body>
</html>