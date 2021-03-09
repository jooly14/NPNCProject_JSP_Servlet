<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
	<%
		if(session.getAttribute("id")==null){
	%>
	<input type="button" value="로그인" onclick="location.href='view/member/login.jsp'">
	<input type="button" value="회원가입" onclick="location.href='view/member/leg.jsp'">
	<%
		}else{
	%>
	<span>${sessionScope.id}님 </span>
	<input type="button" value="로그아웃" onclick="location.href='member?cmd=logout'">	
	<%
		}
	%>
</header>