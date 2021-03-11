<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.npnc.member.dao.MDao" %>
<%@ page import ="com.npnc.member.dto.MDto" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <style>
        body{
            text-align: center;
        }
        .wrap{
            width: 1024px;
            display: inline-block;
        }
        
        .wrap>div{
            width: 310px;
            display: inline-block;
            text-align: left
        }
        .naver{
            color: limegreen;
            font-size: 3em;
            font-weight: bold;
        }
        input[type=text],input[type=password]{
            width: 300px;
            height: 30px;
            margin-bottom: 20px;
        }
        input[type=submit]{
            width: 300px;
            height: 50px;
            border: 1px solid lightgray;
            background-color: limegreen;
            color: white;
        }
        input[type=button]{
            width: 300px;
            height: 50px;
            border: 1px solid lightgray;
            background-color: maroon;
            color: white;
        }
    </style>
</head>
<body>
    <div class="wrap">
        <span class="naver">NAVER</span><br>
        <%
        	String id = request.getParameter("id");
        	MDao dao= new MDao();
        	MDto dto = dao.viewInfo(id);
        %>
        <div class="content">
            <form action="../../member" method="post">
                <span class="name">아이디</span><br>
                <input type="text" name="id" value = <%=dto.getId() %> readonly><br>
                <span class="name">비밀번호</span><br>
                <input type="text" name="pw" value=<%=dto.getPw() %>><br>
                <span class="name">이름</span><br>
                <input type="text" name="name" value=<%=dto.getName() %> readonly><br>              
                <span class="name">이메일</span><br>
                <input type="text" name="email" value=<%=dto.getEmail() %>><br>
                <span class="name">주소</span><br>
                <input type="text" name="address" value=<%=dto.getAddress() %>><br>
                <span class="name">전화번호</span><br>
                <input type="text" name="phonenum" value=<%=dto.getPhonenum() %>><br>
                <input type="hidden" name="cmd" value="update"><br>
                <input type="submit" value="회원정보변경">
            </form>
            <form id="fm2" action="<%=request.getContextPath()%>/member" method="post">
            	<input type="hidden" value="delmember" name="cmd">
            	<input type="hidden" value="${sessionScope.id}" name="cmd">
           		 <input id="del" type="button" value="회원탈퇴">
            </form>
        </div>
    </div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		$("#del").click(function(){
			window.open('../member/del_mem_pop.jsp', '회원 탈퇴', 'top=100px,left=500px,width=350px,height=180px,scrollbars=yes');
		});
	})
</script>
</body>
</html>