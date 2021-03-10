package com.npnc.member.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.member.dao.MDao;

public class MChangePwHandler implements CommandHandler{
	
	@Override	
	public String process(HttpServletRequest request, HttpServletResponse response) {
		MDao dao=new MDao();
		String pw=request.getParameter("pw");
		String id=request.getParameter("id");	
		int result = dao.changePw(pw, id);
		if(result==1){
			return "view/index.jsp";
		}else{
			return "view/member/changepw.jsp";
		}
		
	}
	
}
