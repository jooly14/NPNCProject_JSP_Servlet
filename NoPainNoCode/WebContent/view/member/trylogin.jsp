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
	<script>
		alert("정보가 틀렸습니다.");
		location.href="view/member/login.jsp";
	</script>
<%
	}else{
		session.setAttribute("id", request.getAttribute("id"));
		session.setAttribute("pw", request.getAttribute("pw"));
		session.setAttribute("grade", request.getAttribute("grade"));
%>
	<script>
		location.href="board";
	</script>
<%
	}
%>
</body>
</html>