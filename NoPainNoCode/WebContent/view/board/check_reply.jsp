<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.npnc.board.dao.BDao"%>

<%
String reply = request.getParameter("reply");
int bidx = Integer.parseInt(request.getParameter("bidx"));
String id = request.getParameter("id");

System.out.println("리플작성 form데이터 reply 값 : " + reply);
System.out.println("리플작성 form데이터 bidx 값 : " + bidx);
System.out.println("리플작성 form데이터 id 값 : " + id);

BDao bdao = new BDao();
int result = bdao.insertReply(bidx, id, reply);
response.sendRedirect(request.getContextPath()+"/board?cmd=bread&idx="+bidx);
%>