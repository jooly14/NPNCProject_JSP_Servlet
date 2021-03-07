package com.npnc.category.service;

import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.category.dao.CDao;
import com.npnc.category.dto.CDto;

public class CListHandler implements CommandHandler {	//모든 페이지에 카테고리를 제공하기 위한 handler

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		CDao dao = new CDao();
		Map<String, Vector<CDto>> map = dao.getCategoryList();	//maincategory필드 값을 키 값으로 category테이블 값을 갖고 있는 CDto리스트를 가지고 있는 hashmap
		request.setAttribute("clist", map);						//(같은 maincategory를 갖는 카테고리 값들을 하나의 키에 모아놓음)
		return "";
	}

}
