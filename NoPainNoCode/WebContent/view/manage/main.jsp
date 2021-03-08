<%@page import="com.npnc.board.dto.BDto"%>
<%@page import="com.npnc.category.dto.CDto"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/common/nav_category.css"/>
<link rel="stylesheet" href="css/board/blist.css"/>
<style>
	
</style>
</head>
<body>
<div id="wrap">
	<section id="section1">
		<%@ include file="/view/common/manage_category.jsp" %>
		<div id="content">
			<h2 id="category-name">글 관리</h2>
			<div class="list-style">
				<span id="total">${totalcnt}개의 글</span>
				<!-- 한페이지당 페이지 노출 개수 -->
				<select id="sel-category">
				<option value="null-category">전체 글보기</option>
				<%
					Map<String,Vector<CDto>> map = (Map<String,Vector<CDto>>)request.getAttribute("clist");
					for(Map.Entry<String,Vector<CDto>> e :map.entrySet()){
				%>
				<optgroup label="<%=e.getKey()%>"></optgroup>
				<%
						for(int i=0;i<e.getValue().size();i++){
							%>
							<option value="<%=e.getValue().get(i).getIdx()%>"><%= e.getValue().get(i).getName()%></option>
							<%
						}
					}	
				%> 
				</select>
				
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
			<form id="fm1" action="manage?cmd=onepassdel" method="post">
			<table class="list-table">
				<tr>
					<td>글 번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회</td>
					<td>좋아요</td>
					<td>삭제 <input id="allchk" type="checkbox"></td>
					<td>카테고리</td>
				</tr>
			<c:forEach var="d" items="${dtos}">
				<tr>
					<td style="text-align:center">${d.idx}</td>
					<td><a href="manage?cmd=bread&idx=${d.idx}">${d.title} [${d.replyCnt}]</a></td>
					<td>${d.id}</td>
					<td style="text-align:center"><fmt:formatDate value="${d.regdate}" pattern="yyyy.MM.dd"/>   </td>
					<td style="text-align:center">${d.hit}</td>
					<td style="text-align:center">${d.good}</td>
					<td style="text-align:center"><input type="checkbox" name="del_idx" value="${d.idx}"></td>
					<td style="text-align:center"><input type="button" class="movebtn" id="btn-${d.idx}"value="이동"><span style="display:none">${d.category}</span></td>
				</tr>
			</c:forEach>
			</table>
			<div>
				<input id="fm1_submit" type="button" value="일괄 삭제">
			</div>
			</form>
			
			<!-- 페이징 -->
			<div class="paging">
				<c:if test="${start ne 1}">
					<a class="abn" href="manage?cmd=blist&page=${start-1}&psize=${pagesize}&type=${type}&keyword=${keyword}&category=${category}"><i class="fas fa-angle-left"></i> 이전</a>
				</c:if>
				<c:forEach var="i" begin="${start}" end="${end<totalpage?end:totalpage}">
					<a style="${i eq page?'color:#03c75a;border:1px solid #e5e5e5;':'color:black'}" href="manage?cmd=blist&page=${i}&psize=${pagesize}&type=${type}&keyword=${keyword}&category=${category}">${i}</a>
				</c:forEach>
					<c:if test="${end<totalpage}">
					<a class="abn" href="manage?cmd=blist&page=${start+10}&psize=${pagesize}&type=${type}&keyword=${keyword}&category=${category}">다음 <i class="fas fa-angle-right"></i></a>
				</c:if>
			</div>
			<div class="search-form">
				<!-- 검색  -->
				<form action="manage" method="post">
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
		<div style="display:none;" id="hidden">
			<span id="hidx"></span>
			<span id="htitle"></span>
			<span id="hid"></span>
			<span id="hregdate"></span>
			<span id="hcategory"></span>
		</div>
	</section>
	</div>
	<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	$(function(){
		$("#psize").change(function(){
			var category = '${category}';
			var type = '${type}';
			var keyword = '${keyword}';
			console.log(type);
			var str ="manage?cmd=blist&type="+type+"&keyword="+keyword+"&category="+category+"&psize="+$("#psize").val();
			location.href=str;
		});
		$("#sel-category").change(function(){
			var category = $(this).val();
			
			var type = '${type}';
			var keyword = '${keyword}';
				var str ="manage?cmd=blist&type="+type+"&keyword="+keyword+"&psize="+$("#psize").val()
			if(category!="null-category"){
				str += "&category="+category;
			}
			location.href=str;
		});
		$("#fm1_submit").click(function(){
			if($("input[name='del_idx']:checked").length!=0){
				if(confirm("정말 일괄 삭제를 진행하시겠습니까?")){
					$("#fm1").submit();
				}
			}
		});
		$("#allchk").change(function(){
			if($("#allchk").is(":checked")){
				$("input[name='del_idx']").prop("checked",true);
			}else{
				$("input[name='del_idx']").prop("checked",false);
			}
		});
		$(".movebtn").click(function(){
			var move_idx =  $(this).attr("id").substring(4);
			$("#hidx").text($(this).parent().prev().prev().prev().prev().prev().prev().prev().text());
			$("#htitle").text($(this).parent().prev().prev().prev().prev().prev().prev().text());
			$("#hid").text($(this).parent().prev().prev().prev().prev().prev().text());
			$("#hregdate").text($(this).parent().prev().prev().prev().prev().text());
			$("#hcategory").text($(this).next().text());
		   	var popup = window.open('view/manage/move_category_pop.jsp', '카테고리 이동', 'top=500px,left=500px,width=350px,height=200px,scrollbars=yes');
		});
		
		/*카테고리 이름 가져오기 */
		 var category_idx = $("option[value='${category}']").text();
		 if(category_idx==""){
			 $("option[value='null-category']").attr("selected",true);
		 }else{
			 $("option[value='${category}']").attr("selected",true);
		 }
		 
	});
	</script>
	
</body>
</html>