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
	public List<ReserveRoomDTO> listSelectRoom = new ArrayList<ReserveRoomDTO>();

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

	// 모든  업체 목록을 조회 (업체 리스트)
	public List<ReserveCompanyDTO> listCompany(int offset, int size) {
		List<ReserveCompanyDTO> list = new ArrayList<ReserveCompanyDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT companyNum, companyName, companyInfo, amenities, guide, checkInTime, checkOutTime, "
					+ " notice, addr, addrDetail, zip ");
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
				dto.setCheckInTime(rs.getString("checkInTime"));
				dto.setCheckOutTime(rs.getString("checkOutTime"));
				dto.setNotice(rs.getString("notice"));
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

	// 해당 업체의 객실 목록 (객실 정보)
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
	


	//해당 업체의 업체 정보에 대한 정보를 가져온다.  (객실 상세 - 중앙 배치 )
	public ReserveCompanyDTO readCompany(int companyNum) {
		ReserveCompanyDTO dto = new ReserveCompanyDTO();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql =  " SELECT companyNum,companyName, companyInfo, amenities, guide, checkintime, checkouttime, companyTel, "
					+ " notice, addr, addrDetail, zip  FROM company  WHERE companyNum = ? ";

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
		List<ReserveRoomDTO> listSelectRoom = new ArrayList<ReserveRoomDTO>();
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

				listSelectRoom.add(dto);
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

		return listSelectRoom;
	}

	public void insertReservation(ReservationDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "INSERT INTO reservation ( reservationNum, start_date, end_date, realHeadCount, totalPrice, "
					+ " checkInTime, checkOutTime, status, paymentPrice, userId, realUserName, realUserTel) "
					+ " VALUES( ?, ?, ?, 0, 0, 0, 0, 1, 0, ?,? , ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, dto.getReservationNum()); // 예약 번호
			pstmt.setString(2, dto.getStart_date());
			pstmt.setString(3, dto.getEnd_date());
			pstmt.setString(4, dto.getUserId());
			pstmt.setString(5, dto.getRealUserName());
			pstmt.setString(6, dto.getRealUserTel());
			pstmt.executeUpdate();

			pstmt.close();
			pstmt = null;

			sql = " UPDATE reservation SET " 
					+ " realHeadCount = (SELECT headCount FROM room WHERE roomNum = ? ), "
					+ " totalPrice =  (SELECT price FROM room WHERE roomNum = ?) " 
					+ " WHERE reservationNum = ?  ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getRoomNum());
			pstmt.setInt(2, dto.getRoomNum());
			pstmt.setLong(3, dto.getReservationNum());

			pstmt.executeUpdate();
			pstmt.close();
			pstmt = null;

			sql = "  UPDATE reservation SET "
					+ " checkInTime = (SELECT checkInTime FROM company WHERE companyNum = ?), "
					+ " checkOutTime = (SELECT checkOutTime FROM company WHERE companyNum = ?) "
					+ " WHERE reservationNum = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getCompanyNum());
			pstmt.setInt(2, dto.getCompanyNum());
			pstmt.setLong(3, dto.getReservationNum());
			
			pstmt.executeUpdate();
			pstmt.close();
			pstmt = null;

		} catch (SQLException e) {

			try {
				conn.rollback();
				throw e;
			} catch (Exception e2) {

			}

		} finally {

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {

				}
			}

			try {
			} catch (Exception e) {

			}

		}
	}

	
}
