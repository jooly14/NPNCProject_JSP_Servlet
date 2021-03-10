<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기 : no pain no code</title>
    <style>
        html,body{
            margin: 0;
            padding: 0;
        }
        body{
            text-align: center;
        }
        .wrap{
            width: 1024px;
            text-align: center;
            display: inline-block;
        }
        .header{
            background-color: limegreen;
            color: yellow;
            height: 25px;
            padding: 10px;
            text-align: center;
        }
        .header>input[type=button]{
            background-color: limegreen;
            border: none;
            cursor: pointer;
            color: white;
            width: 200px;
            font-size: 18px;
            font-weight: bold;
        }
        .header>input[type=button]:first-child{
            color: yellow;
        }
        .move{
            width: 100px;
            height: 35px;
            border: 1px solid gray;
            background: white;
        }
        .move:nth-child(5){
            background-color: limegreen;
            color: white;
        }
        .wraptitle{
            text-align: left;
            width: 500px;
            display: inline-block;
            padding: 10px;
            font-weight: bold;
        }
        
    </style>
</head>
<body>
    <div class="header"><input type="button" value="아이디 찾기" onclick="location.href='findid.jsp'"> <input type="button" value="비밀번호 찾기" onclick="location.href='findpw.jsp'"></div>
    <div class="wrap">
        <div class="wraptitle">
            아이디 찾기
            <hr>
        </div><br>
			고객님의 정보와 일치하는 아이디는
<% 
        	String id=(String)request.getAttribute("id");
        	if(id==null){
%>
        		정보가 틀렸습니
<%
        	}else{
%>
        	<%=id%>입니
<%
			}
%>
		다.<br><br>
        <input class="move" type="button" value="로그인하기" onclick="location.href='view/member/login.jsp'">
        <input class="move" type="button" value="비밀번호 찾기" onclick="location.href='view/member/findpw.jsp'">
        <input class="move" type="button" value="회원가입" onclick="location.href='view/member/leg.jsp'"> 
    </div>
</body>
</html>