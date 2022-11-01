package com.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.reservation.ReservationDTO;
import com.util.DBConn;

public class ReviewDAO {

	private Connection conn = DBConn.getConnection();

//	
//	public void checkReservation(String userId) {
//		
//
//		" SELECT r.reservationNum, c.companyNum, rm.roomNum, r.userId "
//		+ " FROM reservation r "
//		+ " LEFT OUTER JOIN reservationDetail d"
//		+ " ON r.reservationNum = d.reservationNum "
//		+ " LEFT OUTER JOIN room rm "
//		+ " ON rm.roomNum = d.roomNum "
//		+ " LEFT OUTER JOIN company c "
//		+ " ON c.companyNum = rm.companyNum "
//		+ " WHERE r.userId = 'admin'; "
//		
//		
//	}

	public void insertReview(ReviewDTO dto) throws SQLException {
		String sql = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			sql = "SELECT rd.reservationNum AS reservationNum, companyNum" + " FROM reservationDetail  rd "
					+ " LEFT OUTER JOIN room rm " + " ON rd.roomNum = rm.roomNum " + " LEFT OUTER JOIN reservation rv  "
					+ " ON rv.reservationNum = rd.reservationNum " + " WHERE userId =? AND companyNum =  ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserId());
			pstmt.setInt(2, dto.getCompanyNum());

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setReservationNum(rs.getLong("reservationNum"));
				dto.setCompanyNum(rs.getInt("companyNum"));
			}

			pstmt.executeUpdate();
			pstmt.close();
			pstmt = null;
			rs.close();

			sql = "INSERT INTO review(reviewNum, reg_date, content, starRate, reservationNum, companyNum)"
					+ "VALUES (review_seq.NEXTVAL , SYSDATE, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getContent());
			pstmt.setInt(2, dto.getStarRate());
			pstmt.setLong(3, dto.getReservationNum());
			pstmt.setInt(4, dto.getCompanyNum());

			pstmt.executeUpdate();
			pstmt.close();
			pstmt = null;

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

	}

	// 업체별 리뷰 리스트
	public List<ReviewDTO> listReview(int companyNum, int offset, int size) {
		List<ReviewDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			sql = " SELECT reviewNum, r.reservationNum, content, TO_CHAR(reg_date,'yyyy.mm.dd') AS reg_date, starRate, reserve.userId, nickName, c.companyNum "
					+ " FROM review r " + " JOIN reservation reserve ON r.reservationNum = reserve.reservationNum "
					+ " JOIN member m ON reserve.userId = m.userId "
					+ " JOIN reservationDetail rd ON rd.reservationNum = r.reservationNum "
					+ " JOIN room rm ON rd.roomNum = rm.roomNum " + " JOIN company c ON c.companyNum = rm.companyNum "
					+ " WHERE c.companyNum = ? " + " ORDER BY r.reviewNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, companyNum);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setReviewNum(rs.getInt("reviewNum"));
				dto.setReservationNum(rs.getLong("reservationNum"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setStarRate(rs.getInt("starRate"));
				dto.setUserId(rs.getString("userId"));
				dto.setNickName(rs.getString("nickName"));
				dto.setCompanyNum(rs.getInt("companyNum"));
				list.add(dto);
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

		return list;
	}

	public void deleteReview(int reviewNum, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		if (!userId.equals("admin")) {
			ReviewDTO dto = readReview(reviewNum);
			if (dto == null || (!userId.equals(dto.getUserId()))) {
				return;
			}
		}

		try {
			sql = "DELETE FROM review WHERE reviewNum = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, reviewNum);

			pstmt.executeUpdate();

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

	
	private ReviewDTO readReview(int reviewNum) {
		ReviewDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT reviewNum, rv.userId, userName, content reg_date " + " FROM review r  "
					+ " JOIN reservation rv ON rv.reservationNum = r.reservationNum "
					+ " JOIN member m ON rv.userId = m.userId  " + " WHERE replyNum ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, reviewNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new ReviewDTO();

				dto.setReviewNum(rs.getInt("replyNum"));
				dto.setNum(rs.getLong("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
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

		return dto;
	}

	// 리뷰의 개수 카운트
	public int dataCountReview(int companyNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT NVL(COUNT(*), 0) FROM review WHERE companyNum = ? ";
			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, companyNum);

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

	// 나의 리뷰
	public List<ReviewDTO> myReviewList(String userId) {
		List<ReviewDTO> list = new ArrayList<ReviewDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			sql = " SELECT rd.reservationNum, TO_CHAR(reg_date,'yyyy.MM.dd') AS reg_date, content, starRate, "
					+ " companyName, roomName, "
					+ " TO_CHAR(start_date,'yyyy.MM.dd') AS start_date , TO_CHAR(end_date,'yyyy.MM.dd') AS end_date  " 
					+ "	FROM review r "
					+ "	JOIN reservationDetail rd  "
					+ "	ON r.reservationNum = rd.reservationNum "
					+ "	JOIN reservation rv "
					+ "	ON rv.reservationNum = rd.reservationNum "
					+ "	JOIN company c "
					+ "	ON c.companyNum = r.companyNum " 
					+ "	JOIN room r "
					+ "	ON r.companyNum = c.companyNum "
					+ "	JOIN member m " 
					+ "	ON m.userId = rv.userId " 
					+ "	WHERE m.userID = ? "
					+ "	ORDER BY reg_date DESC ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setReservationNum(rs.getLong("reservationNum"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setContent(rs.getString("content"));
				dto.setStarRate(rs.getInt("starRate"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setRoomName(rs.getString("roomName"));
				dto.setStartDate(rs.getString("start_date"));
				dto.setEndDate(rs.getString("end_date"));

				list.add(dto);
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

		return list;
	}
	
	public int myReviewCount(String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT COUNT(*) "
					+ "FROM review r "
					+ "JOIN reservation s ON r.reservationNum = s.reservationNum "
					+ "WHERE userId = ? ";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);

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
	
	public int checkRoll(int companyNum, String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT  COUNT(r.reservationNum) AS checkRoll FROM reservation r "
					+ " JOIN reservationDetail rd ON rd.reservationNum = r.reservationNum "
					+ " JOIN room rm ON rm.roomNum = rd.roomNum " + "JOIN company c ON c.companyNum = rm.companyNum "
					+ " WHERE (c.companyNum = ? AND r.userId = ? )";

			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, companyNum);
			pstmt.setString(2, userId);

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
