<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
	<form action="../../member" method="post">
		아이디 <input type="text" name="id"><br>
		비밀번호 <input type="text" name="pw"><br>
		이름 <input type="text" name="name"><br>
		주민등록번호 <input type="text" name="idnum"><br>
		이메일 <input type="text" name="email"><br>
		주소 <input type="text" name="address"><br>
		전화번호 <input type="text" name="phonenum"><br>
		<input type="hidden" name="cmd" value="leg">
		<input type="submit" value="회원가입">
	</form>
</body>
</html>