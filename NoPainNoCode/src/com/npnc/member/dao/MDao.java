package com.npnc.member.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.npnc.member.dto.MDto;

public class MDao {   //ȸ�� ���� DAO
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   int result;
   
   DataSource dataSource = null;

   public int changePw(String pw,String id) {
         try {
            getConnection();
            String query="update member set pw= ? where id=?";
            pstmt=conn.prepareStatement(query);
            pstmt.setString(1, pw);
            pstmt.setString(2, id);
            
            result=pstmt.executeUpdate();
            
         } catch (SQLException e) {
            e.printStackTrace();
         }finally {
            freeConnection();
         }
         return result;
      }
      
      public int findPw(String id,String idnum,String phonenum) {
         String pw = null;
         try {
            getConnection();
            String query="select count(*) from member where id = ? and idnum=? and phonenum=?";
            pstmt=conn.prepareStatement(query);
            pstmt.setString(1, id);
            pstmt.setString(2,idnum);
            pstmt.setString(3,phonenum);
            rs=pstmt.executeQuery();
            if(rs.next()){
               result = rs.getInt(1);//0 �Ǵ� 1
            }
         } catch (SQLException e) {
            e.printStackTrace();
         }finally {
            freeConnection();
         }
         return result;
      }
   
   public String findId(String name,String phonenum,String email,String idnum) {
      String id=null;
      try {
         getConnection();
         String query="";
         if(email==null) {   // phonenum�� �Ѿ�� ���
            query="select * from member where name=? and idnum=? and phonenum=?";
         }else {            // email�� �Ѿ�� ���
            query="select * from member where name=? and idnum=? and email=?";
         }
         pstmt=conn.prepareStatement(query);
         pstmt.setString(1,name);
         pstmt.setString(2,idnum);
         if(email==null) {   // phonenum�� �Ѿ�� ���
            pstmt.setString(3,phonenum);
         }else {            // email�� �Ѿ�� ���
            pstmt.setString(3,email);
         }
         rs=pstmt.executeQuery();
         while(rs.next()) {
            id=rs.getString(1);   //���� ������ String�� id�� ��ȯ, ������ null�� ��ȯ
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {
         freeConnection();
      }
      return id;
   }
   
   public MDto loginMember(String id,String pw) {
      MDto dto=new MDto();
      try {
         getConnection();
         String query="select * from member where id=? and pw=?";
         pstmt=conn.prepareStatement(query);
         pstmt.setString(1, id);
         pstmt.setString(2, pw);
         rs=pstmt.executeQuery();
         while(rs.next()) {
            dto.setId(rs.getString(1));
            dto.setPw(rs.getString(2));
            dto.setGrade(rs.getInt(8));
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {
         freeConnection();
      }
      return dto;
   }
   
   public int legMember(String id,String pw,String name,String idnum,String email,String address,String phonenum) { // DB�� ���� 1 ��ȯ, �ȵ��� 0 ��ȯ
      try {
         getConnection();
         String query="insert into member values(?,?,?,?,?,?,?,4)";
         pstmt=conn.prepareStatement(query);
         
         pstmt.setString(1, id);
         pstmt.setString(2, pw);
         pstmt.setString(3, name);
         pstmt.setString(4, idnum);
         pstmt.setString(5, email);
         pstmt.setString(6, address);
         pstmt.setString(7, phonenum);
         
         result=pstmt.executeUpdate();
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {
         freeConnection();
      }
      return result;
   }
   
   public MDao() {
      InitialContext iCTX = null;
      try {
         iCTX = new InitialContext();
         dataSource = (DataSource) iCTX.lookup("java:comp/env/jdbc/dbcp");
      } catch (NamingException e) {
         e.printStackTrace();
      }
   }
   
   public void getConnection(){
      try {
         conn = dataSource.getConnection();
      } catch (SQLException e) {
         e.printStackTrace();
      }
   }
   
   public void freeConnection(){
      try{
         if(rs!=null) rs.close();
         if(pstmt!=null) pstmt.close();
         if(conn!=null) conn.close();
      }catch(SQLException e){
         e.printStackTrace();
      }
   }
}