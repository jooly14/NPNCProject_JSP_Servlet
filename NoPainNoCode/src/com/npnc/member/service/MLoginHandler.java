package com.npnc.member.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.member.dao.MDao;
import com.npnc.member.dto.MDto;

public class MLoginHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		String id=request.getParameter("id");//로그인 아이디
		String pw=request.getParameter("pw");//로그인 패스워드
		MDao dao=new MDao();
		MDto dto=dao.loginMember(id, pw);
		request.setAttribute("id", dto.getId());
		request.setAttribute("pw", dto.getPw());
		
		return "view/member/trylogin.jsp";
	}
}