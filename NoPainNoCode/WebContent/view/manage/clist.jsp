<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/common/nav_category.css"/>
<link rel="stylesheet" href="css/board/blist.css"/>
<style>
	.list-style2{
		height: 20px;
	}
	.ajax-selw, .ajax-selr,select[name='readgrade'],select[name='writegrade']{
	    width: 80px;
	    height: 25px;
	    border-radius: 0;
	    padding-left: 4px;
	    border: 1px solid lightgray;
	}
	.main-del,.cate-del,.move-cate,.add-cate,.add-mainc,.addbtn,.addMbtn{
	    width: 50px;
	    height: 25px;
	    background-color: white;
	    border: 1px solid lightgray;
	    margin: 2px 0;
	}
	.add-cate,.add-mainc,.addbtn,.addMbtn{
		width:120px;
	}
	input[type="text"]{
		width:200px;
		height:25px;
	 	border: 1px solid gray;
	}
</style>
</head>
<body>
<div id="wrap">
	<section id="section1">
		<%@ include file="/view/common/manage_category.jsp" %>
		<div id="content">
			<h2 id="category-name">카테고리 관리</h2>
			<div class="list-style2"></div>
			<form id="fmc" action="manage" method="post">
				<table class="list-table">
					<tr>
						<td>대분류</td>
						<td>카테고리</td>
						<td>읽기권한</td>
						<td>쓰기권한</td>
						<td>게시글 개수</td>
						<td>삭제</td>
						<td>게시글 이동</td>
					</tr>
				<%
					Map<String,Vector<CDto>> map = (Map<String,Vector<CDto>>)request.getAttribute("clist");
					for(Map.Entry<String,Vector<CDto>> e :map.entrySet()){
				%>
				<tr>
					<td colspan="5"><%=e.getKey()%></td>
					<td style="text-align:center;"><input class="main-del" type="button" value="삭제"></td>
				</tr>
				
				<%
						HashMap<Integer,String> grades = (HashMap<Integer,String>)request.getAttribute("grades");
						for(int i=0;i<e.getValue().size();i++){
							%>
							<tr>
								<td style="width:150px;"><span style="display:none"><%=e.getKey()%></span></td>
								<td><%= e.getValue().get(i).getName()%></td>
								<td style="text-align:center;width:100px;">
								<select class="ajax-selr">
								<c:set var="readg" value="<%=e.getValue().get(i).getReadgrade()%>"></c:set>
								<c:forEach var="g" items="${requestScope.grades}">
									<option value="${g.key}" ${readg==g.key?'selected':''}>${g.value}</option>
								</c:forEach>
								</select>
								</td>
								<td style="text-align:center;width:100px;">
								<select class="ajax-selw">
								<c:set var="writeg" value="<%=e.getValue().get(i).getWritegrade()%>"></c:set>
								<c:forEach var="g" items="${requestScope.grades}">
									<option value="${g.key}" ${writeg==g.key?'selected':''}>${g.value}</option>
								</c:forEach>
								</select>
								</td>
								<td style="text-align:center;width:70px;"><%= ((HashMap<Integer,Integer>)request.getAttribute("cnt")).get(e.getValue().get(i).getIdx())%></td>
								<td style="text-align:center;width:70px;"><input id="cidx-<%=e.getValue().get(i).getIdx() %>" class="cate-del" type="button" value="삭제"></td>
								<td style="text-align:center;width:70px;"><c:if test='<%=(((HashMap<Integer,Integer>)request.getAttribute("cnt")).get(e.getValue().get(i).getIdx())!=0)%>'><input class="move-cate" type="button" value="이동"></c:if></td>
							</tr>
							<%
							if(i==e.getValue().size()-1){
								%>
								<tr>
									<td></td>
									<td><input class="add-cate" type="button" value="카테고리 추가"></td>
									<td colspan="5"></td>
								</tr>
								<%
							}
						}
					}	
				%> 
				<tr>
					<td><input class="add-mainc" type="button" value="대분류 추가"></td>
					<td colspan="6"></td>
				</tr>
				</table>
				</form>
		<div id="hidden" style="display:none">
			<span id="hidx"></span>
			<span id="hmaincategory"></span>
			<span id="hname"></span>
			<span id="hcnt"></span>
		</div>
		
	</section>
