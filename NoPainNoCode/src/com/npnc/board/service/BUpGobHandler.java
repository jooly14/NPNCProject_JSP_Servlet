package com.npnc.board.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.dao.BDao;

public class BUpGobHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		
		
		
		
		
		BDao bdao = new BDao();
		
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		String id = request.getParameter("id");
		boolean gob = Boolean.parseBoolean(request.getParameter("gob"));
		
		int result = bdao.upGob(idx, id, gob);
		
		request.setAttribute("gobResult", result);
		
		
		return "board?cmd=bread&idx="+idx;
	}

}
