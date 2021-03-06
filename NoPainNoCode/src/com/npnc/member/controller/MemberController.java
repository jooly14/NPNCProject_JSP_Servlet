package com.npnc.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.category.service.CListHandler;
import com.npnc.member.service.MChangePwHandler;
import com.npnc.member.service.MDelmemberHandler;
import com.npnc.member.service.MFindIdHandeler;
import com.npnc.member.service.MFindPwHandler;
import com.npnc.member.service.MLegHandler;
import com.npnc.member.service.MLoginHandler;
import com.npnc.member.service.MLogoutHandler;
import com.npnc.member.service.MInfoUpdateHandler;

@WebServlet("/member")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {doProcess(request,response);}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {doProcess(request,response);}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String viewpage="";							//이동할 jsp 페이지
		String cmd = request.getParameter("cmd");	//사용자 요청 기능
		CommandHandler handler = null;
		if(cmd.equals("leg")){
			handler = new MLegHandler();	//cmd파라미터에 맞는 handler생성
		}else if(cmd.equals("login")){
			handler = new MLoginHandler();	
		}else if(cmd.equals("logout")){
			handler = new MLogoutHandler();
			handler.process(request, response);
			response.sendRedirect("board");
			return;
		}else if(cmd.equals("update")){
			handler = new MInfoUpdateHandler();
			viewpage = handler.process(request, response);
			response.sendRedirect(viewpage);
			return;
		}else if(cmd.equals("delmember")){
			handler = new MDelmemberHandler();	
			viewpage = handler.process(request, response);
			response.sendRedirect(viewpage);
			return;
		}else if(cmd.equals("findid")){
			handler = new MFindIdHandeler();	
		}else if(cmd.equals("findpw")){
			handler = new MFindPwHandler();	
		}else if(cmd.equals("changepw")){
			handler = new MChangePwHandler();	
		}else {
			
		}
		viewpage = handler.process(request,response);	//dao 호출 및 필요 기능 실행하고 jsp페이지 받아오기
		CommandHandler clistHandler = new CListHandler();	//모든 페이지에 카테고리를 불러와야되기 때문에
		clistHandler.process(request, response);
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewpage);
		dispatcher.forward(request, response);
	}

}
