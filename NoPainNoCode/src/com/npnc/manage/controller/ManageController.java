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
		String viewpage="";							//�̵��� jsp ������
		String cmd = request.getParameter("cmd");	//����� ��û ���
		CommandHandler handler = null;
		
		if(cmd.equals("blist")){
			handler = new MBListHandler();	//cmd�Ķ���Ϳ� �´� handler����
			CommandHandler clistHandler = new CListHandler();	//��� �������� ī�װ��� �ҷ��;ߵǱ� ������
			clistHandler.process(request, response);
		}else if(cmd.equals("onepassdel")){						//�Խñ� �ϰ� ����
			handler = new MBDeleteHandler();
			viewpage = handler.process(request, response);
			response.sendRedirect(viewpage);
			return;
		}else if(cmd.equals("movecategory")){					//�Խñ� ī�װ� �̵�
			handler = new MBMoveCategoryHandler();
			CommandHandler clistHandler = new CListHandler();	//��� �������� ī�װ��� �ҷ��;ߵǱ� ������
			clistHandler.process(request, response);
		}else if(cmd.equals("clist")){							//ī�װ� ����Ʈ
			handler = new MGradeHandler();
			handler.process(request, response);
			handler = new MCListCntHandler();
		}else if(cmd.equals("delmainc")){						//����ī�װ� ����
			handler = new MCDeleteMainHandler();
			viewpage = handler.process(request, response);
			response.sendRedirect(viewpage);
			return;
		}else if(cmd.equals("delc")){							//ī�װ� ����
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
		
		viewpage = handler.process(request,response);	//dao ȣ�� �� �ʿ� ��� �����ϰ� jsp������ �޾ƿ���
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewpage);
		dispatcher.forward(request, response);
		
	}
}