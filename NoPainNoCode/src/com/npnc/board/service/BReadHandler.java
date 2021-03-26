package com.npnc.board.service;

import java.sql.Timestamp;
import java.util.Iterator;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.dao.BDao;
import com.npnc.board.dto.BDto;
import com.npnc.board.dto.RDto;
import com.npnc.category.dao.CDao;
import com.npnc.category.dto.CDto;

public class BReadHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		
		
		int idx = Integer.parseInt(request.getParameter("idx")); // 게시글 idx
		
		BDao bdao = new BDao();
		Vector<BDto> bdto = bdao.getArticle(idx);
		
		CDao cdao = new CDao();
		Vector<CDto> cdto = bdao.getBoardTitle(idx);
		
		//카테고리 dto
		String categoryName = cdto.get(0).getName();
		int category = cdto.get(0).getIdx();
		
		//게시글 dto
		String title = bdto.get(0).getTitle();
		String id = bdto.get(0).getId();
		Timestamp regDate = bdto.get(0).getRegdate();
		String content = bdto.get(0).getContent();
		
		int hit = bdto.get(0).getHit();
		int good = bdto.get(0).getGood();
		int bad = bdto.get(0).getBad();
		
		//댓글 dto
		Vector<RDto> rdto = bdao.getReply(idx);
		
		
		request.setAttribute("rdto", rdto);
		request.setAttribute("idx", idx);
		request.setAttribute("categoryName", categoryName);
		request.setAttribute("category", category);
		request.setAttribute("title", title);
		request.setAttribute("id", id);
		request.setAttribute("regDate", regDate);
		request.setAttribute("content", content);
		request.setAttribute("hit", hit);
		request.setAttribute("good", good);
		request.setAttribute("bad", bad);
		
		return "view/board/bread.jsp";
	}

}
