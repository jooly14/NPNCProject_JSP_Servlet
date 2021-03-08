<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/common/nav_category.css"/>
<link rel="stylesheet" href="css/board/blist.css"/>
</head>
<body>
<div id="wrap">
	<section id="section1">
		<%@ include file="/view/common/manage_category.jsp" %>
		<div id="content">
			<h2 id="category-name">카테고리 관리</h2>
				<table id="sel-category" border="1">
				<%
					Map<String,Vector<CDto>> map = (Map<String,Vector<CDto>>)request.getAttribute("clist");
					for(Map.Entry<String,Vector<CDto>> e :map.entrySet()){
				%>
				<tr>
					<td><%=e.getKey()%></td>
				</tr>
				
				<%
						for(int i=0;i<e.getValue().size();i++){
							%>
							<tr>
								<td><%= e.getValue().get(i).getName()%></td>
							</tr>
							<%
						}
					}	
				%> 
				</table>
	</section>
</body>
</html>