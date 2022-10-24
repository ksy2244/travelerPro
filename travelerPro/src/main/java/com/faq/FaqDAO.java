package com.faq;

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
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
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
					+ " FROM faq ";
			
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
		}
		
		return dto;
		
	}
	
	
	

}
