<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 페이지</title>
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
		.header>input[type=button]:nth-child(2){
		    color: yellow;
		}
		span{
            color: gray;
        }
        .content,table{
            display: inline-block;
        }
        .content{
            border: 1px solid lightgray;
            padding: 20px;
            width: 60%;
            display: inline-block;
        }
        input[type=submit]{
        	background-color: limegreen;
        	width: 200px;
        	height: 40px;
        	color:white;
        	border: 1px solid lightgray;
        }
        .goto{
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
	<div class="header"><input type="button" value="아이디 찾기" onclick="location.href='findid.jsp'"> <input type="button" value="비밀번호 찾기" onclick="location.href='findpw.jsp'"></div>
    <div class="wrap">
        <br><br>
        <div class=content>
            <span>회원정보에 등록한 정보가 입력한 정보를 똑같이 입력해 주세요.</span><br><br>
			<form action="../../member" method="post">
				<table>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="id"></td>
					</tr>
					<tr>
						<td>주민등록번호</td>
						<td><input type="text" name="idnum"></td>
					</tr>
					<tr>
						<td>휴대전화</td>
						<td><input type="text" name="phonenum"></td>
					</tr>
				</table><br><br>
				<input type="hidden" name="cmd" value="findpw">
				<input type="submit" value="비빌번호 변경">
			</form>
		</div><br><br>
		<input class="goto login"type="button" value="로그인" onclick="location.href='login.jsp'"> | <input class="goto leg" type="button" value="회원가입" onclick="location.href='leg.jsp'">
	</div>
</body>
</html>