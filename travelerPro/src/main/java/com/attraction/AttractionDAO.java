package com.attraction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.reservation.ReserveCompanyDTO;
import com.util.DBConn;

public class AttractionDAO {
	private Connection conn = DBConn.getConnection();
	
	public List<ReserveCompanyDTO> surroundCompany(String region, int offset,int size){
		List<ReserveCompanyDTO> list = new ArrayList<ReserveCompanyDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = " SELECT c.companyNum, companyName, companyInfo, amenities, guide, checkInTime, checkOutTime,  "
					+ " notice, addr, addrDetail, zip, mc.imageFileName, minPrice,  "
					+ " CASE WHEN starRate >0 THEN starRate ELSE 0 END AS starRate, "
					+ " CASE WHEN pick >0 THEN pick ELSE 0 END AS pick  " + " FROM company c   "
					+ " LEFT OUTER JOIN mainCompanyImage mc ON mc.companyNum = c.companyNum "
					+ " LEFT OUTER JOIN companyPick p ON p.companyNum = c.companyNum   "
					+ " LEFT OUTER JOIN companyPrice pp ON pp.companyNum = c.companyNum  "
					+ " LEFT OUTER JOIN companyStar sr ON sr.companyNum = c.companyNum "
					+ " WHERE regionNum = 1 "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
					
			
			pstmt = conn.prepareStatement(sql);
			
			//pstmt.setString(1, region);
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ReserveCompanyDTO dto = new ReserveCompanyDTO();
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyInfo(rs.getString("companyInfo"));
				dto.setAmenities(rs.getString("amenities"));
				dto.setGuide(rs.getString("guide"));
				dto.setCheckInTime(rs.getString("checkInTime"));
				dto.setCheckOutTime(rs.getString("checkOutTime"));
				dto.setNotice(rs.getString("notice"));
				dto.setAddr(rs.getString("addr"));
				dto.setAddrDetail(rs.getString("addrDetail"));
				dto.setZip(rs.getInt("zip"));
				dto.setImageFileName(rs.getString("imageFileName"));
				dto.setMinPrice(rs.getInt("minPrice"));
				dto.setStarRate(rs.getDouble("starRate"));
				dto.setPick(rs.getInt("pick"));

				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
			}
		}

		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
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
			sql = "SELECT NVL(COUNT(*), 0) FROM company where regionNum = 1 ";
			pstmt = conn.prepareStatement(sql);

			//pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}

		return result;
	}
}

