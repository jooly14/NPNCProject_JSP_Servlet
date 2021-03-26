<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="stylesheet" href="css/board/blist.css"/>
<link rel="stylesheet" href="css/common/nav_category.css"/>
<link rel="stylesheet" href="css/common/header.css"/>
</head>
<body>
<div id="wrap">
	<%@ include file="/view/common/header.jsp" %>
	<section id="section1">
	<%@ include file="/view/common/nav_category.jsp" %>
		<div id="content">
			<h2 id="category-name"></h2>
			<div class="list-style">
				<span id="total">${totalcnt}개의 글</span>
				<!-- 한페이지당 페이지 노출 개수 -->
				<select id="psize">
					<option value="5" ${pagesize==5?'selected':''}>5개씩</option>
					<option value="10" ${pagesize==10?'selected':''}>10개씩</option>
					<option value="20" ${pagesize==20?'selected':''}>20개씩</option>
					<option value="30" ${pagesize==30?'selected':''}>30개씩</option>
					<option value="40" ${pagesize==40?'selected':''}>40개씩</option>
					<option value="50" ${pagesize==50?'selected':''}>50개씩</option>
				</select>
			</div>
			<!-- 게시글 테이블 -->
			<table class="list-table">
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
					<td style="text-align:center">${d.idx}</td>
					<td><a class="content-read" href="${d.idx}/${d.category}">${d.title} [${d.replyCnt}]</a></td>
					<td>${d.id}</td>
					<td style="text-align:center"><fmt:formatDate value="${d.regdate}" pattern="yyyy.MM.dd"/>   </td>
					<td style="text-align:center">${d.hit}</td>
					<td style="text-align:center">${d.good}</td>
				</tr>
			</c:forEach>
			</table>
			<c:if test="${sessionScope.id!=null&&!empty category}">
				<%
				for(int i=0;i<categoryList.size();i++){
					if(Integer.parseInt((String)(request.getAttribute("category")))==categoryList.get(i).getIdx()){
						if(categoryList.get(i).getWritegrade()>=(Integer)session.getAttribute("grade")){
				%>
				<input id="writebtn" class="btn" style="width:100px;margin-left:742px;" type="button" value="글쓰기" onclick="location.href = 'board?cmd=bwrite&category=${category}'">
				<%
						}
					} 
				}
				 %>
			</c:if>
			<!-- 페이징 -->
			<div class="paging">
				<c:if test="${start ne 1}">
					<a class="abn" href="board?cmd=blist&page=${start-1}&psize=${pagesize}&type=${type}&keyword=${keyword}&category=${category}"><i class="fas fa-angle-left"></i> 이전</a>
				</c:if>
				<c:forEach var="i" begin="${start}" end="${end<totalpage?end:totalpage}">
					<a style="${i eq page?'color:#03c75a;border:1px solid #e5e5e5;':'color:black'}" href="board?cmd=blist&page=${i}&psize=${pagesize}&type=${type}&keyword=${keyword}&category=${category}">${i}</a>
				</c:forEach>
					<c:if test="${end<totalpage}">
					<a class="abn" href="board?cmd=blist&page=${start+10}&psize=${pagesize}&type=${type}&keyword=${keyword}&category=${category}">다음 <i class="fas fa-angle-right"></i></a>
				</c:if>
			</div>
			<div class="search-form">
				<!-- 검색  -->
				<form action="board" method="post">
					<select name="type">
						<option value="title" ${empty type || type=='title'?'selected':''}>제목</option>
						<option value="content" ${type=='content'?'selected':''}>내용</option>
						<option value="id" ${type=='id'?'selected':''}>글작성자</option>
					</select>
					<input type="search" name="keyword" value="${keyword}" placeholder="검색어를 입력해주세요">
					<input type="hidden" name="category" value="${category}">
					<input type="hidden" name="cmd" value="blist">
					<input type="hidden" name="psize" value="${pagesize}">
					<input type="submit" value="검색">
				</form>
			</div>
		</div>
	</section>
	<%@ include file="/view/common/footer.jsp" %>
</div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	
	$(function(){
		/* 한페이지당 노출되는 게시글 개수 변경 */
		$("#psize").change(function(){
			var type = '${type}';
			var keyword = '${keyword}';
			var category = '${category}';
			console.log(type);
			var str ="board?cmd=blist&type="+type+"&keyword="+keyword+"&category="+category+"&psize="+$("#psize").val();
			location.href=str;
		});
		
		// 카테고리의 읽기 등급에 따라 읽을 수 있도록 처리
		$(".content-read").click(function(e){
			e.preventDefault();
			//board?cmd=bread&idx=
			var href = $(this).attr("href");
			var readidx = href.substring(0,href.indexOf("/"));
			var readcategory = href.substring(href.indexOf("/")+1);
			var tmpcategory;
			<%
				for(int i=0;i<categoryList.size();i++){
					%>
					tmpcategory = "<%=categoryList.get(i).getIdx() %>";
					if(tmpcategory == readcategory){
						readgrade = "<%=categoryList.get(i).getReadgrade() %>";
						console.log(readgrade);
					}
					<%
				}
			%>
			var usergrade= "${empty sessionScope.grade?99:sessionScope.grade}";
			if(usergrade<=readgrade){
				location.href = "board?cmd=bread&idx="+readidx;
			}else{
				var tmpgName;
				var tmpGrade;
				<%
				HashMap<Integer,String> grades =((HashMap<Integer,String>)request.getAttribute("grades"));
					for(Map.Entry e: grades.entrySet()){
						%>
						tmpGrade = "<%=e.getKey() %>";
						if(tmpGrade==readgrade){
							tmpgName = 	"<%=e.getValue() %>";	
						}
						<%
					}
				%>				
				alert(tmpgName+" 등급 이상부터 접근 가능합니다.");
			}
		});
		/*카테고리 이름 가져오기 */
		 var category_idx = $("#cidx-${category}").text();
		 if(category_idx==""){
			 $("#category-name").text("전체 글보기");
		 }else{
			 $("#category-name").text(category_idx);
		 }
	});
</script>
</body>
</html>