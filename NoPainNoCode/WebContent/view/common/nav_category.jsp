<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.npnc.category.dto.CDto"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 모든 페이지에 왼쪽에 붙을 카테고리 -->
<nav id="nav-category">
	<input class="btn" type="button" value="사이트 관리" onclick="managerPage()">
	<%
		Map<String,Vector<CDto>> map = (Map<String,Vector<CDto>>)request.getAttribute("clist");
		for(Map.Entry<String,Vector<CDto>> e :map.entrySet()){
			
			%>
			<h3><%=e.getKey()%></h3>
			<ul>
			<%
			for(int i=0;i<e.getValue().size();i++){
				%>
				<li><a id="cidx-<%=e.getValue().get(i).getIdx()%>" href="board?cmd=blist&category=<%= e.getValue().get(i).getIdx()%>"><i class="far fa-file-alt"></i><%= e.getValue().get(i).getName()%></a></li>
				<%
			}
			%></ul><%
		}	
	%>
</nav>
<script>
	function managerPage(){
		location.href = "manage?cmd=blist";
	}
</script>