package com.npnc.category.service;

import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.category.dao.CDao;
import com.npnc.category.dto.CDto;

public class CListHandler implements CommandHandler {	//��� �������� ī�װ��� �����ϱ� ���� handler

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		CDao dao = new CDao();
		Map<String, Vector<CDto>> map = dao.getCategoryList();	//maincategory�ʵ� ���� Ű ������ category���̺� ���� ���� �ִ� CDto����Ʈ�� ������ �ִ� hashmap
		request.setAttribute("clist", map);						//(���� maincategory�� ���� ī�װ� ������ �ϳ��� Ű�� ��Ƴ���)
		return "";
	}

}
