package com.npnc.manage.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.manage.dao.MgrDao;

public class MGradeHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		MgrDao dao = new MgrDao();
		HashMap<Integer, String> map = dao.getGradeList();
		request.setAttribute("grades", map);
		return "";
	}

}
