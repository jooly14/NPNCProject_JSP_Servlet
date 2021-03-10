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
        .findid{
            border: 1px solid lightgray;
            padding: 20px;
            width: 60%;
            display: inline-block;
        }
        .find{
            margin: 10px;
        }
        table{
            display: inline-block;
        }
        span{
            color: gray;
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
        input[type=submit]{
        	background-color: limegreen;
        	width: 200px;
        	height: 40px;
        	color:white;
        	border: 1px solid lightgray;
        }
    </style>
</head>
<body>
    <div class="header"><input type="button" value="아이디 찾기" onclick="location.href='findid.jsp'"> <input type="button" value="비밀번호 찾기" onclick="location.href='findpw.jsp'"></div>
    <div class="wrap">
        <br><br>
        <span>회원정보에 등록한 정보가 입력한 정보를 똑같이 입력해 주세요.</span><br><br>
        <div class="findid">
            <span>회원정보에 등록한 휴대전화번호로 인증</span><br>
            <div class="find phone">
                <form action="../../member" method="post">
                    <table>
						<tr>
                            <td>이름</td>
                            <td><input type="text" name="name"></td>
                        </tr>
                        <tr>
                            <td>휴대전화</td>
                            <td><input type="text" name="phonenum"></td>
                        </tr>
                        <tr>
                            <td>주민등록번호</td>
                            <td><input type="password" name="idnum"></td>
                        </tr>
                    </table>
                    <br>
                    <input type="hidden" name="cmd" value="findid">
                    <input type="submit" value="아이디 찾기">
                </form>
            </div>
            
            <hr>
           <span>본인확인 이메일로 인증</span>
            <div class="find email">
                <form action="../../member" method="post">
                    <table>
                        <tr>
                            <td>이름</td>
                            <td><input type="text" name="name"></td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td><input type="text" name="email"></td>
                        </tr>
                        <tr>
                            <td>주민등록번호</td>
                            <td><input type="password" name="idnum"></td>
                        </tr>
                    </table>
                    <br>
                    <input type="hidden" name="cmd" value="findid">
                    <input type="submit" value="아이디 찾기">
                </form>
            </div>
        </div><br>
       <input type="button" value="로그인" > | 회원가입
    </div>
</body>
</html>