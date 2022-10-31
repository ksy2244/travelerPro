package com.qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.util.DBConn;

public class QnaDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertQna(QnaVO dto) throws SQLException {
		// 문의사항 등록
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO memberQ(questionNum, subject, content, reg_date, userId, categoryNum, answer) "
					+ " VALUES(memberQ_seq.NEXTVAL, ?, ?, SYSDATE, ?, ?, 0 ) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getUserId());
			pstmt.setInt(4, dto.getCategoryNum());
			
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if( pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
					
				}
			}
		}
	}
	
	public int dataCount(String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM memberQ WHERE userId = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
		}
		
		return result;
	}
	
	public List<QnaVO> listQna(String userId, int offset, int size) {
		List<QnaVO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT questionNum, subject, "
					+ " TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date ,categoryNum, userId, answer "
					+ " FROM memberQ "
					+ " WHERE userId = ? "
					+ " ORDER BY questionNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnaVO dto = new QnaVO();
				
				dto.setQuestionNum(rs.getLong("questionNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setCategoryNum(rs.getInt("categoryNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setAnswer(rs.getInt("answer"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return list;
	}
	
	public List<QnaVO> listCategory() {
		List<QnaVO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT categoryNum, categoryName "
					+ " FROM qnacategory ";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnaVO dto = new QnaVO();
				
				dto.setCategoryNum(rs.getInt("categoryNum"));
				dto.setCategoryName(rs.getString("categoryName"));
				
				list.add(dto);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if( rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if( pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
		}
		return list;
	
	}

	
	public QnaVO readQna(long questionNum) {
		QnaVO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT questionNum, subject, content, reg_date, q.userId, categoryNum "
					+ " FROM memberQ q "
					+ " JOIN member m ON q.userId = m.userId "
					+ " WHERE questionNum = ? ";
			
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, questionNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new QnaVO();
				
				dto.setQuestionNum(rs.getLong("questionNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setUserId(rs.getString("userId"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setCategoryNum(rs.getInt("categoryNum"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return dto;
	}
	
	public void updateQna(QnaVO dto) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE memberQ SET subject = ?, content = ?, categoryNum = ? "
					+ " WHERE questionNum = ? AND userId = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getCategoryNum());
			pstmt.setLong(4, dto.getQuestionNum());
			pstmt.setString(5, dto.getUserId());
			
			pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		} finally {
			if( pstmt!=null ) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
	}
	
	public void deleteQna(long questionNum, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			if (userId.equals("admin")) {
				sql = "DELETE FROM memberQ WHERE questionNum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, questionNum);

				pstmt.executeUpdate();
			} else {
				sql = "DELETE FROM memberQ WHERE questionNum=? AND userId=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, questionNum);
				pstmt.setString(2, userId);

				pstmt.executeUpdate();
			}

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	
}
