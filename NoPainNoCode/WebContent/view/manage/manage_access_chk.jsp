<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 if(session.getAttribute("grade")==null||((Integer)session.getAttribute("grade"))!=0){
	%>
	<script>
		alert("잘못된 접근입니다");
		history.back();
	</script>
	<%
} 
%>