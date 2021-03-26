<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div style="width:1080px;margin:0 auto 70px;">
	<div id="ajax-blist" style="margin-left:280px;">
		
	</div>
</div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>
	$(function(){
		ajaxFnc();
		var start;
		var end;
		
		// 게시글 읽기 하단에 게시판 글 리스트
		$(document).on('click',".blist-btn",ajaxFnc);
		
		function ajaxFnc() {
			var startRownumParam ="";
				startRownumParam = "&idx="+"${idx}"+"&category="+"${category}";
			if($(this).text()==""){
			}else{
				startRownumParam += "&startRownum=";
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
					$("#ajax-blist").html("");							//기존에 있던 값 없애기
					var pagesize = data.pagesize;
					var rownum = data.rownum;
					var startRownum = data.startRownum;
					var dtos = JSON.parse(data['dtos']);
					var curpage = data.curpage;
					var totalpage = data.totalpage;
					start = data.start;
					end = data.end;
					var table = $("<table id='ajax-tbl' style='width:100%;'></table>");	//리스트 생성
					for(var i=0;i<dtos.length;i++){
						var tr = $("<tr></tr>");
						var td1 = $("<td></td>");
						td1.append(dtos[i].idx);
						tr.append(td1);
						var td2 = $("<td></td>");
						var a1 = $("<a></a>");
						if(dtos[i].idx=="${idx}"){
							a1.css('font-weight','bold');
						}
						a1.attr('href','<%=request.getContextPath()%>/board?cmd=bread&idx='+dtos[i].idx+"${empty category?' ':'&catetory='}"+"${category}");
						a1.append(dtos[i].title);
						td2.append(a1);
						tr.append(td2);
						var td3 = $("<td></td>");
						td3.append(dtos[i].id);
						tr.append(td3);
						var td4 = $("<td></td>");
						td4.append(moment(new Date(dtos[i].regdate)).format('YYYY.MM.DD'));

						tr.append(td4);
						table.append(tr);
					}
					$("#ajax-blist").append(table);
					var div1 = $("<div style='width:100%;display:flex;justify-content:center;margin:10px;'></div>");					//페이징 생성
					if(start>1){
						var a3 = $("<a class='blist-btn' style='width:50px;'>이전</a>");
						div1.append(a3);
					}
					for(var i=start;i<end+1;i++){
						if(i>totalpage){
							break;
						}
						var a2 = $("<a class='blist-btn' style='border:none;'></a>");
						if(i==curpage){
							a2.css('color','#03c75a').css('border','1px solid #e5e5e5');
						}
						a2.append(i);
						div1.append(a2);	
					}
					if(end<totalpage){
						var a3 = $("<a class='blist-btn' style='width:50px;'>다음</a>");
						div1.append(a3);
					}
					$("#ajax-blist").append(div1);
					
				},
				error:function(request,status,error){
				    alert("문제발생");
				 }

			});
		}
	});
</script>
