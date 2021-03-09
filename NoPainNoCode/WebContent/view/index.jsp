<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
  />
<link rel="stylesheet" href="css/common/nav_category.css"/>
<title>Insert title here</title>
<style>
	*{
		margin:0;
		padding:0;
		box-sizing:border-box;
	}
	
	#wrap{
		width:100%;
	}
	#section1{
		width:1080px;
		margin: 50px auto 0px;
		display: flex;
		align-self: start;
		justify-content: space-between;
	}
</style>



</head>

<body>
<div id="wrap">
	<%@ include file="/view/common/header.jsp" %>
	<section id="section1">
	<%@ include file="/view/common/nav_category.jsp" %>
	</section>
</div>
</body>
</html>