package com.npnc.member.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MDao {	//회원 관련 DAO
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int result;
	
	DataSource dataSource = null;
	
	public MDao() {
		InitialContext iCTX = null;
		try {
			iCTX = new InitialContext();
			dataSource = (DataSource) iCTX.lookup("java:comp/env/jdbc/dbcp");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getConnection(){
		try {
			conn = dataSource.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
