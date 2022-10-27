package com.answer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.qna.QnaVO;
import com.util.DBConn;

public class MemberADAO {
	private Connection conn = DBConn.getConnection();
	
	public List<QnaVO> qnaList(int offset, int size){
		List<QnaVO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT questionNum, subject, content, reg_date, userId, categoryNum, answer "
					+ " FROM memberQ "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnaVO dto = new QnaVO();
				
				dto.setQuestionNum(rs.getLong("questionNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setUserId(rs.getString("userId"));
				dto.setCategoryNum(rs.getInt("categoryNum"));
				dto.setAnswer(rs.getInt("answer"));
				
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
	
	public int qnaCount(){
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) "
					+ " FROM memberQ ";
			
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
	
	public QnaVO qnaRead(long questionNum) {
		QnaVO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT questionNum, userId, subject, content, reg_date, categoryNum, answer "
					+ " FROM memberQ "
					+ " WHERE questionNum = ?  ";
			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, questionNum);
	
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new QnaVO();
				
				dto.setQuestionNum(rs.getLong("questionNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setCategoryNum(rs.getInt("categoryNum"));
				dto.setAnswer(rs.getInt("answer"));
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
	
	public void insertQna(MemberADTO dto, QnaVO vo) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			conn.setAutoCommit(false);
			
			sql = "INSERT INTO memberA(answerNum, content, reg_date, questionNum) "
					+ " VALUES(memberA_seq.NEXTVAL, ?, SYSDATE, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getContent());
			pstmt.setLong(2, dto.getQuestionNum());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			pstmt = null;
			
			sql = "UPDATE memberQ SET answer = 1 WHERE questionNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, vo.getQuestionNum());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			pstmt = null;
			
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
	
	public void updateAnswer(int answer, long questionNum) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE memberQ SET answer = ? WHERE questionNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, answer);
			pstmt.setLong(2, questionNum);
			
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
	
	public MemberADTO qnaList(long questionNum) {
		MemberADTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT * FROM "
					+ " (SELECT * FROM memberA WHERE questionNum = ? ORDER BY reg_date DESC) "
					+ " WHERE rownum = 1 ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, questionNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MemberADTO();
				
				dto.setAnswerNum(rs.getLong("answerNum"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setQuestionNum(rs.getLong("questionNum"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return dto;
		
	}
	
	public void deleteAnswer(long answerNum, long questionNum) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			conn.setAutoCommit(false);
			
			sql = "DELETE FROM memberA WHERE answerNum = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, answerNum);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			pstmt = null;
			
			sql = "UPDATE memberQ SET answer = 0 WHERE questionNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, questionNum);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			pstmt = null;
			
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
}
