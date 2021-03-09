package com.npnc.manage.service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.manage.dao.MgrDao;

public class MCDeleteMainHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		MgrDao dao = new MgrDao();
		String maincategory = "";
		try {
			maincategory = URLDecoder.decode(request.getParameter("name"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int result = dao.deleteMainCategory(maincategory);
		return "manage?cmd=clist";
	}

}
