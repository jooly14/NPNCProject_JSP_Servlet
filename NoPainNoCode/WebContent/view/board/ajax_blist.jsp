<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<body>
ajax테스트 페이지<br>
본래 글 읽기 페이지 될 위치<br>
	<div id="result">
		
	</div>
	<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(function(){
			ajaxFnc();
			var start;
			var end;
			$(document).on('click',".btn",ajaxFnc);
			
			function ajaxFnc() {
				var startRownumParam;
				if($(this).text()==""){
					startRownumParam = "";
				}else{
					startRownumParam = "&startRownum=";
					 if(isNaN(Number($(this).text()))){
						if($(this).text()=='이전'){
							startRownumParam += (start-2)*5;
						}else if($(this).text()=='다음'){
							startRownumParam += end*5;
						}
					}else{
						startRownumParam += (((Number($(this).text())-1)*5));
					}
				}
				var params = "cmd=ablist"+startRownumParam;
				$.ajax({
					type:"post",
					url:"<%=request.getContextPath()%>/ajax",
					data:params,
					dataType:"json",
					success:function(data){
						$("#result").html("");							//기존에 있던 값 없애기
						var pagesize = data.pagesize;
						var rownum = data.rownum;
						var startRownum = data.startRownum;
						var dtos = JSON.parse(data['dtos']);
						var curpage = data.curpage;
						var totalpage = data.totalpage;
						start = data.start;
						end = data.end;
						var table = $("<table border='1'></table>");	//리스트 생성
						for(var i=0;i<dtos.length;i++){
							var tr = $("<tr></tr>");
							var td1 = $("<td></td>");
							td1.append(dtos[i].idx);
							tr.append(td1);
							var td2 = $("<td></td>");
							var a1 = $("<a></a>");
							if(rownum-startRownum==i){
								a1.css('font-weight','bold');
							}
							a1.attr('href','<%=request.getContextPath()%>/board/?cmd=&idx='+dtos[i].idx);
							a1.append(dtos[i].title);
							td2.append(a1);
							tr.append(td2);
							var td3 = $("<td></td>");
							td3.append(dtos[i].id);
							tr.append(td3);
							var td4 = $("<td></td>");
							td4.append(dtos[i].regdate);
							tr.append(td4);
							table.append(tr);
						}
						$("#result").append(table);
						var div1 = $("<div></div>");					//페이징 생성
						if(start>1){
							var a3 = $("<a class='btn' style='cursor:pointer;'>이전</a>");
							div1.append(a3);
						}
						for(var i=start;i<end+1;i++){
							if(i>totalpage){
								break;
							}
							var a2 = $("<a class='btn' style='cursor:pointer;'></a>");
							if(i==curpage){
								a2.css('color','orange');
							}
							a2.append(i);
							div1.append(a2);	
						}
						if(end<totalpage){
							var a3 = $("<a class='btn' style='cursor:pointer;'>다음</a>");
							div1.append(a3);
						}
						$("#result").append(div1);
						
					},
					error:function(request,status,error){
					    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					 }
	
				});
			}
		});
	</script>
</body>
</html>