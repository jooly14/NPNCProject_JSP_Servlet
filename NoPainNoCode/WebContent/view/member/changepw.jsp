<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경 페이지</title>
</head>
<body>
	<form action="member" method="post">
		새로운 비밀번호를 입력하세요<input type="text" name="pw"><br>
		<input type="hidden" name="id" value=${id}>
		<input type="hidden" name="cmd" value="changepw">
		<input type="submit" value="확인">
	</form>
</body>
</html>