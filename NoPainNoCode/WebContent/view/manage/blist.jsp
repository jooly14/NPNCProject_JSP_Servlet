<%@page import="com.npnc.board.dto.BDto"%>
<%@page import="com.npnc.category.dto.CDto"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/view/manage/manage_access_chk.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/common/nav_category.css"/>
<link rel="stylesheet" href="css/board/blist.css"/>
<link rel="stylesheet" href="css/common/header.css"/>
<style>
	#sel-category{
		width:180px;
		height:30px;
		border-radius:0;
		padding-left:4px;
		border: 1px solid lightgray;
	}
	#total{
		width:580px;
	}
	.movebtn , #fm1_submit{
		width:50px;
		height:25px;
		background-color: white;
		border: 1px solid lightgray;
		margin: 2px 0;
	}
	#fm1_submit{
		width: 80px;
		height:35px; 
		position:absolute;
		right:11px;
		margin-top: 5px;
	}
	.relative-box{
		position: relative;
		height: 30px;
	}
</style>
</head>
<body>
<!-- 게시글 일괄삭제/카테고리 이동 가능한 관리자 페이지 -->
<div id="wrap">
	<%@ include file="/view/common/header.jsp" %>
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
					/* 카테고리로 select를 만들어줌  */
					Map<String,Vector<CDto>> map = (Map<String,Vector<CDto>>)request.getAttribute("clist");	//카테고리 리스트를 맵으로 가져옴
					//키 값에는 카테고리 중 대분류가 들어가 있고 그 안에 카테고리에 대한 데이터가 vector타입으로 들어가 있음
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
				<!-- 한페이지 당 보여지는 글 개수 -->
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
			<input type="hidden" name="type" value="${type}">
			<input type="hidden" name="keyword" value="${keyword}">
			<input type="hidden" name="psize" value="${psize}">
			<input type="hidden" name="category" value="${category}">
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
					<td style="text-align:center;width:80px;">${d.idx}</td>
					<td>${d.title} [${d.replyCnt}]</td><%-- <a href="manage?cmd=bread&idx=${d.idx}"></a> --%>
					<td style="text-align:center;width:80px;">${d.id}</td>
					<td style="text-align:center;width:80px;"><fmt:formatDate value="${d.regdate}" pattern="yyyy.MM.dd"/>   </td>
					<td style="text-align:center;width:50px;">${d.hit}</td>
					<td style="text-align:center;width:60px;">${d.good}</td>
					<td style="text-align:center;width:60px;"><input type="checkbox" name="del_idx" value="${d.idx}"></td>
					<td style="text-align:center;width:70px;"><input type="button" class="movebtn" id="btn-${d.idx}"value="이동"><span style="display:none">${d.category}</span></td>
				</tr>
			</c:forEach>
			</table>
			<div class="relative-box">
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
			<!-- 검색  -->
			<div class="search-form">
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
		<!-- 팝업창에서 데이터 찾기 쉬우라고 만들어 놓음 -->
		<div style="display:none;" id="hidden">
			<span id="hidx"></span>
			<span id="htitle"></span>
			<span id="hid"></span>
			<span id="hregdate"></span>
			<span id="hcategory"></span>
		</div>
	</section>
	<%@ include file="/view/common/footer.jsp" %>
</div>
	<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	$(function(){
		/* 한페이지 당 노출되는 게시글 수 변경 시 마다 새로 요청 */
		$("#psize").change(function(){
			var category = '${category}';
			var type = '${type}';
			var keyword = '${keyword}';
			console.log(type);
			var str ="manage?cmd=blist&type="+type+"&keyword="+keyword+"&category="+category+"&psize="+$("#psize").val();
			location.href=str;
		});
		/* select 카테고리 변경 시 해당 카테고리에 해당하는 글만 가져오게끔 요청 */
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
		/* 일괄 삭제를 클릭한 경우 선택된 값이 하나 이상이면 삭제진행 여부를 묻고 요청 진행*/
		$("#fm1_submit").click(function(){
			if($("input[name='del_idx']:checked").length!=0){
				if(confirm("정말 일괄 삭제를 진행하시겠습니까?")){
					$("#fm1").submit();
				}
			}
		});
		/* 삭제 전체 선택 체크박스를 선택하면 모든 체크박스가 선택되고 해제하면 모두 해제됨*/
		$("#allchk").change(function(){
			if($("#allchk").is(":checked")){
				$("input[name='del_idx']").prop("checked",true);
			}else{
				$("input[name='del_idx']").prop("checked",false);
			}
		});
		/* 게시글 이동 버튼을 누르면 새로운 팝업이 생김. 그 안에서 카테고리를 이동시키고 끝나면 화면 reload */
		$(".movebtn").click(function(){
			var move_idx =  $(this).attr("id").substring(4);
			$("#hidx").text($(this).parent().prev().prev().prev().prev().prev().prev().prev().text());
			$("#htitle").text($(this).parent().prev().prev().prev().prev().prev().prev().text());
			$("#hid").text($(this).parent().prev().prev().prev().prev().prev().text());
			$("#hregdate").text($(this).parent().prev().prev().prev().prev().text());
			$("#hcategory").text($(this).next().text());
		   	var popup = window.open('view/manage/move_category_pop.jsp', '카테고리 이동', 'top=100px,left=500px,width=600px,height=330px,scrollbars=yes');
		});
		
		/* 특정 카테고리 게시글을 보여주고 있다면 카테고리select의 값도 해당 카테고리가 선택되게 함*/
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