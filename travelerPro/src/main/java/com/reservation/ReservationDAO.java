package com.reservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.util.DBConn;

public class ReservationDAO {
	private Connection conn = DBConn.getConnection();

	// 해당 숙박 업체 보기 (업체 상세)
	public ReserveRoomDTO readRoom(int companyNum) {
		ReserveRoomDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT roomNum, roomName, roomInfo, price, discountRate, companyNum, headCount" + " FROM room"
					+ " WHERE companyNum = ? ";
			// WHERE sold = 0; (판매 완료는 1)

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, companyNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new ReserveRoomDTO();
				dto.setRoomNum(rs.getInt("roomNum"));
				dto.setRoomName(rs.getString("roomName"));
				dto.setRoomInfo(rs.getString("roomInfo"));
				dto.setRoomPrice(rs.getInt("price"));
				dto.setDiscountRate(rs.getInt("discountRate"));
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setHeadCount(rs.getInt("headCount"));

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

	// 모든 업체 목록을 조회 (업체 리스트)
	public List<ReserveCompanyDTO> listCompany() {
		List<ReserveCompanyDTO> list = new ArrayList<ReserveCompanyDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {

			sql = " SELECT c.companyNum, companyName, companyInfo, amenities, guide, checkInTime, checkOutTime,  "
					+ " notice, addr, addrDetail, zip, mc.imageFileName, minPrice,  "
					+ " CASE WHEN starRate >0 THEN starRate ELSE 0 END AS starRate, "
					+ " CASE WHEN pick >0 THEN pick ELSE 0 END AS pick  " + " FROM company c   "
					+ " LEFT OUTER JOIN mainCompanyImage mc ON mc.companyNum = c.companyNum "
					+ " LEFT OUTER JOIN companyPick p ON p.companyNum = c.companyNum   "
					+ " LEFT OUTER JOIN companyPrice pp ON pp.companyNum = c.companyNum  "
					+ " LEFT OUTER JOIN companyStar sr ON sr.companyNum = c.companyNum "
					+ " WHERE c.companyNum IN (SELECT DISTINCT c.companyNum  " + " FROM company c, room r   "
					+ " WHERE c.companyNum = r.companyNum)";

			// CREATE OR REPLACE VIEW reviewStar AS
			// (SELECT *, COUNT(reviewNum) AS reviewCount, SUM(reviewNum) FROM review GROUP
			// BY companyNum);

			// CREATE OR REPLACE VIEW companyPick AS
			// (SELECT companyNum, COUNT(userId) AS pick FROM pick GROUP BY companyNum);

			// CREATE OR REPLACE VIEW companyPrice AS
			// (SELECT companyNum, MIN(price) AS minPrice FROM room GROUP BY companyNum);

			// CREATE OR REPLACE VIEW companyStar AS SELECT
			// TRUNC(SUM(starRate)/COUNT(starRate), 1) AS starRate, companyNum FROM review r
			// JOIN reservation rv ON r.reservationNum = rv.reservationNum
			// GROUP BY companyNum

			/*
			 * CREATE OR REPLACE FORCE NONEDITIONABLE VIEW mainCompanyImage AS (SELECT
			 * imageFileName, companyNum FROM (SELECT ROW_NUMBER() OVER(PARTITION BY
			 * companyNum ORDER BY companyNum, imageFileName DESC) rnum, imageFileName,
			 * companyNum FROM companyFile) WHERE rnum = 1)
			 */

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReserveCompanyDTO dto = new ReserveCompanyDTO();
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyInfo(rs.getString("companyInfo"));
				dto.setAmenities(rs.getString("amenities"));
				dto.setGuide(rs.getString("guide"));
				dto.setCheckInTime(rs.getString("checkInTime"));
				dto.setCheckOutTime(rs.getString("checkOutTime"));
				dto.setNotice(rs.getString("notice"));
				dto.setAddr(rs.getString("addr"));
				dto.setAddrDetail(rs.getString("addrDetail"));
				dto.setZip(rs.getInt("zip"));
				dto.setImageFileName(rs.getString("imageFileName"));
				dto.setMinPrice(rs.getInt("minPrice"));
				dto.setStarRate(rs.getDouble("starRate"));
				dto.setPick(rs.getInt("pick"));

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

	// 해당 업체의 객실 목록 (객실 정보)
	public List<ReserveRoomDTO> listRoom(int companyNum) {
		List<ReserveRoomDTO> list = new ArrayList<ReserveRoomDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			sql = "  SELECT companyNum, r.roomNum, roomName, roomInfo, price, discountRate, headCount, imageFileName "
					+ "  FROM room r " + "  JOIN mainRoomImage mr ON mr.roomNum = r.roomNum "
					+ "  WHERE companyNum = ? ";
			/*
			 * 
			 * CREATE OR REPLACE FORCE NONEDITIONABLE VIEW mainRoomImage AS (SELECT
			 * imageFileName, roomNum FROM (SELECT ROW_NUMBER() OVER(PARTITION BY roomNum
			 * ORDER BY roomNum, imageFileName DESC) rnum, imageFileName, roomNum FROM
			 * roomFile) WHERE rnum = 1)
			 */

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, companyNum);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReserveRoomDTO dto = new ReserveRoomDTO();

				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setRoomNum(rs.getInt("roomNum"));
				dto.setRoomName(rs.getString("roomName"));
				dto.setRoomInfo(rs.getString("roomInfo"));
				dto.setRoomPrice(rs.getInt("price"));
				dto.setDiscountRate(rs.getInt("discountRate"));
				dto.setHeadCount(rs.getInt("headCount"));

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

	//
	public int dataCountRoom() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM room";
			pstmt = conn.prepareStatement(sql);

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

	// 검색에서의 데이터 개수
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM (SELECT  DISTINCT c.companyNum FROM company c, room r WHERE c.companyNum = r.companyNum)";

			pstmt = conn.prepareStatement(sql);

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

	// 업체 리스트 - 검색에서의 데이터 개수
	public int dataCompanyCount(String condition, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM (SELECT  DISTINCT c.companyNum FROM company c, room r WHERE c.companyNum = r.companyNum);SELECT NVL(COUNT(*), 0) FROM (SELECT  DISTINCT c.companyNum FROM company c, room r WHERE c.companyNum = r.companyNum);  ";
			if (condition.equals("all")) {
				sql += " WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ";
			}
//						} else if (condition.equals("reg_date")) {
//							keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
//							sql += " WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ? ";
//						} else {
//							sql += " WHERE INSTR(" + condition + ", ?) >= 1 ";
//						}

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, keyword);
			if (condition.equals("all")) {
				pstmt.setString(2, keyword);
			}

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

	// 해당 업체의 업체 정보에 대한 정보를 가져온다. (객실 상세 - 중앙 배치 )
	public ReserveCompanyDTO readCompany(int companyNum) {
		ReserveCompanyDTO dto = new ReserveCompanyDTO();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT c.companyNum,companyName, companyInfo, amenities, guide, "
					+ " checkintime, checkouttime, companyTel, "
					+ " notice, addr, addrDetail, zip , pick FROM company c "
					+ " LEFT OUTER JOIN companyPick cp ON c.companyNum = cp.companyNum WHERE c.companyNum = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, companyNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dto.setCompanyNum(companyNum);

				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyInfo(rs.getString("companyInfo"));
				dto.setAmenities(rs.getString("amenities"));
				dto.setGuide(rs.getString("guide"));
				dto.setCheckInTime(rs.getString("checkInTime"));
				dto.setCheckOutTime(rs.getString("checkOutTime"));
				dto.setCompanyTel(rs.getString("companyTel"));
				dto.setNotice(rs.getString("notice"));
				dto.setAddr(rs.getString("addr"));
				dto.setAddrDetail(rs.getString("addrDetail"));
				dto.setZip(rs.getInt("zip"));
				dto.setPick(rs.getInt("pick"));

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

	public int dataCompanyCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM company";
			pstmt = conn.prepareStatement(sql);

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

	// 선택한 객실의 모든 정보
	public ReserveRoomDTO listSelectRoom(int roomNum) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		ReserveRoomDTO dto = new ReserveRoomDTO();

		try {
			sb.append(" SELECT roomNum, roomName, roomInfo, price, discountRate, headCount, r.companyNum, "
					+ " companyName, companyTel, companyInfo, amenities, guide, notice, checkInTime, checkOutTime, addr, addrDetail, zip ");
			sb.append(" FROM room r");
			sb.append(" LEFT OUTER JOIN company c ");
			sb.append(" ON r.companyNum = c.companyNum ");
			sb.append(" WHERE roomNum = ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, roomNum);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto.setRoomNum(rs.getInt("roomNum"));
				dto.setRoomName(rs.getString("roomName"));
				dto.setRoomInfo(rs.getString("roomInfo"));
				dto.setRoomPrice(rs.getInt("price"));
				dto.setDiscountRate(rs.getInt("discountRate"));
				dto.setHeadCount(rs.getInt("headCount"));
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyTel(rs.getString("companyTel"));
				dto.setCompanyInfo(rs.getString("companyInfo"));
				dto.setAmenities(rs.getString("amenities"));
				dto.setGuide(rs.getString("guide"));
				dto.setNotice(rs.getString("notice"));
				dto.setCheckInTime(rs.getString("checkInTime"));
				dto.setCheckOutTime(rs.getString("checkOutTime"));
				dto.setAddr(rs.getString("addr"));
				dto.setAddrDetail(rs.getString("addrDetail"));
				dto.setZip(rs.getInt("zip"));

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

	// 예약
	public void insertReservation(ReservationDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		try {

			sql = " INSERT INTO reservation" + "(reservationNum, start_date, end_date, realHeadCount, totalPrice, "
					+ " checkInTime, checkOutTime, status,  userId, paymentPrice, "
					+ " discountPrice, realUserName, realUserTel) "
					+ " VALUES( ?, ?, ?, ?, ?, ?, ?, 1, ?, ?, ? , ?, ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, dto.getReservationNum()); // 예약 번호 (서블릿)
			pstmt.setString(2, dto.getStart_date()); // 이용 시작일 (서블릿)
			pstmt.setString(3, dto.getEnd_date()); // 이용 종료일 (서블릿)
			pstmt.setInt(4, dto.getRealHeadCount()); // 허용 인원수 (select)
			pstmt.setInt(5, dto.getTotalPrice()); // 총합계 (할인 적용 안 된 업체에서 등록된 비용) (select)

			pstmt.setString(6, dto.getCheckInTime()); // 체크인 시간(서블릿)
			pstmt.setString(7, dto.getCheckOutTime()); // 체크아웃 시간 (서블릿)
			// 1
			pstmt.setString(8, dto.getUserId()); // 사용자 아이디(서블릿)
			pstmt.setInt(9, dto.getPaymentPrice()); // 지불할 금액 (할인 적용)

			pstmt.setInt(10, dto.getDiscountRate()); // 할인율
			pstmt.setString(11, dto.getRealUserName()); // 이용자 이름
			pstmt.setString(12, dto.getRealUserTel()); // 이용자 전화번호

			pstmt.executeUpdate();
			pstmt.close();
			pstmt = null;

			sql = "INSERT INTO reservationDetail(reservationDetailNum, reservationNum, roomNum )"
					+ " VALUES(reservationDetail_seq.NEXTVAL, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, dto.getReservationNum());
			pstmt.setInt(2, dto.getRoomNum());

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

	// 나의 예약 내역 조회
	public List<ReservationDTO> myReseravationList(String userId) {
		List<ReservationDTO> list = new ArrayList<ReservationDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			sql = " SELECT r.reservationNum, TO_CHAR(start_date,'yyyy.MM.dd') AS startDate, TO_CHAR(end_date, 'yyyy.MM.dd') AS endDate, "
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

	public int countCompanyLike(int companyNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM pick WHERE companyNum=?";
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

	public void deleteCompanyLike(int companyNum, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "DELETE FROM pick WHERE companyNum = ? AND userId = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, companyNum);
			pstmt.setString(2, userId);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}

	}

	public void insertCompanyLike(int companyNum, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO pick(companyNum, userId) VALUES (?, ?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, companyNum);
			pstmt.setString(2, userId);

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

	// 내가 사용할 수 있는 쿠폰 리스트
	public List<CouponDTO> listCoupon(String userId) throws SQLException {
		List<CouponDTO> list = new ArrayList<CouponDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			sql = " SELECT  couponName, couponRate,  TO_CHAR(start_date,'yyyy.MM.dd') AS start_Date, TO_CHAR(end_date,'yyyy.MM.dd') AS end_date FROM coupon "
					+ " WHERE (couponNum NOT IN " + " 	(SELECT couponNum FROM myCoupon WHERE userID =  ? ) )AND "
					+ " 	(( start_date <= SYSDATE ) AND  ( end_date >= SYSDATE )) ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);

			pstmt.executeUpdate();

			rs = pstmt.executeQuery();

			while (rs.next()) {
				CouponDTO dto = new CouponDTO();
				dto.setCouponName(rs.getString("couponName"));
				dto.setCouponRate(rs.getInt("couponRate"));
				dto.setStart_date(rs.getString("start_date"));
				dto.setEnd_date(rs.getString("end_date"));

				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		return list;
	}

	public boolean isUserCompanyLike(int companyNum, String userId) {
		boolean result = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT companyNum, userId FROM pick WHERE companyNum = ?  AND userId = ? ";
			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, companyNum);
			pstmt.setString(2, userId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}

		}

		return result;
	}

	

}
