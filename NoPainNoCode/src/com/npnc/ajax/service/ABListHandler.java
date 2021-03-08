package com.npnc.ajax.service;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.npnc.ajax.dao.ADao;
import com.npnc.board.dao.BDao;
import com.npnc.board.dto.BDto;

public class ABListHandler implements ACommandHandler {	//�Խñ� ��ȸ �ؿ� �Խñ۸���Ʈ�� �����ֱ� ���� ���
	@Override
	public JSONObject process(HttpServletRequest request, HttpServletResponse response) {
		JSONObject json = new JSONObject();				//json����
		ADao dao = new ADao();
		int pagesize = 5;								//�� �������� ������ �Խñ� ����
		int startRownum = 0;							//rownum�� Ư�� �Խñ��� ��ü �Խñ� �� ���° �Խñ������� �ǹ�(�ε����� ������ �Ͼ �� ��ȣ�� ����� ��Ȯ�� ��ġ�� �˼� ���� ������) 
		int rownum = -1;
		String category = request.getParameter("category");	//category�� null�̸� ��ü �Խñ� ��ȸ
		if(request.getParameter("startRownum")==null){		//���� ó�� ������ �ε��� ��ȸ �Ҷ�
			String idx_ = request.getParameter("idx");
			if(idx_==null){									//������ idx�� �־�ߵ�(�Խñ� ��ȸ �Ҷ� Ư�� ���� �а� �ǹǷ�)
				idx_ = "3";									//����� ���ľߵ�
			}
			int idx = Integer.parseInt(idx_);
			rownum = dao.getRowCnt(idx, category);			//�ش� idx�� �Խñ��� ���°�� �ִ� �Խñ����� �˾Ƴ���(�Խñ��� �ִ� ��ġ�� ����Ʈ�� �����ֱ� ���ؼ� �ʿ�)
			startRownum = (rownum/5)*5;						//�Խñ��� rownum 1~5,6~10,11~15 �̷������� �����ֱ� ���ؼ� startrownum ���
			if(rownum%5==0){ 
				startRownum = (rownum/5-1)*5;
			}
		}else{
			startRownum = Integer.parseInt(request.getParameter("startRownum"));	//����Ʈ �ϴܿ� ����¡�� �����ϸ� startrownum�� �Ķ���ͷ� �޾Ƽ� ���(�Խñ��� idx�� �ʿ����)
		}
		Vector<BDto> dtos = dao.getList(startRownum,pagesize,category);				//�� ��� ��������
		int curpage = startRownum/5+1;												//����������(����¡  ���ؼ�)
		int totalcnt = dao.getTotalCnt(category);									//��ü������
		int totalpage = totalcnt/pagesize;		//��ü �Խñ� ����/�� ������ �� �Խñ� ���� = ��ü ������ ����
		if(totalcnt%pagesize!=0){				//�������� �ִ� ��쿡�� �� ������ �� �ʿ�
			totalpage++;
		}
		int pagelistsize = 5;					//����¡:����������Ʈ(�Խñ۸���Ʈ �ϴܿ� �ִ� ��������ũ�� �ǹ�) �ѹ��� �������� ������ ����(�������� ������ �̸� �ʰ��ϸ� ������ư�� ������)
		int start = (curpage/pagelistsize)*pagelistsize+1;	//����������Ʈ�� �����ϴ� ����
		if(curpage%pagelistsize==0){
			start = (curpage/pagelistsize-1)*pagelistsize+1;
		}
		json.put("pagesize", pagesize);
		json.put("rownum", rownum);
		json.put("startRownum", startRownum);
		json.put("dtos", new Gson().toJson(dtos));	//��ü�� json��ü�� �������ִ� Gson - jar�� ���� �߰�����
		json.put("curpage", curpage);
		json.put("totalpage", totalpage);
		json.put("start", start);
		json.put("end", start+pagelistsize-1);
		return json;
	}

}
