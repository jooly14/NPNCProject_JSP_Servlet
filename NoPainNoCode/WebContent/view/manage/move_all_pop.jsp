<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/view/manage/manage_access_chk.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
	#wrap{
		width:320px;
		margin : 0 auto;		
	}
	table{
		border-top:1px solid black;
		width:100%;
		cell-collapse:collapse;
	}
	td:nth-child(1){
		text-align:center;
		border-right: 1px solid #f2f2f2;
	
	}
	td{
		padding: 7px 7px;
	}
	#sel-category{
	    width: 180px;
	    height: 30px;
	    border-radius: 0;
	    padding-left: 4px;
	    border: 1px solid lightgray;
	}
	#chgBtn{
		width: 80px;
	    height: 30px;
	    background-color: white;
	    border: 1px solid lightgray;
	    margin: 2px 0;
	}
</style>
<title>Insert title here</title>
</head>
<body>
<div id="wrap">
	<h3>카테고리 이동</h3>	
	<form id="fm1" action="<%=request.getContextPath()%>/manage?cmd=moveall" method="post">
	<table>
		<tr>
			<td>대분류</td>
			<td id="maincategory"></td>
		</tr>
		<tr>
			<td>카테고리</td>
			<td id="name"></td>
		</tr>
		<tr>
			<td>게시글 개수</td>
			<td id="cnt"></td>
		</tr>
		<tr>
			<td>카테고리</td>
			<td><select id="sel-category" name="category"></select></td>
		</tr>
		<tr>
			<td colspan="2"><input id="chgBtn" type="button" value="변경"></td>
		</tr>
	</table>
	<input type="hidden" name="idx">
	</form>
</div>
	<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		/* 부모창에서 값 가져오기 */
		var hidx = opener.document.getElementById("hidx").innerText;
		document.querySelector("input[name='idx']").value =hidx;
		document.getElementById("maincategory").innerText = opener.document.getElementById("hmaincategory").innerText;
		document.getElementById("name").innerText = opener.document.getElementById("hname").innerText;
		document.getElementById("cnt").innerText= opener.document.getElementById("hcnt").innerText;
		var otb = opener.document.querySelector(".list-table").innerHTML; 
		/* 여기서부터 jquery */
		$(function(){
			/* 부모창의 테이블을 이용해서 카테고리select 생성 */
			for(var i=1;i<$(otb).children().length-1;i++){
				var obj1;
				if($(otb).children().eq(i).children().length==2){
					obj1 = $("<optgroup></optgroup>");
					obj1.attr("label",$(otb).children().eq(i).children().eq(0).text());
				}else if($(otb).children().eq(i).children().eq(0).html().indexOf("</span>")>0){
					obj1 = $("<option></option>");
					obj1.text($(otb).children().eq(i).children().eq(1).text());
					obj1.val($(otb).children().eq(i).children().eq(5).children().eq(0).attr("id").substring(5));
				}
				$("#sel-category").append(obj1);
			}
			/* 원래 카테고리를 카테고리select에서 selected되게 함 */
			for(var i=0;i<$("#sel-category option").length;i++){
				 if($("#sel-category option")[i].value==hidx){
					 $("#sel-category").children("option").eq(i).attr("selected",true);
				 }
			}
			/* 변경 버튼을 눌렀을때 기존 카테고리와 다른 경우에만 작동 */
			$("#chgBtn").click(function(){
				if($("#sel-category option:selected").val()!=hidx){
					$("#fm1").submit();
				}
			});
		});
	</script>
</body>
</html>