package com.npnc.board.service;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.dao.BDao;
import com.npnc.board.dto.BDto;

public class BListHandler implements CommandHandler {
	private int totalCnt;	//��ü �Խñ� ����
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		//���⼭ dao�޼��� ȣ��
		String type = request.getParameter("type");
		String keyword = request.getParameter("keyword");
		String category = request.getParameter("category");
		String page = request.getParameter("page");
		String pagesize = request.getParameter("psize");
		if(page==null){
			page = "1";
		}
		if(pagesize==null){
			pagesize="20";
		}
		int ipage = Integer.parseInt(page);
		int ipagesize = Integer.parseInt(pagesize);
		BDao dao = new BDao();
		Vector<BDto> dtos = dao.getList(this,type,keyword,category,ipage,ipagesize);
		request.setAttribute("dtos", dtos);		//board���̺��� ������
		request.setAttribute("page", ipage);	//���� ������
		int totalpage = totalCnt/ipagesize;		//��ü �Խñ� ����/�� ������ �� �Խñ� ���� = ��ü ������ ����
		if(totalCnt%ipagesize!=0){				//�������� �ִ� ��쿡�� �� ������ �� �ʿ�
			totalpage++;
		}
		int pagelistsize = 10;					//����������Ʈ(�Խñ۸���Ʈ �ϴܿ� �ִ� ��������ũ�� �ǹ�) �ѹ��� �������� ������ ����(�������� ������ �̸� �ʰ��ϸ� ������ư�� ������)
		int start = (ipage/pagelistsize)*pagelistsize+1;	//����������Ʈ�� �����ϴ� ����
		if(ipage%pagelistsize==0){
			start = (ipage/pagelistsize-1)*pagelistsize+1;
		}
		request.setAttribute("totalpage", totalpage);	//��ü ������ ����
		request.setAttribute("pagesize", ipagesize);	//�������� �� �Խñ� ����
		request.setAttribute("start", start);			//����������Ʈ�� �����ϴ� ����
		request.setAttribute("end", start+pagelistsize-1);//����������Ʈ�� ������ ����
		request.setAttribute("type", type);				//�˻��Ҷ� ī�װ�(����,����,���̵�)
		request.setAttribute("keyword", keyword);		//�˻���
		request.setAttribute("category", category);		//���� ���� ���� ī�װ�(ex.������-���� ī�װ��� �ε���)
		

		return "view/board/blist.jsp";
	}
	public void setTotalCnt(int totalCnt) {				//getList()�޼��忡�� �ΰ��� ��ȯ�� �� ��� ���� setter�� �غ�(�޼��� ���ο��� ȣ���ؼ� totalcnt���� ����)
		this.totalCnt = totalCnt;
	}
}
