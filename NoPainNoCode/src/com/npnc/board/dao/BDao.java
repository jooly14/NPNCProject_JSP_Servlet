package com.npnc.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Vector;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.npnc.board.dto.BDto;
import com.npnc.board.dto.RDto;
import com.npnc.board.service.BListHandler;
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
	
	// 게시글 쓰기 
	public int insert(String id, String category, String title, String content, String file) {
		
		try {
			getConnection();
			String sql = "insert into board values(null, ?, ?, ?, default, default, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, id); // session.getAttribute("logindata");占쏙옙 占싸깍옙占싸듸옙 占쏙옙占싱듸옙 占쌨아와억옙占쏙옙 
			pstmt.setString(3, content);
			pstmt.setString(4, file); // 첨占쏙옙占쏙옙占쏙옙 占쌘몌옙
			pstmt.setInt(5, Integer.parseInt(category));
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return result;
	}
	
	
	// 게시글 수정
	public int updateArticle(String title, String content, int idx) {
		
		try {
			getConnection();
			String sql = "UPDATE board SET title = ? , content = ? WHERE idx = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, idx);
			result = pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			freeConnection();
		}
		
		
		
		return result;
	}
	
	
	// 게시글 읽기
	public Vector getArticle(int idx) {
		Vector<BDto> v = new Vector();
		
		String sql = "select b.title, b.id, b.regDate, b.content, b.hit,"+
				"count(case when g.gob = 1 then 1 END) AS good,"+
				"count(case when g.gob = 0 then 0 END) AS bad"+
				" from board as b"+
				" inner JOIN gob AS g"+
				" ON b.idx = g.idx"+
				" WHERE b.idx = ?";
		
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String title = rs.getString("title");
				String id = rs.getString("id");
				Timestamp regDate = rs.getTimestamp("regDate");
				String content =rs.getString("content");
				int hit = rs.getInt("hit");
				int good = rs.getInt("good");
				int bad = rs.getInt("bad");
				
				BDto dto = new BDto();
				
				dto.setIdx(idx);
				dto.setTitle(title);
				dto.setId(id);
				dto.setRegdate(regDate);
				dto.setContent(content);
				dto.setHit(hit);
				dto.setGood(good);
				dto.setBad(bad);
				
				v.add(dto);
			}
			
		}catch(Exception e) {
			
		}finally {
			freeConnection();
		}
		return v;
	}
		
	// 카테고리 이름 가져오기
	public Vector getBoardTitle(int idx) {
		
		Vector<CDto> v = new Vector();
		
		String sql = "SELECT c.idx, c.NAME FROM category AS c INNER JOIN board AS b ON b.category = c.idx WHERE b.idx = ?";
		
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				CDto dto = new CDto();
				
				dto.setIdx(Integer.parseInt(rs.getString("idx")));
				dto.setName(rs.getString("NAME"));
				
				v.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			freeConnection();
		}
		return v;
	}
		
	
	// 게시글 삭제
	public int deleteArticle(int idx) {
		
		String sql = "DELETE FROM board WHERE idx = ?";
		
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			freeConnection();
		}
		
		
		return result;
	}
	
	
	// 댓글 가져오기
	public Vector<RDto> getReply(int bidx){
		Vector<RDto> v = new Vector();
		
		String sql = "select * from reply where bidx = ?";
		
		getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bidx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				int ridx = rs.getInt(1);				//댓글 idx
				String id = rs.getString(3);			//아이디
				String rContent = rs.getString(4);		//댓글 내용
				Timestamp regDate = rs.getTimestamp(5);	//작성시간
				
				RDto rdto = new RDto(ridx, bidx, id, rContent, regDate);
				
				v.add(rdto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			freeConnection();
		}
		
		
		return v;
	}
	
	// 좋아요 싫어요 등록
	public int upGob(int idx, String id, boolean gob){
		String sql = "INSERT INTO gob VALUES(?,?,?)";
		
		getConnection();
		
		try {
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, id);
			pstmt.setBoolean(3, gob);
			
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
			result = 0;
		}finally {
			freeConnection();
		}
		return result;
	}
	
	// 댓글 등록
	public int insertReply(int bidx, String id, String reply) {
		
		
		String sql = "INSERT INTO reply VALUES(NULL,?,?,?,DEFAULT);";
		
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bidx);
			pstmt.setString(2, id);
			pstmt.setString(3, reply);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			freeConnection();
		}
		
		
		return result;
	}
	
	
	// 댓글 삭제
	public int delReply(int ridx) {
		
		String sql = "delete from reply where ridx = ?";
		
		getConnection();
		
		try {
			pstmt =conn.prepareStatement(sql);
			pstmt.setInt(1, ridx);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			freeConnection();
		}
		
		return result;
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
