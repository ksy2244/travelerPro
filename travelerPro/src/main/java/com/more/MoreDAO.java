package com.more;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.answer.FaqDTO;
import com.util.DBConn;

public class MoreDAO {
	private Connection conn = DBConn.getConnection();
	
	public List<FaqDTO> moreFaq(int categoryNum) {
		List<FaqDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT faqNum, subject, content, categoryNum "
					+ " FROM faq "
					+ " WHERE categoryNum = ? "
					+ " ORDER BY faqNum DESC ";
			
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
	
	public List<FaqDTO> moreFaqAll() {
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
}
