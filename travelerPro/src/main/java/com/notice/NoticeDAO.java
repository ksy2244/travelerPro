package com.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class NoticeDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertNotice(NoticeDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			conn.setAutoCommit(false);
			
			sql = "INSERT INTO notice(noticeNum, subject, content, reg_date, notice) "
					+ " VALUES(notice_seq.NEXTVAL, ?, ?, SYSDATE, 0)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
		
			pstmt.executeUpdate();
			
			pstmt.close();
			pstmt = null;
			
			sql = "INSERT INTO noticeFile(fileNum, noticeNum, saveFilename, originalFilename) VALUES (nFile_seq.NEXTVAL, notice_seq.CURRVAL, ?, ?)";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSaveFilename());
			pstmt.setString(2, dto.getOriginalFilename());
			
			pstmt.executeUpdate();
			
			conn.commit();

		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e2) {
			}
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
			
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e2) {
			}
		}
		
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
	
	public List<NoticeDTO> listNotice(int offset, int size){
		List<NoticeDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT n.noticeNum, subject, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, saveFilename "
					+ " FROM notice n "
					+ " JOIN noticeFile f ON n.noticeNum = f.noticeNum "
					+ " ORDER BY noticeNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				
				dto.setNoticeNum(rs.getLong("noticeNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				
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
	
	public NoticeDTO readNotice(long noticeNum) {
		NoticeDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT n.noticeNum, subject, content, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, saveFilename, originalFilename "
					+ " FROM notice n "
					+ " JOIN noticeFile f ON n.noticeNum = f.noticeNum "
					+ " WHERE n.noticeNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, noticeNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new NoticeDTO();
				
				dto.setNoticeNum(rs.getLong("noticeNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				dto.setOriginalFilename(rs.getString("originalFilename"));
			
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
	
	
	public void update(NoticeDTO dto) throws SQLException {
		
	}
	
	public void deleteNotice(long noticeNum, String userId) throws SQLException {
		
	}

}
