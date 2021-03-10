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
		String chkId =dao.getManagerCnt();			//관리자가 1명 밖에 없다면 해당 관리자의 아이디를 받아옴
		if(chkId.equals(id)){						//1명 밖에 안 남은 관리자의 회원등급을 변경하고자 하는 경우 변경 취소
			json.put("sign", "no");
		}else{
			int result = dao.chgMemGrade(id, Integer.parseInt(grade));
			json.put("sign", "yes");
		}
		return json;
	}

}
