package com.npnc.ajax.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.npnc.board.dto.BDto;
import com.npnc.board.service.BListHandler;
import com.npnc.board.service.CommandHandler;
import com.npnc.category.dto.CDto;

public class ADao {	//게시글 관련 DAO
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int result;
	
	DataSource dataSource = null;
	
	//현재 게시글이 몇번째 게시글인지 가져오기
	public int getRowCnt(int idx, String category) {
		getConnection();
		String sql = "SELECT rownum FROM (SELECT @rownum :=@rownum+1 AS rownum , b.idx FROM (SELECT @rownum:=0) AS r, board AS b"+
					(category==null?"":" WHERE b.category = "+category)+" ORDER BY idx DESC) AS tmp WHERE tmp.idx = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return result;
	}
	
	public Vector<BDto> getList(int startRownum,int pagesize,String category) {
		Vector<BDto> dtos = new Vector<>();
		getConnection();
		String sql = "SELECT * FROM (SELECT @rownum :=@rownum+1 AS rownum , b.* FROM (SELECT @rownum:=0) AS r, board AS b"
				+(category==null?"":" WHERE b.category = "+category)+ " ORDER BY idx DESC) AS tmp WHERE tmp.rownum <= ? AND tmp.rownum >?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRownum+pagesize);
			pstmt.setInt(2, startRownum);
			rs = pstmt.executeQuery();
			while(rs.next()){
				int idx = rs.getInt(2);
				String title = rs.getString(3);
				String id = rs.getString(4);
				Timestamp regDate = rs.getTimestamp(6);
				BDto dto = new BDto(idx, title, id, null, regDate, 0, category, 0, 0, 0, null, 0);
				dtos.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return dtos;
	}
	
	//전체 게시글 개수를 가져오기
	public int getTotalCnt(String category){
		getConnection();
		String sql = "SELECT max(@rownum :=@rownum+1) AS totalcnt FROM (SELECT @rownum:=0) AS r, board AS b "+(category==null?"":"WHERE b.category = "+category);
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return result;
	}
	
	public ADao() {
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
