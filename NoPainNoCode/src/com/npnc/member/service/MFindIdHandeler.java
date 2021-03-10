package com.npnc.member.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.member.dao.MDao;

public class MFindIdHandeler implements CommandHandler{
   // �̸�,�����ּ�,�ֹε�Ϲ�ȣ/�̸�,��ȭ��ȣ,�ֹε�Ϲ�ȣ  �ΰ��� ��츦 �ѹ��� ó���ϱ� ���� 4������ �� �����ͼ� �Ѱ��� �� dao���� null�ΰ� �Ǻ� �� select �Ͽ� id�� String������ �޾Ƽ� ó���Ѵ�.
   @Override
   public String process(HttpServletRequest request, HttpServletResponse response) {
      MDao dao=new MDao();
      String name=request.getParameter("name");
      String phonenum=request.getParameter("phonenum");
      String email=request.getParameter("email");
      String idnum=request.getParameter("idnum");

      String id=dao.findId(name,phonenum,email,idnum);
      
      request.setAttribute("id",id);
      return "view/member/tryfind.jsp";
   }
}