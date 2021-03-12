package com.npnc.board.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.dao.BDao;

public class BDeleteHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		BDao bdao = new BDao();
		
		int result = bdao.deleteArticle(idx);
		
		request.setAttribute("delete", true);
		
		return "view/board/bdelete.jsp";
	}

}
