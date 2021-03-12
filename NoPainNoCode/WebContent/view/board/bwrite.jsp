<%@page import="com.npnc.category.dto.CDto"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	/* 로그인 하지 않고 접근 시 제한 */
	if(session.getAttribute("id")==null){
		%>
	<script>
		alert("잘못된 접근입니다");
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
<title>글쓰기</title>
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


<%
Map<String,Vector<CDto>> map2 = (Map<String,Vector<CDto>>)request.getAttribute("clist");	// 카테고리 목록 불러오기 
%>

<form action="view/board/file_upload.jsp" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<td>
			<select name="category">
			
			<%
				if(session.getAttribute("grade")!=null){
				boolean readGrade = false;
				
				
				for(Map.Entry<String,Vector<CDto>> e :map2.entrySet()){		// 카테고리 목록 불러오기 
					for(int i=0;i<e.getValue().size();i++){
						
						for(int j = 0 ; j < categoryList.size() ; j++){
							if(categoryList.get(j).getIdx()==e.getValue().get(i).getIdx()){
								if(((Integer)session.getAttribute("grade")) <= categoryList.get(j).getWritegrade()){
									/* 유저의 회원등급과 카테고리의 쓰기 권한을 비교해서 쓸 수 있는 카테고리만 보여줌 */
			%>
				<option value="<%= e.getValue().get(i).getIdx() %>">	<!-- 카테고리 고르면 idx 넘겨줌  -->
					<%=e.getKey()+" "+e.getValue().get(i).getName() %>
				</option>
			<%
									readGrade = true;
								}	
							}
						}
					} 
				}
				/* 쓰기권한이 하나도 없는 경우 뒤로가기 */
				if(!readGrade){
					%>
					<script>
						alert("잘못된 접근입니다");
						history.back();
					</script>
					<%
					}
				}
			%>
			</select>
		</td>
	</tr>
	<tr>
		<td><input type="text" name="title" id="title" placeholder="제목을 입력해주세요."></td>
	</tr>
	<tr>
		<td>
			<textarea rows="40" cols="60" name="content" style="resize: none;"> 
				
※ 게시글 양식 삭제/임의 변경 불가! (위반 시 제재)

※ 반드시 '직거래'를 희망하는 매물만 등록 가능!

※ 부동산 업체 매물 등록 불가! (위반 시 제재)

​

▶ 빠른 공실 해결을 위해 부동산의 도움을 받길 희망하시나요? (Y / N) :

▶ 피터팬 APP, WEB에도 함께 노출하시겠습니까? (Y / N) :

​▶ 주소 :

▶ 건물형태 :

▶ 거래 유형 :

▶ 가격 :

▶ 방개수 :

▶ 옵션정보 :

▶ 관리비 :

▶ 관리비 포함내역 :

▶ 층수 :

▶ 면적 :

▶ 난방 방식 :

▶ 주차 가능 :

▶ 이사가능일 :

▶ 문의 연락처 :

​

▶ 상세 설명 :

​▶ 매물 사진 :

※ 게시글 양식 삭제/임의 변경 불가! (위반 시 제재)

※ 반드시 '직거래'를 희망하는 매물만 등록 가능!

※ 부동산 업체 매물 등록 불가! (위반 시 제재)

​

▶ 빠른 공실 해결을 위해 부동산의 도움을 받길 희망하시나요? (Y / N) :

▶ 피터팬 APP, WEB에도 함께 노출하시겠습니까? (Y / N) :

​▶ 주소 :

▶ 건물형태 :

▶ 거래 유형 :

▶ 가격 :

▶ 방개수 :

▶ 옵션정보 :

▶ 관리비 :

▶ 관리비 포함내역 :

▶ 층수 :

▶ 면적 :

▶ 난방 방식 :

▶ 주차 가능 :

▶ 이사가능일 :

▶ 문의 연락처 :

​

▶ 상세 설명 :

​▶ 매물 사진 :

﻿
			</textarea>
		</td>
	</tr>
	
	
	<tr>
		<td>
			<input type="file" name="file">
		</td>
	</tr>
	
	
	<tr>
		<td>
			<input type="hidden" name="isWrite" value="1">
			<input type="hidden" name="id" value="<%= session.getAttribute("id") %>">
		</td>
	</tr>
	<tr>
		<td><input type="submit" value="확인"></td>
	</tr>
</table>
	
	
</form>
</section>

</div>


<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
/* 특정 카테고리에서 게시글 쓰기를 선택한 경우 카테고리select의 값도 해당 카테고리가 선택되게 함*/
var category_idx = $("option[value='${category}']").text();
if(category_idx==""){
	 $("option").eq(0).attr("selected",true);
}else{
	 $("option[value='${category}']").attr("selected",true);
}
</script>
</body>
</html>