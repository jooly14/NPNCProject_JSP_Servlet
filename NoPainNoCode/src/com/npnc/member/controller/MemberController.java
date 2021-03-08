package com.npnc.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.BListHandler;
import com.npnc.board.service.CommandHandler;
import com.npnc.category.service.CListHandler;
import com.npnc.member.service.MLegHandler;
import com.npnc.member.service.MLoginHandler;

@WebServlet("/member")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {doProcess(request,response);}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {doProcess(request,response);}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String viewpage="";							//�̵��� jsp ������
		String cmd = request.getParameter("cmd");	//����� ��û ���
		CommandHandler handler = null;
		if(cmd.equals("leg")){
			handler = new MLegHandler();	//cmd�Ķ���Ϳ� �´� handler����
		}else if(cmd.equals("login")){
			handler = new MLoginHandler();	//cmd�Ķ���Ϳ� �´� handler����
		}else{
			
		}
		viewpage = handler.process(request,response);	//dao ȣ�� �� �ʿ� ��� �����ϰ� jsp������ �޾ƿ���
		CommandHandler clistHandler = new CListHandler();	//��� �������� ī�װ��� �ҷ��;ߵǱ� ������
		clistHandler.process(request, response);
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewpage);
		dispatcher.forward(request, response);
	}

}
