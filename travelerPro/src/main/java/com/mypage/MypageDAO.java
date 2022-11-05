package com.mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.coupon.CouponDTO;
import com.reservation.ReservationDTO;
import com.reservation.ReserveCompanyDTO;
import com.review.ReviewDTO;
import com.util.DBConn;

public class MypageDAO {
	private Connection conn = DBConn.getConnection();

	public List<CouponDTO> myPageCoupon(String userId, int offset, int size) {
		List<CouponDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT couponNum, couponName, couponRate, couponPrice, content, "
					+ " TO_CHAR(start_date, 'YYYY.MM.DD') start_date, end_date " + " FROM coupon "
					+ " WHERE end_date >= TO_CHAR(SYSDATE, 'YYYY-MM-DD') "
					+ " AND couponNum NOT IN(SELECT c.couponNum FROM coupon c JOIN myCoupon m ON c.couponNum = m.couponNum WHERE userId = ?) "
					+ " ORDER BY couponNum DESC " + " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				CouponDTO dto = new CouponDTO();

				dto.setCouponNum(rs.getLong("couponNum"));
				dto.setCouponName(rs.getString("couponName"));
				dto.setCouponRate(rs.getInt("couponRate"));
				dto.setCouponPrice(rs.getInt("couponPrice"));
				dto.setContent(rs.getString("content"));
				dto.setStart_date(rs.getString("start_date"));
				dto.setEnd_date(rs.getString("end_date"));

				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}

			if (rs != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}

