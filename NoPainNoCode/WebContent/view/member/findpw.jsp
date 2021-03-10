<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 페이지</title>
</head>
<body>
	<form action="../../member" method="post">
		아이디 <input type="text" name="id"><br>
		주민등록번호 <input type="text" name="idnum"><br>
		전화번호 <input type="text" name="phonenum"><br>
		<input type="hidden" name="cmd" value="findpw">
		<input type="submit" value="비빌번호 변경">
	</form>
</body>
</html>