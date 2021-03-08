<%@page import="com.npnc.category.dto.CDto"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<style>
	select{
		width: 500px;
	}
	#title{
		width: 495px;
	}
</style>
</head>
<body>
<%-- <%@ include file="/view/common/nav_category.jsp" %> --%>

<%
Map<String,Vector<CDto>> map2 = (Map<String,Vector<CDto>>)request.getAttribute("clist");	// 카테고리 목록 불러오기 
%>
<form action="board" method="post">
<table>
	<tr>
		<td>
			<select name="category">
			<%
				for(Map.Entry<String,Vector<CDto>> e :map2.entrySet()){		// 카테고리 목록 불러오기 
					for(int i=0;i<e.getValue().size();i++){
			%>
				<option value="<%= e.getValue().get(i).getIdx() %>">	<!-- 카테고리 고르면 idx 넘겨줌  -->
					<%=e.getKey()+" "+e.getValue().get(i).getName() %>
				</option>
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
			<textarea rows="40" cols="60" name="content"> 
				
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
			<!-- <input type="file" name="file"> -->
			첨부파일위치 
		</td>
	</tr>
	<tr>
		<td>
			<input type="hidden" name="cmd" value="bwriteproc">
		</td>
	</tr>
	<tr>
		<td><input type="submit" value="확인"></td>
	</tr>
</table>
	
	
</form>



</body>
</html>