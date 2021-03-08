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
public class AjaxController extends HttpServlet {	//ajax처리를 담당할 controller
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
		if(cmd.equals("ablist")){			//게시글 조회 밑에 게시글리스트를 보여주기 위한 기능
			handler = new ABListHandler();	//cmd파라미터에 맞는 handler생성
		}else{
			
		}
		json = handler.process(request, response);	//json을 반환 받아서
		response.getWriter().print(json);			//response의 출력 스트림 생성 후 이를 이용해서 json을 써주면 ajax요청이 있었던 페이지로 응답이 전달된다
	}
}