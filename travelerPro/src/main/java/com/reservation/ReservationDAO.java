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
	public ReservationDTO readRoom(int companyNum) {
		ReservationDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT roomNum, roomName, roomInfo, price, discountRate, companyNum, headCount" + " FROM room"
					+ " WHERE companyNum =1 ";

			pstmt = conn.prepareStatement(sql);

			//pstmt.setInt(1, companyNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new ReservationDTO();
				dto.setRoomNum(rs.getInt("roomNum"));
				dto.setRoomName(rs.getString("roomName"));
				dto.setRoomInfo(rs.getString("roomInfo"));
				dto.setRoomPrice(rs.getInt("price"));
				dto.setDiscountRate(rs.getInt("discountRate"));
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

//	public int dataCount() {
	// TODO Auto-generated method stub
	// return 0;
//	}

	// 숙박 업체 목록 보기

	public List<ReservationDTO> listRoom(int offset, int size) {
		List<ReservationDTO> list = new ArrayList<ReservationDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT roomNum, roomName, roomInfo, price, discountRate, headCount ");
			sb.append(" FROM room");

			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReservationDTO dto = new ReservationDTO();

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

	public int dataCount() {
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

		public List<ReservationDTO> listRoom(int offset, int size, String condition, String keyword) {
			List<ReservationDTO> list = new ArrayList<ReservationDTO>();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			StringBuilder sb = new StringBuilder();

			try {
				sb.append(" SELECT roomNum, roomName, roomInfo, price, discountRate, headCount ");
				sb.append(" FROM room ");
			
				/*
				if (condition.equals("all")) {
					sb.append(" WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ");
				} else if (condition.equals("reg_date")) {
					keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
					sb.append(" WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ?");
				} else {
					sb.append(" WHERE INSTR(" + condition + ", ?) >= 1 ");
				}
				*/
				sb.append(" ORDER BY roomNum DESC ");
				sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

				pstmt = conn.prepareStatement(sb.toString());
				
				if (condition.equals("all")) {
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
				
				while (rs.next()) {
					ReservationDTO dto = new ReservationDTO();

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
					} catch (SQLException e2) {
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e2) {
					}
				}
			}

			return list;
		}
}