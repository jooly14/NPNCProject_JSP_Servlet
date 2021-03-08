package com.npnc.manage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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
import com.npnc.manage.service.CListCntHandler;

public class MDao {	//게시글 관련 DAO
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int result;
	
	DataSource dataSource = null;
	public Map<String, Vector<CDto>> getCategoryList(CListCntHandler handler) {
		Map<String, Vector<CDto>> map = new HashMap<String, Vector<CDto>>();
		Map<Integer, Integer> cntMap = new HashMap<>();
		String sql = "SELECT c.*, t.cnt FROM category AS c left outer JOIN (SELECT category,COUNT(*) AS cnt FROM board GROUP BY category) AS t ON c.idx=t.category ORDER BY maincategory";
		getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				int idx = rs.getInt(1);
				String maincategory = rs.getString(2);
				String name = rs.getString(3);
				int readgrade = rs.getInt(4);	//읽기 권한
				int writegrade = rs.getInt(5);	//쓰기 권한
				int contentCnt = rs.getInt(6);
				CDto dto = new CDto(idx, name, readgrade, writegrade);
				if(map.containsKey(maincategory)){
					map.get(maincategory).add(dto);
				}else{
					Vector<CDto> dtos = new Vector<>();
					dtos.add(dto);
					map.put(maincategory, dtos);
				}
				cntMap.put(idx, contentCnt);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		handler.setCntMap(cntMap);
		return map;
	}
	public int onepassDelete(String del_idxs) {
		getConnection();
		String sql = "delete from board where idx in("+del_idxs+")";
		try {
			pstmt = conn.prepareStatement(sql);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return result;
	}
	public int moveCategory(int idx, int category) {
		getConnection();
		String sql = "update board set category = ? where idx = ? ";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, category);
			pstmt.setInt(2, idx);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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
