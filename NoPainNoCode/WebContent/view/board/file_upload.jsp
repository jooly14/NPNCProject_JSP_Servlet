<%@page import="java.io.File"%>
<%@page import="com.npnc.board.dao.BDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>upload</title>
</head>
<body>
<%


	//실제 파일이 업로들 될 폴더명 
	String path = getServletContext().getRealPath("/upload");
	//out.println(path);
	//   /Users/mac/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/DBProject/
	// upload라는 폴더 만들고, getRealPath("/upload")로 지정
	File file2 = new File(path);
	if(!file2.isDirectory()){
		file2.mkdir();
	}
	
	int maxSize = 1024*1024*10; // 10메가 
	String enc = "utf-8";
	
	MultipartRequest mrequest = new MultipartRequest(
								request,	//리퀘스트 
								path,		//파일 업로드 경로 
								maxSize,	//최대 업로드 파일 크기 
								enc,		//인코딩 타입 
								new DefaultFileRenamePolicy()); //중복이름처리 
					
	//여기까지가 파일 업로드가 일어난 시점.
	
	//업로드한 정보 출력 
	//파일이 실제 서버에 저장되었을때 파일명
	// - 동일한 파일이 업로드 되면 이름이 바껴서 업로드 됨 
	String category = mrequest.getParameter("category");
	String title = mrequest.getParameter("title");
	String content = mrequest.getParameter("content");
	String id = mrequest.getParameter("id");
	String file = mrequest.getFilesystemName("file");
	
	//파일이 업로드가 될때 넘어온 파일명 
	String originFile1 = mrequest.getOriginalFileName("file");
	
	
	System.out.println("======= 디버깅 확인 === file_uplost === 디버깅 확인 =========");
	System.out.println("카테고리 : " + category);
	System.out.println("제목 : " + title);
	System.out.println("내용 : " + content);
	System.out.println("아이디 : " + id);
	System.out.println("파일명 : " + file);
	
	
	/*
	- 글쓰기를 통해 들어오면 true, 글수정을 통해 들어오면 false
	- true면 dao의 글쓰기 메서드 호출
	- false면 dao의 글수정 메서드 호출
	*/ 
	int isWrite = Integer.parseInt(mrequest.getParameter("isWrite"));
	System.out.println("넘어온 bool값 : " + isWrite);
	
	
	BDao dao = new BDao();
	
	if(isWrite > 0){
		//글쓰기로 들어올때 실행.
		
		dao.insert(id, category, title, content, file);
		response.sendRedirect(request.getContextPath()+"/board?cmd=blist&category="+category); // 내가 쓴 페이지 읽기로 이동 
	} else {
		//글수정으로 들어올때 실행.
		int idx = Integer.parseInt(mrequest.getParameter("idx"));
		
		dao.updateArticle(title, content, idx);
		response.sendRedirect(request.getContextPath()+"/board?cmd=bread&idx="+idx); // 내가 수정한 글로 이동 
	}
	
%>
	<%--TESTCODE <%= category %><br>
	<%= title %><br>
	<%= content %><br>
	<%= originFile1 %><br>
	
	<img src="upload/<%= file %>"> --%>
	
</body>
</html>