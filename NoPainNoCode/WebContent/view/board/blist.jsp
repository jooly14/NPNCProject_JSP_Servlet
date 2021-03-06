<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<%@ include file="/view/common/nav_category.jsp" %>
<%
	int curpage = (Integer)request.getAttribute("page");
	int start = (curpage/10)*10+1;
	if(curpage%10==0){
		start = (curpage/10-1)*10+1;
	}
	int totalpage = (Integer)request.getAttribute("totalpage");
%>
<c:set var="start" value="<%=start%>" />
<c:set var="curpage" value="<%=curpage%>" />
<c:set var="totalpage" value="<%=totalpage%>" />
<div>
<!-- 한페이지당 페이지 노출 개수 -->
<select id="psize">
	<option value="5" ${pagesize==5?'selected':''}>5개씩</option>
	<option value="10" ${pagesize==10?'selected':''}>10개씩</option>
	<option value="20" ${pagesize==20?'selected':''}>20개씩</option>
	<option value="30" ${pagesize==30?'selected':''}>30개씩</option>
	<option value="40" ${pagesize==40?'selected':''}>40개씩</option>
	<option value="50" ${pagesize==50?'selected':''}>50개씩</option>
</select>
<!-- 게시글 테이블 -->
<table>
	<tr>
		<td>글 번호</td>
		<td>제목</td>
		<td>작성자</td>
		<td>작성일</td>
		<td>조회</td>
		<td>좋아요</td>
	</tr>
<c:forEach var="d" items="${dtos}">
	<tr>
		<td>${d.idx}</td>
		<td><a href="board?cmd=bread&idx=${d.idx}">${d.title} [${d.replyCnt}]</a></td>
		<td>${d.id}</td>
		<td>${d.regdate}</td>
		<td>${d.hit}</td>
		<td>${d.good}</td>
	</tr>
</c:forEach>
</table>


<!-- 페이징 -->
<div>
	<c:if test="${start ne 1}">
		<a href="board?cmd=blist&page=${start-1}&psize=${pagesize}&type=${type}&keyword=${keyword}&category=${category}">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${start}" end="${start+9<totalpage?start+9:totalpage}">
		<a style="color:${i eq curpage?'orange':'black'}" href="board?cmd=blist&page=${i}&psize=${pagesize}&type=${type}&keyword=${keyword}&category=${category}">${i}</a>
	</c:forEach>
		<c:if test="${start+9<totalpage}">
		<a href="board?cmd=blist&page=${start+10}&psize=${pagesize}&type=${type}&keyword=${keyword}&category=${category}">[다음]</a>
	</c:if>
</div>

<!-- 검색  -->
<form action="board" method="post">
	<select name="type">
		<option value="title" ${empty type || type=='title'?'selected':''}>제목</option>
		<option value="content" ${type=='content'?'selected':''}>내용</option>
		<option value="id" ${type=='id'?'selected':''}>글작성자</option>
	</select>
	<input type="search" name="keyword" value="${keyword}">
	<input type="hidden" name="category" value="${idx}">
	<input type="hidden" name="cmd" value="blist">
	<input type="hidden" name="psize" value="${pagesize}">
	<input type="submit" value="검색">
</form>
</div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		$("#psize").change(function(){
			var type = '${type}';
			var keyword = '${keyword}';
			var category = '${category}';
			console.log(type);
			var str ="board?cmd=blist&type="+type+"&keyword="+keyword+"&category="+category+"&psize="+$("#psize").val();
			location.href=str;
		});
	});
</script>
</body>
</html>