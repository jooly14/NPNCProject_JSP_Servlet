<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if((int)request.getAttribute("result")>0){
%>
		회원가입을 축하합니다.
<%
	}else {
%>
		잘못된 정보입니다.
<%}%>
</body>
</html>