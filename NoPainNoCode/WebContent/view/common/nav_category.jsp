<%@page import="com.npnc.category.dto.CDto"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<%
		Map<String,Vector<CDto>> map = (Map<String,Vector<CDto>>)request.getAttribute("clist");
		for(Map.Entry<String,Vector<CDto>> e :map.entrySet()){
			
			%>
			<ul><%=e.getKey()%></ul>
			<%
			for(int i=0;i<e.getValue().size();i++){
				%>
				<li><a href="board?cmd=blist&category=<%= e.getValue().get(i).getIdx()%>"><%= e.getValue().get(i).getName()%></a></li>
				<%
			}
		}	
	%>
</div>