</div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		$(".cate-del").click(function(){
			if(confirm($(this).parent().prev().prev().prev().prev().text()+" 카테고리를 정말 삭제하시겠습니까?\n포함된 모든 게시글이 삭제됩니다.")){
				location.href = "manage?cmd=delc&idx="+$(this).attr("id").substring(5);			
			}
		});
		$(".main-del").click(function(){
			if(confirm($(this).parent().prev().text()+" 카테고리를 정말 삭제하시겠습니까?\n포함된 모든 카테고리 및 게시글이 삭제됩니다.")){
				location.href = "manage?cmd=delmainc&name="+encodeURI(encodeURIComponent($(this).parent().prev().text()));			
			}
		});
		$(".add-cate").click(function(){
			var tr1 = $("<tr></tr>");
			var td1 = $("<td></td>");
			var td2 = $("<td><input type='text' name='name'></td>");
			var td22 = $("<td style='text-align:center;width:100px;'><select name='readgrade'></select></td>");
			var td23 = $("<td style='text-align:center;width:100px;'><select name='writegrade'></select></td>");
			var td3 = $("<td colspan='2' style='text-align:center;'><input class='addbtn' type='button' value='카테고리 추가'></td>");
			var td4 = $("<td><input type='hidden' name='cmd' value='addcate'></td>");
			var h1 = $("<input type='hidden' name='maincategory'>");
			h1.val($(this).parent().parent().prev().children().eq(0).text());
			
			<c:forEach var="e" items="${grades}">
				var op1 = $("<option></option>");
				var value1 = '${e.value}';
				var key1 = '${e.key}';
				op1.text(value1);
				op1.val(key1);
				if(key1=='1'){
					op1.attr("selected",true);
				}
				td22.children().eq(0).append(op1);
				var op2 =  op1.clone();
				td23.children().eq(0).append(op2);
			</c:forEach>
			
			td1.append(h1);
			tr1.append(td1);
			tr1.append(td2);
			tr1.append(td22);
			tr1.append(td23);
			tr1.append(td3);
			tr1.append(td4);
			$(this).parent().parent().before(tr1);
			$(this).parent().parent().remove();
		});
		$(document).on("click",".addbtn",function(){
			if($(this).parent().prev().prev().prev().children().val()!=""){
				$("#fmc").submit();
			}
		});
		$(document).on("click",".addMbtn",function(){
			if($(this).parent().prev().prev().prev().prev().children().val()!=""&&$(this).parent().prev().prev().prev().children().val()!=""){
				$("#fmc").submit();
			}
		});
		$(".add-mainc").click(function(){
			console.log();
			var tr1 = $("<tr></tr>");
			var td1 = $("<td><input style='width:120px;' type='text' name='maincategory'></td>");
			var td2 = $("<td><input type='text' name='name'></td>");
			var td22 = $("<td style='text-align:center;'><select name='readgrade'></select></td>");
			var td23 = $("<td style='text-align:center;'><select name='writegrade'></select></td>");
			var td3 = $("<td colspan='2' style='text-align:center;'><input class='addMbtn' type='button' value='대분류 추가'></td>");
			var td4 = $("<td><input type='hidden' name='cmd' value='addcate'></td>");
			var h1 = $("<input type='hidden' name='maincategory'>");

			<c:forEach var="e" items="${grades}">
				var op1 = $("<option></option>");
				var value1 = '${e.value}';
				var key1 = '${e.key}';
				op1.text(value1);
				op1.val(key1);
				if(key1=='1'){
					op1.attr("selected",true);
				}
				td22.children().eq(0).append(op1);
				var op2 =  op1.clone();
				td23.children().eq(0).append(op2);
			</c:forEach>
			tr1.append(td1);
			tr1.append(td2);
			tr1.append(td22);
			tr1.append(td23);
			tr1.append(td3);
			tr1.append(td4);
			$(this).parent().parent().before(tr1);
			$(this).parent().parent().remove();
		});
		$(".move-cate").click(function(){
				$("#hidx").text($(this).parent().prev().children().eq(0).attr("id").substring(5));
				$("#hmaincategory").text($(this).parent().prev().prev().prev().prev().prev().prev().text());
				$("#hname").text($(this).parent().prev().prev().prev().prev().prev().text());
				$("#hcnt").text($(this).parent().prev().prev().text());
			   	var popup = window.open('view/manage/move_all_pop.jsp', '카테고리 이동', 'top=100px,left=500px,width=400px,height=290px,scrollbars=yes');
		});
		
		/*ajax -읽기권한*/
		$(".ajax-selr").on('change',ajaxFnc);
		function ajaxFnc() {
			var params = "cmd=mcategrade&idx=";
			if($(this).attr("class")=="ajax-selr"){
				params += $(this).parent().next().next().next().children().eq(0).attr("id").substring(5)+"&rw=r";
			}else{
				params += $(this).parent().next().next().children().eq(0).attr("id").substring(5)+"&rw=w";
			}
			params += "&grade="+$(this).val();
			$.ajax({
				type:"post",
				url:"<%=request.getContextPath()%>/ajax",
				data:params,
				dataType:"json",
				success:function(data){
				},
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				 }

			});
		}
		$(".ajax-selw").on('change',ajaxFnc);
	});
	
</script>
</body>
</html>