package com.mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.coupon.CouponDTO; 
import com.util.DBConn;

public class MypageDAO {
	private Connection conn = DBConn.getConnection();
	
	public List<CouponDTO> myPageCoupon(String userId ){ // , int offset, int size){
		List<CouponDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT couponNum, couponName, couponRate, couponPrice, content, "
					+ " TO_CHAR(start_date, 'YYYY-MM-DD') start_date, end_date "
					+ " FROM coupon "
					+ " WHERE end_date >= TO_CHAR(SYSDATE, 'YYYY-MM-DD') "
					+ " AND couponNum NOT IN(SELECT c.couponNum FROM coupon c JOIN myCoupon m ON c.couponNum = m.couponNum WHERE userId = ?) "
					+ " ORDER BY couponNum DESC ";
//					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
//			pstmt.setInt(2, offset);
//			pstmt.setInt(3, size);
//			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CouponDTO dto = new CouponDTO();
				
				dto.setCouponNum(rs.getLong("couponNum"));
				dto.setCouponName(rs.getString("couponName"));
				dto.setCouponRate(rs.getInt("couponRate"));
				dto.setCouponPrice(rs.getInt("couponPrice"));
				dto.setContent(rs.getString("content"));
				dto.setStart_date(rs.getString("start_date"));
				dto.setEnd_date(rs.getString("end_date"));
				
				list.add(dto);
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
		
		
		return list;
		
	}
	
	public int dataCount(String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM coupon "
					+ " WHERE TO_CHAR(end_date, 'YYYY-MM-DD') >= TO_CHAR(SYSDATE, 'YYYY-MM-DD') "
					+ " AND couponNum NOT IN(SELECT c.couponNum FROM coupon c JOIN myCoupon m ON c.couponNum = m.couponNum WHERE userId = ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
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
	
	public CouponDTO myPageReadCoupon(long couponNum, String userId) {
		CouponDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT couponNum, couponName, couponRate, couponPrice, content, "
					+ " TO_CHAR(start_date, 'YYYY-MM-DD') start_date, end_date "
					+ " FROM coupon "
					+ " WHERE couponNum = ? AND end_date >= TO_CHAR(SYSDATE, 'YYYY-MM-DD') "
					+ " AND couponNum NOT IN(SELECT c.couponNum FROM coupon c JOIN myCoupon m ON c.couponNum = m.couponNum WHERE userId = ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, couponNum);
			pstmt.setString(2, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new CouponDTO();
				
				dto.setCouponNum(rs.getLong("couponNum"));
				dto.setCouponName(rs.getString("couponName"));
				dto.setCouponRate(rs.getInt("couponRate"));
				dto.setCouponPrice(rs.getInt("couponPrice"));
				dto.setContent(rs.getString("content"));
				dto.setStart_date(rs.getString("start_date"));
				dto.setEnd_date(rs.getString("end_date"));
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
		
		return dto;
		
	}
	
	
	

}
