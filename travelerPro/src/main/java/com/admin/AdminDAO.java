package com.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.coupon.CouponDTO;
import com.member.MemberDTO;
import com.util.DBConn;

public class AdminDAO {
	private Connection conn = DBConn.getConnection();
	
	public List<MemberDTO> userList(int offset, int size){
		List<MemberDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT userId, userName, TO_CHAR(register_date, 'YYYY-MM-DD') register_date, nickName, enabled, roll, "
					+ " email, tel, TO_CHAR(birth, 'YYYY-MM-DD') birth"
					+ " FROM member "
					+ " WHERE roll = 0 OR roll = 1"
					+ " ORDER BY roll DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setReg_date(rs.getString("register_date"));
				dto.setNickName(rs.getString("nickName"));
				dto.setEnabled(rs.getInt("enabled"));
				dto.setRoll(rs.getInt("roll"));
				dto.setEmail(rs.getString("email"));
				dto.setTel(rs.getString("tel"));
				dto.setBirth(rs.getString("birth"));
	
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
	
	public int userDataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM member "
					+ " WHERE roll = 0 OR roll = 1";
			
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
	
	//모달창 사용 시 필요한 데이터
	public MemberDTO userRead(String userId) {
		MemberDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT userId, userName, email, tel, TO_CHAR(birth, 'YYYY-MM-DD') birth "
					+ " FROM member "
					+ " WHERE userId = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MemberDTO();
				
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setEmail(rs.getString("email"));
				dto.setTel(rs.getString("tel"));
				dto.setBirth(rs.getString("birth"));
				
				if(dto.getTel() != null) {
					String[] ss = dto.getTel().split("-");
					if(ss.length == 3) {
						dto.setTel1(ss[0]);
						dto.setTel2(ss[1]);
						dto.setTel3(ss[2]);
					}
				}
				dto.setEmail(rs.getString("email"));
				if(dto.getEmail() != null) {
					String[] ss = dto.getEmail().split("@");
					if(ss.length == 2) {
						dto.setEmail1(ss[0]);
						dto.setEmail2(ss[1]);
					}
				}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	public AdminDTO companyRead(long companyNum) {
		AdminDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT companyNum, companyName, companyInfo, amenities,"
					+ " guide, regionNum, checkInTime, checkOutTime, addr, addrDetail, notice, businessNum, approval, m.userName, m.tel "
					+ " FROM company c "
					+ " JOIN member m ON c.userId = m.userId "
					+ " WHERE (approval = 0 OR approval = 1) AND companyNum = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, companyNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new AdminDTO();
				
				dto.setCompanyNum(rs.getLong("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
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
				dto.setApproval(rs.getInt("approval"));
				dto.setUserName(rs.getString("userName"));
				dto.setTel(rs.getString("tel"));
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	public List<AdminDTO> companyList(int offset, int size){
		List<AdminDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT companyNum, companyName, companyTel, businessNum, approval, m.userName "
					+ " FROM company c "
					+ " JOIN member m ON c.userId = m.userId "
					+ " WHERE approval = 0 OR approval = 1"
					+ " ORDER BY approval "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AdminDTO dto = new AdminDTO();
				
				dto.setCompanyNum(rs.getLong("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyTel(rs.getString("companyTel"));
				dto.setBusinessNum(rs.getString("businessNum"));
				dto.setApproval(rs.getInt("approval"));
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
	
	public int companyDataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) "
					+ " FROM company "
					+ " WHERE approval = 0 AND approval = 1";
			
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
	
	public void updateCompany(AdminDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE company SET approval = ? "
					+ " WHERE companyNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getApproval());
			pstmt.setLong(2, dto.getCompanyNum());

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
