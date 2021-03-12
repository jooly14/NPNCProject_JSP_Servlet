package com.npnc.board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.dao.BDao;
import com.npnc.board.service.*;
import com.npnc.category.service.CListHandler;
import com.npnc.manage.service.MGradeHandler;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/board")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String viewpage="";
		String cmd = request.getParameter("cmd");
		System.out.println("rInsert확인용 : "+cmd);
		CommandHandler handler = null;
		
		if(cmd == null){
			handler = new BListHandler();
		}else if(cmd.equals("blist")){
			handler = new BListHandler();
		}else if(cmd.equals("bwrite")){
			handler = new BWriteHandler();
		}else if(cmd.equals("bread")){
			handler = new BReadHandler();
			
		}else if(cmd.equals("bedit")){
			handler = new BEditHandler();
			
		}else if(cmd.equals("bdelete")) {
			handler = new BDeleteHandler();
		
		}else if(cmd.equals("upGob")) {
			handler = new BUpGobHandler();
		
		}else if(cmd.equals("rdel")) {
			handler = new RDeleteHandler();
		
		}else if(cmd.equals("rInsert")) {
			System.out.println("rInsert 들어왔음!");
		}
		
		viewpage = handler.process(request,response);
		handler = new MGradeHandler();
		handler.process(request, response);
		CommandHandler clistHandler = new CListHandler();
		clistHandler.process(request, response);
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewpage);
		dispatcher.forward(request, response);
	}
}