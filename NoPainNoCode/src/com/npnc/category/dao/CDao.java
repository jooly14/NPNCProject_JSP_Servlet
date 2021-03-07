package com.npnc.category.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.npnc.category.dto.CDto;

public class CDao {	//�Խñ� ���� DAO
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int result;
	
	DataSource dataSource = null;

	public Map<String, Vector<CDto>> getCategoryList() {	//maincategory�ʵ� ���� Ű ������ category���̺� ���� ���� �ִ� CDto����Ʈ�� ������ �ִ� hashmap
		Map<String, Vector<CDto>> map = new HashMap<>();	//���� maincategory�� ���� ī�װ� ������ �ϳ��� Ű�� ��Ƴ���
		getConnection();
		String sql = "SELECT * FROM category ORDER BY maincategory";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				int idx = rs.getInt(1);
				String maincategory = rs.getString(2);
				String name = rs.getString(3);
				int readgrade = rs.getInt(4);
				int writegrade = rs.getInt(5);
				CDto dto = new CDto(idx, name, readgrade, writegrade);
				if(!map.containsKey(maincategory)){		//maincategory���� �������� ������ map�� ���� Ű�� �߰�
					map.put(maincategory, new Vector<CDto>());
					map.get(maincategory).add(dto);
				}else{									//maincategory���� �����ϸ� ���� Ű���� �̿��ؼ� �߰�
					map.get(maincategory).add(dto);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			freeConnection();
		}
		return map;
	}
	
	public CDao() {
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
