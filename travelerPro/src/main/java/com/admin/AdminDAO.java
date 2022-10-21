package com.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class AdminDAO {
	private Connection conn = DBConn.getConnection();
	
	public AdminDTO readCompany(long companyNum) {
		AdminDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT companyNum, companyName, companyTel, companyInfo, amenities,"
					+ " guide, regionNum, checkInTime, checkOutTime, addr, addrDetail, notice, businessNum, userName "
					+ " FROM company c "
					+ " JOIN member1 m ON c.userName = m.userName "
					+ " WHERE approval = 0 AND companyNum = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, companyNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new AdminDTO();
				
				dto.setCompanyNum(rs.getLong("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyTel(rs.getString("companyTel"));
				dto.setCompanyInfo(rs.getString("companyInfo"));
				dto.setAmenities(rs.getString("amenities"));
				dto.setGuide(rs.getString("guide"));
				dto.setRegionNum(rs.getInt("regionNum"));
				dto.setCheckInTime(rs.getString("checkInTime"));
				dto.setCheckOutTime(rs.getString("checkOutTime"));
				dto.setAddr(rs.getString("addr"));
				dto.setAddrDetail(rs.getString("addrDetail"));
				dto.setNotice(rs.getString("notice"));
				dto.setBusinessNum(rs.getString("businessNum"));
				dto.setUserName(rs.getString("userName"));
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	public List<AdminDTO> listCompany(int offset, int size){
		List<AdminDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT companyNum, companyName, businessNum, userName "
					+ " FROM company c "
					+ " JOIN member1 m ON c.userName = m.userName "
					+ " WHERE approval = 0 "
					+ " ORDER BY companyNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AdminDTO dto = new AdminDTO();
				
				dto.setCompanyNum(rs.getLong("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setBusinessNum(rs.getString("businessNum"));
				dto.setUserName(rs.getString("userName"));
				
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
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM company "
					+ " WHERE approval = 0 ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
