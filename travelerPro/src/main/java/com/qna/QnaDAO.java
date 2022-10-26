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
			sql = "INSERT INTO memberQ(questionNum, subject, content, reg_date, userId, categoryNum) "
					+ " VALUES(memberQ_seq.NEXTVAL, ?, ?, SYSDATE, ?, ? ) ";
			
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
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM memberQ";
			pstmt = conn.prepareStatement(sql);
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
	
	public int dataCount(String condition, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT COUNT(*) FROM memberQ q "
					+ " JOIN member m ON q.userId = m.userId ";
			if(condition.equals("all")) {
				sql += " WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ";
			} else if(condition.equals("reg_date")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ? ";
			} else {
				sql += " WHERE INSTR(" + condition + ", ?) >= 1 ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			if(condition.equals("all")) {
				pstmt.setString(2, keyword);
			} 
			
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
	
	public List<QnaVO> listQna(int offset, int size) {
		List<QnaVO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT questionNum, subject, "
					+ " TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date ,categoryNum "
					+ " FROM memberQ q "
					+ " JOIN member m ON q.userId = m.userId "
					+ " ORDER BY questionNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnaVO dto = new QnaVO();
				
				dto.setQuestionNum(rs.getLong("questionNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setCategoryNum(rs.getInt("categoryNum"));
				
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
	
	public List<QnaVO> listQna(int offset, int size, String condition, String keyword) {
		List<QnaVO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT questionNum, subject, "
					+ " TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, categoryNum "
					+ " FROM memberQ q "
					+ " JOIN member m ON q.userId = m.userId ";
			if(condition.equals("all")) {
				sql += " WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ";
			} else if(condition.equals("reg_date")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ? ";
			} else {
				sql += " WHERE INSTR(" + condition + ", ?) >= 1 ";
			}
			sql += " ORDER BY questionNum DESC ";
			sql += " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			if(condition.equals("all")) {
				pstmt.setString(1, keyword);
				pstmt.setString(2, keyword);
				pstmt.setInt(3, offset);
				pstmt.setInt(4, size);
			} else {
				pstmt.setString(1, keyword);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnaVO dto = new QnaVO();
				
				dto.setQuestionNum(rs.getLong("questionNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setCategoryNum(rs.getInt("categoryNum"));
				
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
	
	public List<QnaVO> listCategory(int offset, int size) {
		List<QnaVO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT categoryNum, categoryName "
					+ " FROM qnacategory ";
			
			
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
	
	
	
}
