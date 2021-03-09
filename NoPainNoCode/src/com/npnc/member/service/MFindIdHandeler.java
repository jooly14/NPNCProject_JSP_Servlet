package com.npnc.member.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.member.dao.MDao;

public class MFindIdHandeler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		MDao dao=new MDao();
		String idnum=request.getParameter("idnum");
		String phonenum=request.getParameter("phonenum");
		String id=dao.findId(idnum,phonenum);
		request.setAttribute("id",id);
		return "view/member/tryfindid.jsp";
	}
	
}