		return list;

	}

	public int dataCount(String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT COUNT(*) FROM coupon "
					+ " WHERE TO_CHAR(end_date, 'YYYY-MM-DD') >= TO_CHAR(SYSDATE, 'YYYY-MM-DD') "
					+ " AND couponNum NOT IN(SELECT c.couponNum FROM coupon c JOIN myCoupon m ON c.couponNum = m.couponNum WHERE userId = ?) ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}

			if (rs != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}

		return result;

	}

	public CouponDTO myPageReadCoupon(long couponNum, String userId) {
		CouponDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT couponNum, couponName, couponRate, couponPrice, content, "
					+ " TO_CHAR(start_date, 'YYYY-MM-DD') start_date, end_date " + " FROM coupon "
					+ " WHERE couponNum = ? AND end_date >= TO_CHAR(SYSDATE, 'YYYY-MM-DD') "
					+ " AND couponNum NOT IN(SELECT c.couponNum FROM coupon c JOIN myCoupon m ON c.couponNum = m.couponNum WHERE userId = ?) ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, couponNum);
			pstmt.setString(2, userId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new CouponDTO();

				dto.setCouponNum(rs.getLong("couponNum"));
				dto.setCouponName(rs.getString("couponName"));
				dto.setCouponRate(rs.getInt("couponRate"));
				dto.setCouponPrice(rs.getInt("couponPrice"));
				dto.setContent(rs.getString("content"));
				dto.setStart_date(rs.getString("start_date"));
				dto.setEnd_date(rs.getString("end_date"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}

			if (rs != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}

		return dto;

	}

	public List<ReserveCompanyDTO> myPickList(String userId, int offset, int size) {
		List<ReserveCompanyDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
			sql = " SELECT c.companyNum, companyName,imageFileName, checkInTime, r.price, cp.pick  " + " FROM pick p  "
					+ " JOIN company c ON c.companyNum = p.companyNum  "
					+ " JOIN companyPick cp ON p.companyNum = cp.companyNum "
					+ " JOIN room r ON r.companyNum = p.companyNum "
					+ " JOIN mainCompanyImage mc ON mc.companyNum = p.companyNum  " + " WHERE p.userId = ? "
					+ " ORDER BY companyNum DESC " + " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				ReserveCompanyDTO dto = new ReserveCompanyDTO();

				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCheckInTime(rs.getString("checkInTime"));
				dto.setMinPrice(rs.getInt("price"));
				dto.setPick(rs.getInt("pick"));
				dto.setImageFileName(rs.getString("imageFileName"));

				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}

			if (rs != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}

		return list;

	}

	// 업체 찜 리스트 페이징 처리를 위한 데이터 개수 세기
	public int dataPickCount(String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT count(*) FROM pick p  WHERE userId = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}

			if (rs != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}

		return result;

	}

	// 나의 예약 내역 조회
	public List<ReservationDTO> myReseravationList(String userId) {
		List<ReservationDTO> list = new ArrayList<ReservationDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			sql = " SELECT r.reservationNum, c.companyNum, TO_CHAR(start_date,'yyyy.MM.dd') AS startDate, TO_CHAR(end_date, 'yyyy.MM.dd') AS endDate, "
					+ "     r.checkInTime, r.checkOutTime, TO_CHAR(reservation_Date, 'yyyy.MM.dd') AS  RegDate, roomName, c.companyName, m.userName, "
					+ " 	paymentPrice, imageFileName, end_date-start_date AS  day" + " FROM reservation r "

					+ " LEFT OUTER JOIN reservationDetail d " + " ON r.reservationNum = d.reservationNum "

					+ " LEFT OUTER JOIN room room " + " ON room.roomNum = d.roomNum "

					+ " LEFT OUTER JOIN company c " + " ON c.companyNum = room.companyNum "

					+ " LEFT OUTER JOIN member m " + " ON m.userId = r.userId "

					+ " LEFT OUTER JOIN mainCompanyImage mc " + " ON mc.companyNum = c.companyNum "

					+ " WHERE m.userId = ? AND TO_CHAR(reservation_date, 'YYYYMMDD') >= SYSDATE - (INTERVAL '2' YEAR) AND TO_CHAR(reservation_date,'YYYYMMDD') <= TO_CHAR(SYSDATE, 'YYYYMMDD') ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReservationDTO dto = new ReservationDTO();
				dto.setReservationNum(rs.getLong("reservationNum"));
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setStart_date(rs.getString("startDate"));
				dto.setEnd_date(rs.getString("endDate"));
				dto.setCheckInTime(rs.getString("checkInTime"));
				dto.setCheckOutTime(rs.getString("checkOutTime"));
				dto.setReservation_date(rs.getString("RegDate"));
				dto.setRoomName(rs.getString("roomName"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setUserName(rs.getString("userName"));
				dto.setPaymentPrice(rs.getInt("paymentPrice"));
				dto.setImageFileName(rs.getString("imageFileName"));
				dto.setDay(rs.getInt("day"));

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

	// 나의 예약 데이터 개수 세기
	public int myReservationCount(String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT COUNT(*) FROM reservation "
					+ " WHERE userId = ?  AND TO_CHAR(reservation_date, 'YYYYMMDD') >= SYSDATE - (INTERVAL '2' YEAR) "
					+ " AND TO_CHAR(reservation_date,'YYYYMMDD') <= TO_CHAR(SYSDATE, 'YYYYMMDD') ";
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

	// 나의 리뷰
	public List<ReviewDTO> myReviewList(String userId) {
		List<ReviewDTO> list = new ArrayList<ReviewDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			sql = " SELECT rd.reservationNum, TO_CHAR(reg_date,'yyyy.MM.dd') AS reg_date, content, starRate, "
					+ " companyName, roomName, c.companyNum, "
					+ " TO_CHAR(start_date,'yyyy.MM.dd') AS start_date , TO_CHAR(end_date,'yyyy.MM.dd') AS end_date  "
					+ "	FROM review r " + "	JOIN reservationDetail rd  "
					+ "	ON r.reservationNum = rd.reservationNum " + "	JOIN reservation rv "
					+ "	ON rv.reservationNum = rd.reservationNum " + "	JOIN company c "
					+ "	ON c.companyNum = r.companyNum " + "	JOIN room r " + "	ON r.companyNum = c.companyNum "
					+ "	JOIN member m " + "	ON m.userId = rv.userId " + "	WHERE m.userID = ? "
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
				dto.setCompanyNum(rs.getInt("companyNum"));
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
			sql = "SELECT COUNT(*) " + "FROM review r " + "JOIN reservation s ON r.reservationNum = s.reservationNum "
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

	public ReservationDTO reservationDetail(long reservationNum) {
		ReservationDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT realUserName, realUserTel, totalPrice, totalPrice-paymentPrice AS sales, paymentPrice, "
					+ " couponName,  c.couponRate, c.couponPrice, TO_CHAR(c.end_date, 'YYYY.MM.DD') AS end_date  , userName, tel "
					+ " FROM reservation r "
					+ " JOIN member m ON r.userId = m.userId "
					+ " JOIN myCoupon mc ON mc.reservationNum = r.reservationNum "
					+ " JOIN coupon c ON c.couponNum = mc.couponNum "
					+ " WHERE r.reservationNum = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, reservationNum);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new ReservationDTO();
				dto.setRealUserName(rs.getString("realUserName")); // 예약자 이름
				dto.setRealUserTel(rs.getString("realUserTel")); // 예약자 전화번호
				dto.setTotalPrice(rs.getInt("totalPrice")); // 업체 지정 금액
				dto.setSales(rs.getInt("sales")); // 할인 받은 가격
				dto.setPaymentPrice(rs.getInt("paymentPrice")); // 실제 지불한 금액
				dto.setCouponName(rs.getString("couponName")); // 쿠폰 이름
				dto.setDiscountRate(rs.getInt("couponRate")); // 할인율 쿠폰
				dto.setCouponPrice(rs.getInt("couponPrice")); // 할인가격 쿠폰
				dto.setEnd_date(rs.getString("end_date")); // 쿠폰 시작 종료일
				dto.setUserName(rs.getString("userName"));
				dto.setTel(rs.getString("tel"));

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

}
