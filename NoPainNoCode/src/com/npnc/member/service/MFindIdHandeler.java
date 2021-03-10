package com.npnc.member.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.npnc.board.service.CommandHandler;
import com.npnc.member.dao.MDao;

public class MFindIdHandeler implements CommandHandler{
   // 이름,메일주소,주민등록번호/이름,전화번호,주민등록번호  두가지 경우를 한번에 처리하기 위해 4가지를 다 가져와서 넘겨준 후 dao에서 null인가 판별 후 select 하여 id를 String형으로 받아서 처리한다.
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