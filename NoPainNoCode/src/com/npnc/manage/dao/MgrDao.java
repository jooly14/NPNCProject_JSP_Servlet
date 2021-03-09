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
import com.npnc.manage.service.MCListCntHandler;
import com.npnc.manage.service.MMListHandler;
import com.npnc.member.dto.MDto;

public class MgrDao {	//게시글 관련 DAO
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int result;
	
	DataSource dataSource = null;
	public int cateGradeChg(int idx, String rw,int grade) {
		getConnection();
		String sql = "update category set "+rw+" = ? where idx = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, grade);
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
	
	public int chgMemGrade(String id, int grade) {
		getConnection();
		String sql = "update member set usergrade = ? where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, grade);
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return result;
	}
	
	public HashMap<Integer, String> getGradeList() {
		HashMap<Integer, String> map = new HashMap<>();
		getConnection();
		String sql = "select * from grade";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				map.put(rs.getInt(1), rs.getString(2));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return map;
	}
	public Vector<MDto> getMemberList(MMListHandler handler,String type,String keyword, int page, int pagesize) {
		Vector<MDto> dtos = new Vector<>();
		getConnection();
		String sql = "select SQL_CALC_FOUND_ROWS * from member";
		if(type!=null&&!type.isEmpty()){		//검색
			if(type.equals("usergrade")){
				sql = "SELECT SQL_CALC_FOUND_ROWS m.*,g.name FROM member m INNER JOIN grade g ON m.usergrade = g.grade WHERE g.name LIKE '%"+keyword+"%'";
			}else{
				sql= sql + " where "+type+" like '%" +keyword+"%'" ;
			}
		}
		sql = sql + " order by usergrade, id limit ?,?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (page-1)*pagesize);
			pstmt.setInt(2, pagesize);
			rs = pstmt.executeQuery();
			while(rs.next()){
				MDto dto = new MDto();
				dto.setId(rs.getString(1));
				dto.setName(rs.getString(3));
				dto.setEmail(rs.getString(5));
				dto.setAddress(rs.getString(6));
				dto.setPhonenum(rs.getString(7));
				dto.setGrade(rs.getInt(8));
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
		public void getTotalCnt(MMListHandler handler){
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
	
	
	public int moveAllCategory(int old, int newCategory) {
		getConnection();
		String sql = "update board set category = ? where category = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, newCategory);
			pstmt.setInt(2, old);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return result;
	}
	public int addCategory(CDto dto ,String maincategory) {
		getConnection();
		String sql = "insert into category values(null,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, maincategory);
			pstmt.setString(2, dto.getName());
			pstmt.setInt(3, dto.getReadgrade());
			pstmt.setInt(4, dto.getWritegrade());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return result;
	}
	
	public int deleteCategory(int idx) {
		getConnection();
		String sql = "delete from category where idx = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return result;
	}
	public int deleteMainCategory(String maincategory) {
		getConnection();
		String sql = "delete from category where maincategory = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, maincategory);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return result;
	}
	
	public Map<String, Vector<CDto>> getCategoryList(MCListCntHandler handler) {
		Map<String, Vector<CDto>> map = new HashMap<String, Vector<CDto>>();
		Map<Integer, Integer> cntMap = new HashMap<>();
		String sql = "SELECT c.*, t.cnt FROM category AS c left outer JOIN (SELECT category,COUNT(*) AS cnt FROM board GROUP BY category) AS t ON c.idx=t.category ORDER BY maincategory,idx";
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
	public MgrDao() {
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
