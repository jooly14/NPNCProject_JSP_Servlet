package com.npnc.board.service;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.dao.BDao;
import com.npnc.board.dto.BDto;

public class BListHandler implements CommandHandler {
	private int totalCnt;
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		//여기서 dao메서드 호출
		String type = request.getParameter("type");
		String keyword = request.getParameter("keyword");
		String category = request.getParameter("category");
		String page = request.getParameter("page");
		String pagesize = request.getParameter("psize");
		if(page==null){
			page = "1";
		}
		if(pagesize==null){
			pagesize="20";
		}
		int ipage = Integer.parseInt(page);
		int ipagesize = Integer.parseInt(pagesize);
		BDao dao = new BDao();
		Vector<BDto> dtos = dao.getList(this,type,keyword,category,ipage,ipagesize);
		request.setAttribute("dtos", dtos);
		request.setAttribute("page", ipage);
		int totalpage = totalCnt/ipagesize;
		if(totalCnt%ipagesize!=0){
			totalpage++;
		}
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("pagesize", ipagesize);
		request.setAttribute("type", type);
		request.setAttribute("keyword", keyword);
		request.setAttribute("category", category);
		return "view/board/blist.jsp";
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
}
