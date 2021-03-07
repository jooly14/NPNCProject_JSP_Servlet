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

@WebServlet("/ajax")
public class AjaxController extends HttpServlet {
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
		String cmd = request.getParameter("cmd");	//사용자 요청 기능
		ACommandHandler handler = null;
		JSONObject json = null;
		if(cmd.equals("ablist")){
			handler = new ABListHandler();	//cmd파라미터에 맞는 handler생성
		}else{
			
		}
		json = handler.process(request, response);
		response.getWriter().print(json);
	}
}