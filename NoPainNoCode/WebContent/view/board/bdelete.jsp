<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

boolean result = (boolean)request.getAttribute("delete");
if(result){
%>
	<script>
		alert("삭제되었습니다.");
		location.href="board?cmd=blist";
	</script>
<%
}else{
%>
	<script>
		alert("삭제할 수 없습니다.");
		location.href="board?cmd=blist";
	</script>
<%
}
%>