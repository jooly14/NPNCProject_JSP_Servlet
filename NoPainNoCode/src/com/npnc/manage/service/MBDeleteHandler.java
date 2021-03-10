package com.npnc.manage.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.manage.dao.MgrDao;

public class MBDeleteHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		MgrDao dao = new MgrDao();
		String[] del_idxArr = request.getParameterValues("del_idx");
		String type = request.getParameter("type");
		String keyword = request.getParameter("keyword");
		String psize = request.getParameter("psize");
		String category = request.getParameter("category");
		String del_idxs ="";
//		�ϰ� �����̹Ƿ� �޾ƿ� �������� �� ��ȣ ���� �����ؼ� dao�� ����
		for(int i=0;i<del_idxArr.length;i++){
			if(i==0){
				del_idxs = del_idxArr[i];
			}
			del_idxs += ","+del_idxArr[i];
		}
		int result = dao.onepassDelete(del_idxs);
		String sendUrl = "manage?cmd=blist";
		if(type!=null&&!type.isEmpty()){
			sendUrl += "&type="+type;
		}
		if(keyword!=null&&!keyword.isEmpty()){
			sendUrl += "&keyword="+keyword;
		}
		if(psize!=null&&!psize.isEmpty()){
			sendUrl += "&psize="+psize;
		}
		if(category!=null&&!category.isEmpty()){
			sendUrl += "&category="+category;
		}
		return sendUrl;
	}

}
