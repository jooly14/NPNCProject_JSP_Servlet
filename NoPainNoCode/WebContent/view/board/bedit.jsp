<%@page import="com.npnc.category.dto.CDto"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	/* 로그인 하지 않고 접근 시 제한 */
	if(session.getAttribute("id")==null){
		%>
	<script>
		alert("로그인 해주세요.");
		history.back();
	</script>
		<%
	}
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
  />
<link rel="stylesheet" href="css/board/blist.css"/>
<link rel="stylesheet" href="css/common/nav_category.css"/>
<link rel="stylesheet" href="css/board/bwrite.css"/>
<link rel="stylesheet" href="css/common/header.css"/>


</head>
<body>

<div id="wrap">
<%@ include file="/view/common/header.jsp" %>

<section id="section1">
<%@ include file="/view/common/nav_category.jsp" %>

<c:if test="${sessionScope.id != id}">
<script>
	alert("잘못된 접근입니다.");
	history.back();
</script>
</c:if>

<%
Map<String,Vector<CDto>> map2 = (Map<String,Vector<CDto>>)request.getAttribute("clist");	// 카테고리 목록 불러오기 
%>

<form action="view/board/file_upload.jsp" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<td>
			<select name="category">
			<%
			
			
			/*
			 서버에서 보낸 request.setAttribute 목록
			 - 카테고리 인덱스 : "categoryIdx"
			 - 글제목 : "title"
			 - 글번호 : "idx"
			 - 글내용 : "content"
			*/
			
				int categoryIdx = (int)request.getAttribute("categoryIdx");
			
			if(session.getAttribute("grade")!=null){
				boolean readGrade = false;
			
				for(Map.Entry<String,Vector<CDto>> e :map2.entrySet()){		// 카테고리 목록 불러오기 
					for(int i=0;i<e.getValue().size();i++){
						
						for(int j = 0 ; j < categoryList.size() ; j++){
							if(categoryList.get(j).getIdx()==e.getValue().get(i).getIdx()){
								if(((Integer)session.getAttribute("grade")) <= categoryList.get(j).getWritegrade()){
								/* 유저의 회원등급과 카테고리의 쓰기 권한을 비교해서 쓸 수 있는 카테고리만 보여줌 */
								
								
								
						/*
						게재되어있는 게시판을 유지하기 위해,
						서버에서 보낸 카테고리 idx값과
						클라이언트가 수정요청보낸 게시글의 카테고리idx가 동일하면,
						해당 option태그에 selected 속성 부여.
						*/
									if(e.getValue().get(i).getIdx() == categoryIdx){
			%>
				<option value="<%= e.getValue().get(i).getIdx() %>" selected>	<!-- 카테고리 고르면 idx 넘겨줌  -->
					<%=e.getKey()+" "+e.getValue().get(i).getName() %>
				</option>
			<%			
			
						//selected속성 없이 그냥 출력.
									} else {
			%>
				<option value="<%= e.getValue().get(i).getIdx() %>">	<!-- 카테고리 고르면 idx 넘겨줌  -->
					<%=e.getKey()+" "+e.getValue().get(i).getName() %>
				</option>
			<%
									}
								}
							}
						}
					}
				}
				
				
				/* 쓰기권한이 하나도 없는 경우 뒤로가기*/
				//if(!readGrade){
					%>
					<!--  
					<script>
						alert("쓰기 권한이 없습니다.");
						history.back();
					</script>
					 -->
					<%
					//}
			}
				
				
			%>
			</select>
		</td>
	</tr>
	
	
	<tr>
		<td><input type="text" name="title" id="title" value="${title}"></td>
	</tr>
	<tr>
		<td>
			<textarea rows="40" cols="60" name="content" style="resize: none;">${content}</textarea>
		</td>
	</tr>
	
	
	<tr>
		<td>
			<input type="file" name="file">
		</td>
	</tr>
	<tr>
		<td>
			<input type="hidden" name="idx" value="<%= request.getParameter("idx")%>">
			<input type="hidden" name="isWrite" value="0">
			<input type="hidden" name="cmd" value="<%= session.getAttribute("id") %>">
		</td>
	</tr>
	<tr>
		<td><input type="submit" value="확인"></td>
	</tr>
</table>
	
</form>

</section>
</div>


</body>
</html>