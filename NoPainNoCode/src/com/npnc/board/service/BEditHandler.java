package com.npnc.board.service;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.dao.BDao;
import com.npnc.board.dto.BDto;
import com.npnc.category.dao.CDao;
import com.npnc.category.dto.CDto;

public class BEditHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		BDao bdao = new BDao();
		Vector<BDto> bdto = bdao.getArticle(idx);
		
		CDao cdao = new CDao();
		Vector<CDto> cdto = bdao.getBoardTitle(idx);
		
		
		request.setAttribute("categoryIdx", cdto.get(0).getIdx());
		request.setAttribute("title", bdto.get(0).getTitle());
		request.setAttribute("id", bdto.get(0).getId());
		request.setAttribute("idx", idx);
		request.setAttribute("content", bdto.get(0).getContent());
		
		return "view/board/bedit.jsp";
	}

}
