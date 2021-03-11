<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<style>
	#wrap{
		width:320px;
		margin : 0 auto;		
	}
	table{
		width:100%;
		border-collapse:collapse;
	}
	td{
		text-align: center;
		padding: 7px 7px;
	}
	#chk{
	    width: 180px;
	    height: 30px;
	    border-radius: 0;
	    padding-left: 4px;
	    border: 1px solid lightgray;
	}
	#del,#cancel{
		width: 80px;
	    height: 30px;
	    background-color: white;
	    border: 1px solid lightgray;
	    margin: 2px 0;
	}
	#del{
		margin-left:70px;
	}
	#cancel{
		margin-right:70px;
	}
</style>
</head>
<body>
<div id="wrap">
	<table>
		<tr>
			<td colspan="2">정말 탈퇴를 진행하시겠습니까?</td>
		</tr>
		<tr>
			<td colspan="2"><input id="chk" type="password" placeholder="비밀번호를 입력해주세요"></td>
		</tr>
		<tr>
			<td><input id="del" type="button" value="탈퇴"></td>
			<td><input id="cancel" type="button" value="취소" onclick="window.close()"></td>
		</tr>
	</table>
</div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var fm2 = opener.document.getElementById("fm2");
	$(function(){
		$("#del").click(function(){
			var pw = "${sessionScope.pw}"; 
			if($("#chk").val()==pw){
				$(fm2).submit();
				window.close();
			}else{
				alert("비밀번호가 틀렸습니다");
			}
		});
	})
</script>
</body>
</html>