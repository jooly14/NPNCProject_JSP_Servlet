package com.npnc.manage.service;

import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.category.dto.CDto;
import com.npnc.manage.dao.MgrDao;

public class MCListCntHandler implements CommandHandler {
	private Map<Integer, Integer> cntMap;
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		MgrDao dao = new MgrDao();
		Map<String, Vector<CDto>> map = dao.getCategoryList(this);
		request.setAttribute("clist", map);
		request.setAttribute("cnt", cntMap);
		return "/view/manage/clist.jsp";
	}
	public void setCntMap(Map<Integer, Integer> cntMap) {
		this.cntMap = cntMap;
	}
}
