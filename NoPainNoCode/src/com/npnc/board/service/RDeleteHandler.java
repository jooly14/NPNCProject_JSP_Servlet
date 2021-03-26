package com.npnc.board.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.dao.BDao;

public class RDeleteHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
		BDao bdao = new BDao();
		
		int ridx = Integer.parseInt(request.getParameter("ridx"));
		int bidx = Integer.parseInt(request.getParameter("bidx"));
		
		bdao.delReply(ridx);
		
		return "board?cmd=bread&idx="+bidx;
	}

}
