<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.npnc.board.dto.RDto"%>
<%@page import="com.npnc.board.dao.BDao"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	
<link rel="stylesheet" href="css/board/blist.css"/>
<link rel="stylesheet" href="css/board/bread.css"/>
<link rel="stylesheet" href="css/common/nav_category.css"/>
<link rel="stylesheet" href="css/common/header.css"/>

</head>
<body>

<div id="wrap">
<%@ include file="/view/common/header.jsp" %>

	<section id="section1">
<%@ include file="/view/common/nav_category.jsp" %>
    
    
	<article id="read" style="
							border : 1px solid lightgray;
							border-radius: 5px;
							padding : 30px;
	">
        <article id="read-head">
           
            <div>
                <a href="board?cmd=blist&category=${category}" class="board-title" style="color: #03c75a">${categoryName}&nbsp;></a><br>
                <span class="content-title" style="font-size: 20px;">&nbsp;${title}</span>
            </div>
            
            <div>
                <span class="id" style="font-weight: bold;">&nbsp;${id}</span><br>
                <span><span style="color:lightgray;">&nbsp;${regDate}</span>&nbsp;|&nbsp;조회수&nbsp;:&nbsp;${hit}&nbsp;|&nbsp;<a href="board?cmd=upGob&idx=${idx}&id=${sessionScope.id}&gob=true">좋아요</a>&nbsp;:&nbsp;<span style="color:red">${good}</span>&nbsp;|&nbsp;<a href="board?cmd=upGob&idx=${idx}&id=${sessionScope.id}&gob=false">싫어요</a>&nbsp;:&nbsp;<span style="color:blue">${bad}</span></span>
            </div>
            
		<c:if test="${gobResult eq 0}">
			<script>
				alert("이미 좋아요 & 싫어요 하였습니다.");
			</script>
		</c:if>
            
            <div class="content">
                <textarea style="resize: none;" readonly >${content}</textarea>
            </div>
        </article>
        
        
        
        
        
        
        <%--댓글 가져오기 로직 --%>
        <%
        	 
        %>
        
        
        
        <!-- 댓글 가져오기 구현부 -->
        <article id="read-reply">
            <div style="border-bottom : 1px solid lightgray;
            			margin-top : 10px;
            			margin-bottom : 5px;
            			padding-bottom : 5px;
            			">
            	댓글&nbsp;<span style="font-weight: bold;"><c:out value="${fn:length(rdto)}"/></span>
            </div>
            
            
            <div>
            <c:forEach var="reply1" items="${rdto}" varStatus="status">
				<%--
				 댓글끼리 구분선 구현
				반복문 마지막때 구분선 사라지는 로직.
				--%>
	           	<c:choose>
	           		<%-- 반복문의 마지막 때 true--%>
	           		<c:when test="${status.last}">
	           			<div>
		            		<span style="font-weight:bold;"><c:out value="${reply1.id}"/></span><br>
			            	<c:out value="${reply1.rContent}"/><br>
			            	<span style="color:lightgray;"><c:out value="${reply1.regDate}"/></span>
		            		<c:choose>
			            		<c:when test="${sessionScope.id eq reply1.id }">
			            			<button id="reply-del" onclick="location.href='board?cmd=rdel&ridx=${reply1.ridx}&bidx=${reply1.bidx}'">삭제</button>
			            		</c:when>
			            	</c:choose>	
		            	</div>
	           		</c:when>
	           		
	           		<c:otherwise>
	           			<div style="border-bottom: 1px solid lightgray;">
		            		<span style="font-weight:bold;"><c:out value="${reply1.id}"/></span><br>
			            	<c:out value="${reply1.rContent}"/><br>
			            	<span style="color:lightgray;"><c:out value="${reply1.regDate}"/></span>
			            	<c:choose>
			            		<c:when test="${sessionScope.id eq reply1.id }">
			            			<button id="reply-del" onclick="location.href='board?cmd=rdel&ridx=${reply1.ridx}&bidx=${reply1.bidx}'">삭제</button>
			            		</c:when>
			            	</c:choose>
		            	</div>
	           		</c:otherwise>
	           	</c:choose>
            </c:forEach>
            
            </div>
            
            
            <!-- 댓글입력 구현부 -->
            <form action="view/board/check_reply.jsp" style="border : 1px solid lightGray;
            			 border-radius: 3px;
            			 padding : 10px;
            			 margin-top : 5px;
            			">
            	<label style="font-weight : bold;">${sessionScope.id}</label><br>
            	<input type="text" name="reply" id="input-reply" placeholder="댓글을 남겨보세요">
            	<input type="hidden" name="bidx" value="${idx}">
            	<input type="hidden" name="id" value="${sessionScope.id}">
            	<input type="submit" value="등록" id="btn-reply" style="background-color : #7affcf; margin : 0px;">
            </form>
        </article>
        
        
        <!-- 수정 삭제, 게시글의 작성자 아이디와, 로그인세션 ID값 검사하여 보여줌. -->
        <div id="btns">
        <c:choose>
        	<c:when test="${sessionScope.id eq id}">
		        <button id="btn-edit"  onclick="location.href='board?cmd=bedit&idx=${idx}'">수정</button>
		        <button id="btn-del"  onclick="location.href='board?cmd=bdelete&idx=${idx}'">삭제</button>
		        
    		</c:when>
    		<c:otherwise>
    		</c:otherwise>
    	</c:choose>
    	<button id="btn-list"  onclick="location.href='board?cmd=blist&category=${category}'">목록</button>
    	</div>
    </article>
    </section>
    <%@ include file="/view/board/ajax_blist.jsp" %>
	<%@ include file="/view/common/footer.jsp" %>
</div>

</body>
</html>