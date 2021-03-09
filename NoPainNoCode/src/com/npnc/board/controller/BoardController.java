package com.npnc.board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.npnc.board.service.BListHandler;
import com.npnc.board.service.BWriteHandler;
import com.npnc.board.service.BWriteprocHandler;
import com.npnc.board.service.CommandHandler;
import com.npnc.board.service.NullHandler;
import com.npnc.category.service.CListHandler;

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
		String viewpage="";							//이동할 jsp 페이지
		String cmd = request.getParameter("cmd");	//사용자 요청 기능
		CommandHandler handler = null;
		if(cmd==null){
			handler = new NullHandler();
		}else if(cmd.equals("blist")){
			handler = new BListHandler();	//cmd파라미터에 맞는 handler생성
		}else if(cmd.equals("bwrite")){
			handler = new BWriteHandler();
		}else if(cmd.equals("bwriteproc")){
			handler = new BWriteprocHandler();
		}else{
			
		}
		
		viewpage = handler.process(request,response);	//dao 호출 및 필요 기능 실행하고 jsp페이지 받아오기
		CommandHandler clistHandler = new CListHandler();	//모든 페이지에 카테고리를 불러와야되기 때문에
		clistHandler.process(request, response);
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewpage);
		dispatcher.forward(request, response);
		
	}
}