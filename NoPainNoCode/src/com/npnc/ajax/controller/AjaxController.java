package com.npnc.ajax.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.npnc.ajax.service.ABListHandler;
import com.npnc.ajax.service.ACommandHandler;
import com.npnc.ajax.service.AMCateGradeChgHandler;
import com.npnc.ajax.service.AMGradeChangeHandler;

@WebServlet("/ajax")
public class AjaxController extends HttpServlet {	//ajaxó���� ����� controller
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String cmd = request.getParameter("cmd");	//����� ��û ���
		ACommandHandler handler = null;
		JSONObject json = null;
		if(cmd.equals("ablist")){			//�Խñ� ��ȸ �ؿ� �Խñ۸���Ʈ�� �����ֱ� ���� ���
			handler = new ABListHandler();	//cmd�Ķ���Ϳ� �´� handler����
		}else if(cmd.equals("mgrade")){				//ȸ����� ����
			handler = new AMGradeChangeHandler();
		}else if(cmd.equals("mcategrade")){			//ī�װ� �б����, ������� ����
			handler = new AMCateGradeChgHandler();
		}
		json = handler.process(request, response);	//json�� ��ȯ �޾Ƽ�
		response.getWriter().print(json);			//response�� ��� ��Ʈ�� ���� �� �̸� �̿��ؼ� json�� ���ָ� ajax��û�� �־��� �������� ������ ���޵ȴ�
	}
}