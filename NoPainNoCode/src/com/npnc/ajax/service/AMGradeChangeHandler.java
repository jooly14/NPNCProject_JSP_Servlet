package com.npnc.ajax.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.npnc.manage.dao.MgrDao;

public class AMGradeChangeHandler implements ACommandHandler {

	@Override
	public JSONObject process(HttpServletRequest request, HttpServletResponse response) {
		JSONObject json = new JSONObject();
		MgrDao dao = new MgrDao();
		String id = request.getParameter("id");
		String grade = request.getParameter("grade");
		dao.chgMemGrade(id, Integer.parseInt(grade));
		return json;
	}

}
