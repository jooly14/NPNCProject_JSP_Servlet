package com.npnc.member.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.member.dao.MDao;

public class MFindPwHandler implements CommandHandler{
	
	@Override	
	public String process(HttpServletRequest request, HttpServletResponse response) {
		MDao dao=new MDao();
		String id=request.getParameter("id");
		String idnum=request.getParameter("idnum");
		String phonenum=request.getParameter("phonenum");
		int result=dao.findPw(id,idnum,phonenum);
		if(result==1){
			request.setAttribute("id", id);
			return "view/member/changepw.jsp";
		}else{
			
			return "view/member/findpw.jsp";
		}
		
		
	}
	
}
