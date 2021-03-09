<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.npnc.category.dto.CDto"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="nav-category">
			<h2>관리자 페이지</h2>
			<ul id="manage-list">
				<li><a href="<%=request.getContextPath()%>/manage?cmd=blist">글 관리</a></li>
				<li><a href="<%=request.getContextPath()%>/manage?cmd=clist">카테고리 관리</a></li>
				<li><a href="<%=request.getContextPath()%>/manage?cmd=mlist">회원 관리</a></li>
				<%-- <li><a href="<%=request.getContextPath()%>/manage?cmd=rlist">댓글 관리</a></li> --%>
			</ul>
</div>
<script>
	function managerPage(){
		location.href = "manage?cmd=blist";
	}
</script>