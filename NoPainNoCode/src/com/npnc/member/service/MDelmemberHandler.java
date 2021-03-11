package com.npnc.member.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.member.dao.MDao;

public class MDelmemberHandler implements CommandHandler{
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		//�� �޾ƿ���
		String id=(String)request.getSession().getAttribute("id");
		
		MDao dao=new MDao();
		// ���� �޾ƿͼ� ������Ʈ�ϱ�
		int result=dao.delmember(id);
		request.setAttribute("result", result);
		request.getSession().invalidate();
		return "board";
	}
}
