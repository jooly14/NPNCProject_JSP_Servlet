package com.npnc.board.dao;

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

public class BDao {	//게시글 관련 DAO
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int result;
	
	DataSource dataSource = null;
	
	//게시판 리스트 가져오기
	public Vector<BDto> getList(BListHandler handler,String type,String keyword,String category2, int page, int pagesize){
		//gob테이블과 left outer join으로 좋아요 개수를 가져오고 reply테이블과 left outer join으로 댓글 개수를 같이 가져옴
		String sql = "select SQL_CALC_FOUND_ROWS b.*, good.cnt AS good, reply.repcnt AS repcnt FROM board as b LEFT outer join (SELECT idx,gob,COUNT(id) AS cnt FROM gob GROUP BY idx, gob HAVING gob = true) AS good ON b.idx = good.idx left outer join (SELECT bidx, COUNT(bidx) AS repcnt FROM reply GROUP BY bidx) AS reply ON b.idx = reply.bidx";
		if(category2!=null&&!category2.isEmpty()){	//카테고리를 따로 정하지 않으면 전체 게시글을 가져오도록 
			sql = sql + " where category = " + category2;
			if(type!=null&&!type.isEmpty()){		//검색
				sql= sql + " and "+type+" like '%" +keyword+"%'" ;
			}
		}else{
			if(type!=null&&!type.isEmpty()){		//검색
				sql= sql + " where "+type+" like '%" +keyword+"%'" ;
			}
		}
		sql = sql + " order by idx desc limit ?,?";
		Vector<BDto> dtos = new Vector<>();
		getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (page-1)*pagesize);
			pstmt.setInt(2, pagesize);
			rs = pstmt.executeQuery();
			while(rs.next()){
				int idx = rs.getInt(1);
				String title = rs.getString(2);
				String id = rs.getString(3);
				String content = rs.getString(4);
				Timestamp regDate = rs.getTimestamp(5);
				int hit = rs.getInt(6);
				String file = rs.getString(7);
				int category = rs.getInt(8);
				int good = rs.getInt(9);
				int replyCnt = rs.getInt(10);
				BDto dto = new BDto(idx, title, id, content, regDate, hit, file, category, good, 0, null, replyCnt);
				dtos.add(dto);
			}
			getTotalCnt(handler);	//전체 게시글 개수
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return dtos;
	}
	
	//전체 게시글 개수를 가져오기
	public void getTotalCnt(BListHandler handler){
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		String sql2 = "SELECT FOUND_ROWS()";	
		try {
			pstmt2 = conn.prepareStatement(sql2);
			rs2 = pstmt2.executeQuery();
			if(rs2.next()){
				handler.setTotalCnt(rs2.getInt(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs2!=null) rs2.close();
				if(pstmt2!=null) pstmt2.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public BDao() {
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
