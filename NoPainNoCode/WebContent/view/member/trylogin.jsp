<%@page import="com.npnc.member.dto.MDto"%>
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
	if(request.getAttribute("id")==null){
%>
	로그인 실패!
<%
	}else{
		session.setAttribute("id", request.getAttribute("id"));
		session.setAttribute("pw", request.getAttribute("pw"));
%>
	<%=request.getAttribute("id") %>님 환영합니다.
<%
	}
%>

</body>
</html>