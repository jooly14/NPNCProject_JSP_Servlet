package com.npnc.ajax.service;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.npnc.ajax.dao.ADao;
import com.npnc.board.dao.BDao;
import com.npnc.board.dto.BDto;

public class ABListHandler implements ACommandHandler {
	@Override
	public JSONObject process(HttpServletRequest request, HttpServletResponse response) {
		JSONObject json = new JSONObject();
		ADao dao = new ADao();
		int pagesize = 5;
		int startRownum = 0;
		int rownum = -1;
		String category = request.getParameter("category");
		if(request.getParameter("startRownum")==null){
			String idx_ = request.getParameter("idx");
			if(idx_==null){
				idx_ = "3";
			}
			int idx = Integer.parseInt(idx_);
			rownum = dao.getRowCnt(idx, category);
			startRownum = (rownum/5)*5;
			if(rownum%5==0){ 
				startRownum = (rownum/5-1)*5;
			}
		}else{
			startRownum = Integer.parseInt(request.getParameter("startRownum"));
		}
		Vector<BDto> dtos = dao.getList(startRownum,pagesize,category);
		int curpage = startRownum/5+1;
		int totalcnt = dao.getTotalCnt(category);
		int totalpage = totalcnt/pagesize;		//전체 게시글 개수/한 페이지 당 게시글 개수 = 전체 페이지 개수
		if(totalcnt%pagesize!=0){				//나머지가 있는 경우에는 한 페이지 더 필요
			totalpage++;
		}
		int pagelistsize = 5;					//페이지리스트(게시글리스트 하단에 있는 페이지링크를 의미) 한번에 보여지는 페이지 개수(총페이지 개수가 이를 초과하면 다음버튼이 생성됨)
		int start = (curpage/pagelistsize)*pagelistsize+1;	//페이지리스트에 시작하는 숫자
		if(curpage%pagelistsize==0){
			start = (curpage/pagelistsize-1)*pagelistsize+1;
		}
		json.put("pagesize", pagesize);
		json.put("rownum", rownum);
		json.put("startRownum", startRownum);
		json.put("dtos", new Gson().toJson(dtos));
		json.put("curpage", curpage);
		json.put("totalpage", totalpage);
		json.put("start", start);
		json.put("end", start+pagelistsize-1);
		return json;
	}

}
