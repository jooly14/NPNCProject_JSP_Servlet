package com.npnc.member.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.member.dao.MDao;

public class MInfoUpdateHandler  implements CommandHandler{
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		//값 받아오기
		String id=request.getParameter("id");
		String pw=request.getParameter("pw");
		String name=request.getParameter("name");
		String idnum=request.getParameter("idnum");
		String email=request.getParameter("email");
		String address=request.getParameter("address");
		String phonenum=request.getParameter("phonenum");
		MDao dao=new MDao();
		// 정보 받아와서 업데이트하기
		int result=dao.Mypage(id,pw,name,idnum,email,address,phonenum);
		request.setAttribute("result", result);
		
		return "board";
	}
}
