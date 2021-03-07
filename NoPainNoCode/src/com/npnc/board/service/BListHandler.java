package com.npnc.board.service;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.dao.BDao;
import com.npnc.board.dto.BDto;

public class BListHandler implements CommandHandler {
	private int totalCnt;	//전체 게시글 개수
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
		request.setAttribute("dtos", dtos);		//board테이블의 데이터
		request.setAttribute("page", ipage);	//현재 페이지
		int totalpage = totalCnt/ipagesize;		//전체 게시글 개수/한 페이지 당 게시글 개수 = 전체 페이지 개수
		if(totalCnt%ipagesize!=0){				//나머지가 있는 경우에는 한 페이지 더 필요
			totalpage++;
		}
		int pagelistsize = 10;					//페이지리스트(게시글리스트 하단에 있는 페이지링크를 의미) 한번에 보여지는 페이지 개수(총페이지 개수가 이를 초과하면 다음버튼이 생성됨)
		int start = (ipage/pagelistsize)*pagelistsize+1;	//페이지리스트에 시작하는 숫자
		if(ipage%pagelistsize==0){
			start = (ipage/pagelistsize-1)*pagelistsize+1;
		}
		request.setAttribute("totalpage", totalpage);	//전체 페이지 개수
		request.setAttribute("pagesize", ipagesize);	//한페이지 당 게시글 개수
		request.setAttribute("start", start);			//페이지리스트에 시작하는 숫자
		request.setAttribute("end", start+pagelistsize-1);//페이지리스트에 끝나는 숫자
		request.setAttribute("type", type);				//검색할때 카테고리(제목,내용,아이디)
		request.setAttribute("keyword", keyword);		//검색어
		request.setAttribute("category", category);		//현재 선택 중인 카테고리(ex.수도권-강남 카테고리의 인덱스)
		

		return "view/board/blist.jsp";
	}
	public void setTotalCnt(int totalCnt) {				//getList()메서드에서 두개를 반환할 수 없어서 따로 setter를 준비(메서드 내부에서 호출해서 totalcnt값을 전달)
		this.totalCnt = totalCnt;
	}
}
