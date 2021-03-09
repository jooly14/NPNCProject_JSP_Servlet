package com.npnc.manage.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.category.dto.CDto;
import com.npnc.manage.dao.MgrDao;

public class MCAddCategoryHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		MgrDao dao = new MgrDao();
		String name = request.getParameter("name");
		String readgrade = request.getParameter("readgrade");
		String writegrade = request.getParameter("writegrade");
		String maincategory = request.getParameter("maincategory");
		CDto dto = new CDto(0, name, Integer.parseInt(readgrade), Integer.parseInt(writegrade));
		dao.addCategory(dto,maincategory);
		return "manage?cmd=clist";
	}

}
