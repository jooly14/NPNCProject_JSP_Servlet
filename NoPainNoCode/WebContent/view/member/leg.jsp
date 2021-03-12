<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
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
        a{
            font-size: 2em;
            font-weight: bold;
            color: limegreen;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="wrap">
        <span class="naver"><a href="../../board">CAFE NAME</a></span><br><br>
        <div class="content">
            <form action="../../member">
                <span class="name">아이디</span><br>
                <input type="text" name="id"><br>
                <span class="name">비밀번호</span><br>
                <input type="text" name="pw"><br>
                <span class="name">이름</span><br>
                <input type="text" name="name"><br>
                <span class="name">주민등록번호</span><br>
                <input type="password" name="idnum"><br>
                <span class="name">이메일</span><br>
                <input type="text" name="email"><br>
                <span class="name">주소</span><br>
                <input type="text" name="address"><br>
                <span class="name">전화번호</span><br>
                <input type="text" name="phonenum"><br>
                <input type="hidden" name="cmd" value="leg"><br>
                <input type="submit" value="가입하기">
            </form>
        </div>
    </div>
</body>
</html>