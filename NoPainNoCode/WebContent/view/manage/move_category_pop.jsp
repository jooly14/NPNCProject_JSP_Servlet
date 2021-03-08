<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<h3>카테고리 이동</h3>	
	<form action="<%=request.getContextPath()%>/manage?cmd=movecategory" method="post">
	<table>
		<tr>
			<td>글번호</td>
			<td id="idx"></td>
		</tr>
		<tr>
			<td>제목</td>
			<td id="title"></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td id="id"></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td id="regdate"></td>
		</tr>
		<tr>
			<td>카테고리</td>
			<td><select id="sel-category" name="category"></select></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="변경"></td>
		</tr>
	</table>
	<input type="hidden" name="idx">
	</form>
	<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		document.getElementById("idx").innerText= opener.document.getElementById("hidx").innerText;
		var htitle = opener.document.getElementById("htitle").innerText;
		var idx = htitle.lastIndexOf("[");
		htitle = htitle.substring(0,idx);
		htitle = htitle.replace("\n","");
		document.getElementById("title").innerText= htitle;
		document.getElementById("id").innerText = opener.document.getElementById("hid").innerText;
		document.getElementById("regdate").innerText= opener.document.getElementById("hregdate").innerText;
		var hcategory = opener.document.getElementById("hcategory").innerText;
		document.getElementById("sel-category").innerHTML = opener.document.getElementById("sel-category").innerHTML;
		$(function(){
			var idx2;
			 for(var i=0;i<$("#sel-category option").length;i++){
				 if($("#sel-category option")[i].value==hcategory){
					 idx2 =i;
				 }
			}
			 $("#sel-category").children("option").eq(idx2).attr("selected",true);
			 $("input[type='hidden']").val($("#idx").text());
		});
	</script>
</body>
</html>