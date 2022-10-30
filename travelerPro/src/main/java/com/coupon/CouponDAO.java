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
	
	public void insertCoupon(CouponDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO coupon(couponNum, couponName, couponRate, couponPrice, "
					+ " start_date, end_date, content) "
					+ " VALUES(coupon_seq.NEXTVAL, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getCouponName());
			pstmt.setInt(2, dto.getCouponRate());
			pstmt.setInt(3, dto.getCouponPrice());
			pstmt.setString(4, dto.getStart_date());
			pstmt.setString(5, dto.getEnd_date());
			pstmt.setString(6, dto.getContent());
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {	
				}
			}
		}
	}
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM coupon";
			
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
	
	public List<CouponDTO> listCoupon(int offset, int size){
		List<CouponDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT couponNum, couponName, couponRate, couponPrice, content, "
					+ " TO_CHAR(start_date, 'YYYY-MM-DD') start_date, TO_CHAR(end_date, 'YYYY-MM-DD') end_date "
					+ " FROM coupon "
					+ " ORDER BY couponNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
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
	
	public CouponDTO readCoupon(long couponNum) {
		CouponDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT couponNum, couponName, couponRate, couponPrice, content, "
					+ " TO_CHAR(start_date, 'YYYY-MM-DD') start_date, TO_CHAR(end_date, 'YYYY-MM-DD') end_date "
					+ " FROM coupon "
					+ " WHERE couponNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, couponNum);
			
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
	
	
	public void updateCoupon(CouponDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE coupon SET couponName=?, couponRate=?, couponPrice=?, content=?, "
					+ " start_date=?, end_date=? "
					+ " WHERE couponNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getCouponName());
			pstmt.setInt(2, dto.getCouponRate());
			pstmt.setInt(3, dto.getCouponPrice());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getStart_date());
			pstmt.setString(6, dto.getEnd_date());
			pstmt.setLong(7, dto.getCouponNum());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	
	public void deleteCoupon(long couponNum) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "DELETE FROM coupon WHERE couponNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, couponNum);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	
	public void deleteDate(long couponNum) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "DELETE FROM coupon WHERE couponNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, couponNum);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
	}

}
