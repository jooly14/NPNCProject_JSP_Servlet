package com.npnc.manage.service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.manage.dao.MgrDao;

public class MCDeleteCategoryHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		MgrDao dao = new MgrDao();
		String idx = request.getParameter("idx");
		int result = dao.deleteCategory(Integer.parseInt(idx));
		return "manage?cmd=clist";
	}

}
