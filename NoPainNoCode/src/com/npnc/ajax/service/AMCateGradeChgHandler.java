package com.npnc.ajax.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.npnc.manage.dao.MgrDao;

public class AMCateGradeChgHandler implements ACommandHandler {

	@Override
	public JSONObject process(HttpServletRequest request, HttpServletResponse response) {
		JSONObject json = new JSONObject();
		MgrDao dao = new MgrDao();
		String idx = request.getParameter("idx");
		String rw = request.getParameter("rw");			//값에 따라서 읽기권한이나 쓰기권한을 변경
		String grade = request.getParameter("grade");
		if(rw.equals("r")){
			rw = "readgrade";
		}else{
			rw = "writegrade";
		}
		int result = dao.cateGradeChg(Integer.parseInt(idx),rw,Integer.parseInt(grade));
		return json;
	}

}
