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

	public List<ReserveCompanyDTO> listCompany(int offset, int size) {
		List<ReserveCompanyDTO> list = new ArrayList<ReserveCompanyDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT companyNum, companyName, companyInfo, amenities, guide, checkintime, checkouttime, "
					+ " notice, addr, addrdetail, zip ");
			sb.append(" FROM company");

			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReserveCompanyDTO dto = new ReserveCompanyDTO();
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyInfo(rs.getString("companyInfo"));
				dto.setAmenities(rs.getString("amenities"));
				dto.setGuide(rs.getString("guide"));
				dto.setCheckintime(rs.getString("checkintime"));
				dto.setCheckouttime(rs.getString("checkouttime"));
				dto.setNotice(rs.getString("notice"));
				dto.setAddr(rs.getString("addr"));
				dto.setAddrdetail(rs.getString("addrdetail"));
				dto.setZip(rs.getInt("zip"));

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

	// 객실 목록
	public List<ReserveRoomDTO> listRoom(int companyNum) {
		List<ReserveRoomDTO> list = new ArrayList<ReserveRoomDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT companyNum, roomNum, roomName, roomInfo, price, discountRate, headCount ");
			sb.append(" FROM room");
			sb.append("  WHERE companyNum = ? ");

			pstmt = conn.prepareStatement(sb.toString());
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

	// 객실
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
	public int dataCount(String condition, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM room  ";
			if (condition.equals("all")) {
				sql += " WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ";
			}
//				} else if (condition.equals("reg_date")) {
//					keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
//					sql += " WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ? ";
//				} else {
//					sql += " WHERE INSTR(" + condition + ", ?) >= 1 ";
//				}

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

	// 업체 리스트 - 검색에서의 데이터 개수
	public int dataCompanyCount(String condition, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM company  ";
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

	public ReserveCompanyDTO readCompany(int companyNum) {
		ReserveCompanyDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT companyNum,companyName, companyInfo, amenities, guide, checkintime, checkouttime, "
					+ " notice, addr, addrdetail, zip " + " FROM company" + " WHERE companyNum = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, companyNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto.setCompanyNum(rs.getInt(companyNum));

				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyInfo(rs.getString("companyInfo"));
				dto.setAmenities(rs.getString("amenities"));
				dto.setGuide(rs.getString("guide"));
				dto.setCheckintime(rs.getString("checkintime"));
				dto.setCheckouttime(rs.getString("checkouttime"));
				dto.setNotice(rs.getString("notice"));
				dto.setAddr(rs.getString("addr"));
				dto.setAddrdetail(rs.getString("addrdetail"));
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

	public List<ReserveRoomDTO> listSelectRoom(int roomNum) {
		List<ReserveRoomDTO> list = new ArrayList<ReserveRoomDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

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

			while (rs.next()) {
				ReserveRoomDTO dto = new ReserveRoomDTO();
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

	public void insertReservation(ReservationDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO reservation ( reservationNum, start_date, end_date, realHeadCount, totalPrice, "
					+ " checkInTime, checkOutTime, status, discountPrice, paymentPrice, userId, "
					+ " reservation_date, couponPrice, realUserName, realUserTel) "
					+ " VALUES( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ? ,SYSDATE, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getReservationNum());
			pstmt.setString(2, dto.getStart_date());
			pstmt.setString(3, dto.getEnd_date());
			pstmt.setInt(4, dto.getRealHeadCount());
			pstmt.setInt(5, dto.getTotalPrice());
			pstmt.setString(6, dto.getCheckInTime());
			pstmt.setString(7, dto.getCheckOutTime());
			pstmt.setString(8, dto.getStatus());
			pstmt.setInt(9, dto.getDiscountPrice());
			pstmt.setInt(10, dto.getPaymentPrice());
			pstmt.setString(11, dto.getUserId());
			pstmt.setInt(12, dto.getCouponPrice());
			pstmt.setString(13, dto.getRealUserName());
			pstmt.setString(14, dto.getRealUserTel());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
		}

	}

	

}
