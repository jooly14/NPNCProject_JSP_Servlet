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
		String chkId =dao.getManagerCnt();			//�����ڰ� 1�� �ۿ� ���ٸ� �ش� �������� ���̵� �޾ƿ�
		if(chkId.equals(id)){						//1�� �ۿ� �� ���� �������� ȸ������� �����ϰ��� �ϴ� ��� ���� ���
			json.put("sign", "no");
		}else{
			int result = dao.chgMemGrade(id, Integer.parseInt(grade));
			json.put("sign", "yes");
		}
		return json;
	}

}
