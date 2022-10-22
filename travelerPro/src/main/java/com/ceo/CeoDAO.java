package com.ceo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class CeoDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertCeo(CeoDTO dto) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO company(companyNum, companyName, companyTel, companyInfo, amenities, guide, regionNum,"
					+ " checkinTime, checkoutTime, addr, addrDetail, zip, notice, businessNum,userId,approval)"
					+ " VALUES(company_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?,?,0)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getCompanyName());
			pstmt.setString(2, dto.getCompanyTel());
			pstmt.setString(3, dto.getCompanyInfo());
			pstmt.setString(4, dto.getAmenities());
			pstmt.setString(5, dto.getGuide());
			pstmt.setInt(6, dto.getRegionNum());
			pstmt.setString(7, dto.getCheckinTime());
			pstmt.setString(8, dto.getCheckoutTime());
			pstmt.setString(9, dto.getAddr());
			pstmt.setString(10, dto.getAddrDetail());
			pstmt.setString(11, dto.getZip());
			pstmt.setString(12, dto.getNotice());
			pstmt.setString(13, dto.getBusinessNum());
			pstmt.setString(14, dto.getUserId());
			
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
	public List<CeoDTO> listCeo(int offset,int size){
		List<CeoDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT companyNum, companyName, companyTel,addr,approval "
					+ " FROM company"
					+ " ORDER BY businessNum DESC"
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CeoDTO dto = new CeoDTO();
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyTel(rs.getString("companyTel"));
				dto.setAddr(rs.getString("addr"));
				dto.setApproval(rs.getInt("approval"));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e2) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e2) {
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
			sql = "SELECT NVL(COUNT(*), 0) FROM company";
			pstmt = conn.prepareStatement(sql);

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
	public CeoDTO readCto(int num) {
		CeoDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
			sql = "SELECT companyNum, companyName, companyTel, companyInfo, amenities, guide, regionNum,"
					+ " checkinTime, checkoutTime, addr, addrDetail, zip, notice, businessNum,userId "
					+ " FROM company"
					+ " WHERE companyNum = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new CeoDTO();
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyTel(rs.getString("companyTel"));
				dto.setCompanyInfo(rs.getString("companyInfo"));
				dto.setAmenities(rs.getString("amenities"));
				dto.setGuide(rs.getString("guide"));
				dto.setRegionNum(rs.getInt("regionNum"));
				dto.setCheckinTime(rs.getString("checkinTime"));
				dto.setCheckoutTime(rs.getString("checkoutTime"));
				dto.setAddr(rs.getString("addr"));
				dto.setAddrDetail(rs.getString("addrDetail"));
				dto.setZip(rs.getString("zip"));
				dto.setNotice(rs.getString("notice"));
				dto.setBusinessNum(rs.getString("businessNum"));
				dto.setUserId(rs.getString("userId"));
				
			}
		} catch (Exception e) {
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
		return dto;
	}
}
