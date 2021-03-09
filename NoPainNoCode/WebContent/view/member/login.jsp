<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
    <style>
        body{
            text-align: center;
        }
        .wrap{
            width: 1024px;
            display: inline-block
        }
        input{
            width: 400px;
            height: 30px;
            
            border: 1px solid lightgray;
            padding: 10px;
            margin: 5px;
        }
        input[type=submit]{
            background-color: limegreen;
            color: white;
            cursor: pointer;
            height: 50px;
            width: 420px;
        }
        .logo{
            font-size: 4em;
            font-weight: bold;
            color: limegreen;
        }
        .find,.leg{
            width: 100px;
            padding: 0;
            background-color: white;
            border: none;
            color: grey;
            cursor: pointer;
        }
    </style>
</head>
<body>
   <div class="wrap">
   <form action="../../member" method="post">
        <div class="logo">NAVER</div>
        <input type="text" placeholder="아이디" name="id"><br>
        <input type="text" placeholder="패스워드" name="pw"><br>
        <input type="submit"  value="로그인"><br>
   </form>
        <input class="find id" type="button" onclick="location.href='findid.jsp'" value="아이디 찾기">|<input class="find pw" type="button" onclick="location.href='findpw.jsp'" value="비밀번호 찾기">|<input class="leg" type="button" onclick="location.href='leg.jsp'" value="회원 가입">
        <hr>
        푸터푸터푸터푸터
    </div>
</body>
</html>