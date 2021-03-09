package com.npnc.manage.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.manage.dao.MgrDao;
import com.npnc.member.dao.MDao;

public class MCMoveCategoryHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		MgrDao dao = new MgrDao();
		String oldCategory = request.getParameter("idx");
		String newCategory = request.getParameter("category");
		int result = dao.moveAllCategory(Integer.parseInt(oldCategory),Integer.parseInt(newCategory));
		return "/view/manage/move_complete.jsp";
	}

}
