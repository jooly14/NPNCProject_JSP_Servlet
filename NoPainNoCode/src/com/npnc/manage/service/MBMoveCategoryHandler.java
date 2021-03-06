package com.npnc.manage.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.manage.dao.MgrDao;

public class MBMoveCategoryHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		MgrDao dao = new MgrDao();
		String idx = request.getParameter("idx");
		String category = request.getParameter("category");
		
		int result = dao.moveCategory(Integer.parseInt(idx), Integer.parseInt(category));
		return "/view/manage/move_complete.jsp";
	}

}
