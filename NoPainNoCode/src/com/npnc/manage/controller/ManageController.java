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
import com.npnc.manage.service.MCAddCategoryHandler;
import com.npnc.manage.service.MCDeleteCategoryHandler;
import com.npnc.manage.service.MCDeleteMainHandler;
import com.npnc.manage.service.MCListCntHandler;
import com.npnc.manage.service.MCMoveCategoryHandler;
import com.npnc.manage.service.MGradeHandler;
import com.npnc.manage.service.MMListHandler;
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
		}else if(cmd.equals("onepassdel")){						//게시글 일괄 삭제
			handler = new MBDeleteHandler();
			viewpage = handler.process(request, response);
			response.sendRedirect(viewpage);
			return;
		}else if(cmd.equals("movecategory")){					//게시글 카테고리 이동
			handler = new MBMoveCategoryHandler();
			CommandHandler clistHandler = new CListHandler();	//모든 페이지에 카테고리를 불러와야되기 때문에
			clistHandler.process(request, response);
		}else if(cmd.equals("clist")){							//카테고리 리스트
			handler = new MGradeHandler();
			handler.process(request, response);
			handler = new MCListCntHandler();
		}else if(cmd.equals("delmainc")){						//메인카테고리 삭제
			handler = new MCDeleteMainHandler();
			viewpage = handler.process(request, response);
			response.sendRedirect(viewpage);
			return;
		}else if(cmd.equals("delc")){							//카테고리 삭제
			handler = new MCDeleteCategoryHandler();
			viewpage = handler.process(request, response);
			response.sendRedirect(viewpage);
			return;
		}else if(cmd.equals("addcate")){
			handler = new MCAddCategoryHandler();
			viewpage = handler.process(request, response);
			response.sendRedirect(viewpage);
			return;
		}else if(cmd.equals("moveall")){
			handler = new MCMoveCategoryHandler();
		}else if(cmd.equals("mlist")){
			handler = new MGradeHandler();
			handler.process(request, response);
			handler = new MMListHandler();
		}
		
		viewpage = handler.process(request,response);	//dao 호출 및 필요 기능 실행하고 jsp페이지 받아오기
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewpage);
		dispatcher.forward(request, response);
		
	}
}