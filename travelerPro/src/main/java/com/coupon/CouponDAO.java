package com.coupon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class CouponDAO {
private Connection conn = DBConn.getConnection();
	
	public void insertNotice(CouponDTO dto) throws SQLException {
		
	}
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM notice";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
			
			if(rs != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		
		return result;
	}
	
	public List<CouponDTO> listNotice(int offset, int size){
		List<CouponDTO> list = new ArrayList<>();
		
		
		return list;
	}
	
	public CouponDTO readNotice(long noticeNum) {
		CouponDTO dto = null;
		
		
		return dto;
	}
	
	
	public void updateNotice(CouponDTO dto) throws SQLException {
		
	}
	
	public void deleteNotice(long noticeNum) throws SQLException {
		
	}
}
