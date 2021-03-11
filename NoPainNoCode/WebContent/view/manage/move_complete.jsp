<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#wrap{
		width:320px;
		margin : 0 auto;
		margin-top:70px;
		display:flex;
		flex-flow:row wrap;
		justify-content: center;
	}
	#d1{
		width: 100%;
		text-align:center;
	}
	input[type=button]{
		width: 80px;
	    height: 30px;
	    background-color: white;
	    border: 1px solid lightgray;
	    margin: 2px 0;
	    margin-top:30px;
	}
</style>
</head>
<body onunload='opener.location.reload();'><!-- 해당 팝업 창은 닫히면서 부모창을 새로고침 -->
<div id="wrap">
	<div id="d1">카테고리 변경이 완료 되었습니다.</div>
	<input type="button" onclick="window.close()" value="닫기">
</div>
<script>
	window.resizeTo(400,300);
</script>
</body>
</html>