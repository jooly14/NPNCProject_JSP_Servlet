package com.npnc.manage.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.category.service.CListHandler;
import com.npnc.manage.service.CListCntHandler;
import com.npnc.manage.service.MBDeleteHandler;
import com.npnc.manage.service.MBListHandler;
import com.npnc.manage.service.MBMoveCategoryHandler;

@WebServlet("/manage")
public class ManageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String viewpage="";							//이동할 jsp 페이지
		String cmd = request.getParameter("cmd");	//사용자 요청 기능
		CommandHandler handler = null;
		
		if(cmd.equals("blist")){
			handler = new MBListHandler();	//cmd파라미터에 맞는 handler생성
			CommandHandler clistHandler = new CListHandler();	//모든 페이지에 카테고리를 불러와야되기 때문에
			clistHandler.process(request, response);
		}else if(cmd.equals("onepassdel")){
			handler = new MBDeleteHandler();
			viewpage = handler.process(request, response);
			response.sendRedirect(viewpage);
			return;
		}else if(cmd.equals("movecategory")){
			handler = new MBMoveCategoryHandler();
			CommandHandler clistHandler = new CListHandler();	//모든 페이지에 카테고리를 불러와야되기 때문에
			clistHandler.process(request, response);
		}else if(cmd.equals("clist")){
			handler = new CListCntHandler();
		}
		
		viewpage = handler.process(request,response);	//dao 호출 및 필요 기능 실행하고 jsp페이지 받아오기
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewpage);
		dispatcher.forward(request, response);
		
	}
}