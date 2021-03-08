package com.npnc.ajax.service;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.npnc.ajax.dao.ADao;
import com.npnc.board.dao.BDao;
import com.npnc.board.dto.BDto;

public class ABListHandler implements ACommandHandler {	//게시글 조회 밑에 게시글리스트를 보여주기 위한 기능
	@Override
	public JSONObject process(HttpServletRequest request, HttpServletResponse response) {
		JSONObject json = new JSONObject();				//json생성
		ADao dao = new ADao();
		int pagesize = 5;								//한 페이지당 보여줄 게시글 개수
		int startRownum = 0;							//rownum은 특정 게시글이 전체 게시글 중 몇번째 게시글인지를 의미(인덱스는 삭제가 일어나 빈 번호가 생기면 정확히 위치를 알수 없기 때문에) 
		int rownum = -1;
		String category = request.getParameter("category");	//category가 null이면 전체 게시글 조회
		if(request.getParameter("startRownum")==null){		//제일 처음 페이지 로딩시 조회 할때
			String idx_ = request.getParameter("idx");
			if(idx_==null){									//무조건 idx가 있어야됨(게시글 조회 할때 특정 글을 읽게 되므로)
				idx_ = "3";									//여기는 고쳐야됨
			}
			int idx = Integer.parseInt(idx_);
			rownum = dao.getRowCnt(idx, category);			//해당 idx의 게시글이 몇번째에 있는 게시글인지 알아내기(게시글이 있는 위치의 리스트를 보여주기 위해서 필요)
			startRownum = (rownum/5)*5;						//게시글을 rownum 1~5,6~10,11~15 이런식으로 보여주기 위해서 startrownum 사용
			if(rownum%5==0){ 
				startRownum = (rownum/5-1)*5;
			}
		}else{
			startRownum = Integer.parseInt(request.getParameter("startRownum"));	//리스트 하단에 페이징을 선택하면 startrownum을 파라미터로 받아서 사용(게시글의 idx는 필요없음)
		}
		Vector<BDto> dtos = dao.getList(startRownum,pagesize,category);				//글 목록 가져오기
		int curpage = startRownum/5+1;												//현재페이지(페이징  위해서)
		int totalcnt = dao.getTotalCnt(category);									//전체페이지
		int totalpage = totalcnt/pagesize;		//전체 게시글 개수/한 페이지 당 게시글 개수 = 전체 페이지 개수
		if(totalcnt%pagesize!=0){				//나머지가 있는 경우에는 한 페이지 더 필요
			totalpage++;
		}
		int pagelistsize = 5;					//페이징:페이지리스트(게시글리스트 하단에 있는 페이지링크를 의미) 한번에 보여지는 페이지 개수(총페이지 개수가 이를 초과하면 다음버튼이 생성됨)
		int start = (curpage/pagelistsize)*pagelistsize+1;	//페이지리스트에 시작하는 숫자
		if(curpage%pagelistsize==0){
			start = (curpage/pagelistsize-1)*pagelistsize+1;
		}
		json.put("pagesize", pagesize);
		json.put("rownum", rownum);
		json.put("startRownum", startRownum);
		json.put("dtos", new Gson().toJson(dtos));	//객체를 json객체로 변경해주는 Gson - jar를 따로 추가했음
		json.put("curpage", curpage);
		json.put("totalpage", totalpage);
		json.put("start", start);
		json.put("end", start+pagelistsize-1);
		return json;
	}

}
