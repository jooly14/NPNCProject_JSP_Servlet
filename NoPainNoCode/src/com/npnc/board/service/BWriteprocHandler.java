package com.npnc.board.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.dao.BDao;


public class BWriteprocHandler implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		BDao dao = new BDao();
		
		
		String category = request.getParameter("category");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
//		String file = request.getParameter("file");
//		System.out.println(category+title); //testcode
		int result = dao.insert(category, title, content);
		
		
		request.setAttribute("category", category);
		request.setAttribute("title", title);
		request.setAttribute("content", content);
//		request.setAttribute("file", file);
//		view/board/bwriteproc.jsp
		
		return "";
	}

}
