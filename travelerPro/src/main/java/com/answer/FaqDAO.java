package com.answer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class FaqDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertFaq(FaqDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO faq(faqNum, subject, content, categoryNum) "
					+ " VALUES(faq_seq.NEXTVAL, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getCategoryNum());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
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
	
	public List<FaqDTO> listFaq(int categoryNum) {
		List<FaqDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT faqNum, subject, content, categoryNum "
					+ " FROM faq "
					+ " WHERE categoryNum = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, categoryNum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FaqDTO dto = new FaqDTO();
				
				dto.setFaqNum(rs.getLong("faqNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCategoryNum(rs.getInt("categoryNum"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return list;
		
	}
	
	public List<FaqDTO> listFaq() {
		List<FaqDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT faqNum, subject, content, categoryNum "
					+ " FROM faq "
					+ " ORDER BY faqNum DESC ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FaqDTO dto = new FaqDTO();
				
				dto.setFaqNum(rs.getLong("faqNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCategoryNum(rs.getInt("categoryNum"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return list;
		
	}
	
	public FaqDTO readFaq(long faqNum) {
		FaqDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT faqNum, subject, content, categoryNum "
					+ " FROM faq "
					+ " WHERE faqNum = ?  ";
			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, faqNum);
	
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new FaqDTO();
				
				dto.setFaqNum(rs.getLong("faqNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCategoryNum(rs.getInt("categoryNum"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return dto;
		
	}
	
	public void updateFaq(FaqDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE faq SET subject = ?, content = ?, categoryNum = ? "
					+ " WHERE faqNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getCategoryNum());
			pstmt.setLong(4, dto.getFaqNum());
			
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
	
	public void deleteFaq(long faqNum) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "DELETE FROM faq WHERE faqNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, faqNum);

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
	
	
	

}
