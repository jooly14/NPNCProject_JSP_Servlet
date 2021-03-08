package com.npnc.member.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.member.dao.MDao;

public class MLegHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		String id=request.getParameter("id");
		String pw=request.getParameter("pw");
		String name=request.getParameter("name");
		String idnum=request.getParameter("idnum");
		String email=request.getParameter("email");
		String address=request.getParameter("address");
		String phonenum=request.getParameter("phonenum");
		MDao dao=new MDao();
		int result=dao.legMember(id,pw,name,idnum,email,address,phonenum);
		request.setAttribute("result", result);
		return "view/member/tryleg.jsp"; // 회원가입 성공인지 실패인지 보여주는 페이지
	}
}
