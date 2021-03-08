<%@page import="com.npnc.board.dao.BDao"%>
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
	BDao dao = new BDao();
	String category = request.getParameter("category");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	//out.print(category+title); //testcode
	// String file = request.getParameter("file");
	int result = dao.insert(category, title, content);
	if(result == 0){
		out.print("WRONG");
	}else{
		out.print("OK");
		//response.sendRedirect("bmain.jsp");
	
	} 
%>

</body>
</html>