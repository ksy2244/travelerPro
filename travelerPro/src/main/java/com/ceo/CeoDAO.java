package com.ceo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class CeoDAO {
	private Connection conn = DBConn.getConnection();

	public void insertCeo(CeoDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int seq;

		try {
			sql = "SELECT company_seq.NEXTVAL FROM dual";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			seq = 0;
			if (rs.next()) {
				seq = rs.getInt(1);
			}
			dto.setCompanyNum(seq);

			rs.close();
			pstmt.close();
			rs = null;
			pstmt = null;

			sql = "INSERT INTO company(companyNum, companyName, companyTel, companyInfo, amenities, guide, regionName,"
					+ " checkinTime, checkoutTime, addr, addrDetail, zip, notice, businessNum,userId,approval)"
					+ " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,0)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getCompanyNum());
			pstmt.setString(2, dto.getCompanyName());
			pstmt.setString(3, dto.getCompanyTel());
			pstmt.setString(4, dto.getCompanyInfo());
			pstmt.setString(5, dto.getAmenities());
			pstmt.setString(6, dto.getGuide());
			pstmt.setString(7, dto.getRegionName());
			pstmt.setString(8, dto.getCheckinTime());
			pstmt.setString(9, dto.getCheckoutTime());
			pstmt.setString(10, dto.getAddr());
			pstmt.setString(11, dto.getAddrDetail());
			pstmt.setString(12, dto.getZip());
			pstmt.setString(13, dto.getNotice());
			pstmt.setString(14, dto.getBusinessNum());
			pstmt.setString(15, dto.getUserId());

			pstmt.executeUpdate();

			pstmt.close();
			pstmt = null;

			if (dto.getImageFiles() != null) {
				sql = "INSERT INTO companyFile(fileNum,imageFilename,companyNum) "
						+ " VALUES(companyFile_seq.NEXTVAL,?,?)";
				pstmt = conn.prepareStatement(sql);

				for (int i = 0; i < dto.getImageFiles().length; i++) {
					pstmt.setString(1, dto.getImageFiles()[i]);
					pstmt.setInt(2, dto.getCompanyNum());

					pstmt.executeUpdate();
				}

			}

		} catch (Exception e) {
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

	public List<CeoDTO> listCeo(int offset, int size, String id) {
		List<CeoDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT companyNum, companyName, companyTel,addr,approval " + " FROM company" + " WHERE userId = ?"
					+ " ORDER BY companyNum DESC" + " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				CeoDTO dto = new CeoDTO();
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyTel(rs.getString("companyTel"));
				dto.setAddr(rs.getString("addr"));
				dto.setApproval(rs.getInt("approval"));

				list.add(dto);
			}
		} catch (Exception e) {
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

	public int dataCount(String id) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM company WHERE userId=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
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

	public int dataQnaCount(String id) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM reserveq"
					+ " WHERE companyNum IN (SELECT companyNum from company where userId = ?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
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

	public CeoDTO readCto(int num) {
		CeoDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
			sql = "SELECT companyNum, companyName, companyTel, companyInfo, amenities, guide, regionName,"
					+ " checkinTime, checkoutTime, addr, addrDetail, zip, notice, businessNum,userId " + " FROM company"
					+ " WHERE companyNum = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new CeoDTO();
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyTel(rs.getString("companyTel"));
				dto.setCompanyInfo(rs.getString("companyInfo"));
				dto.setAmenities(rs.getString("amenities"));
				dto.setGuide(rs.getString("guide"));
				dto.setRegionName(rs.getString("regionName"));
				dto.setCheckinTime(rs.getString("checkinTime"));
				dto.setCheckoutTime(rs.getString("checkoutTime"));
				dto.setAddr(rs.getString("addr"));
				dto.setAddrDetail(rs.getString("addrDetail"));
				dto.setZip(rs.getString("zip"));
				dto.setNotice(rs.getString("notice"));
				dto.setBusinessNum(rs.getString("businessNum"));
				dto.setUserId(rs.getString("userId"));

			}
		} catch (Exception e) {
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

	public List<CeoDTO> listPhotoFile(int num) {
		List<CeoDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT fileNum,imageFileName,companyNum FROM companyFile WHERE companyNum = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				CeoDTO dto = new CeoDTO();

				dto.setFileNum(rs.getInt("fileNum"));
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setImageFilename(rs.getString("imageFileName"));
				list.add(dto);

			}

		} catch (Exception e) {
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

	public void updateCeo(CeoDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "UPDATE company SET companyName=?, companyTel=?, companyInfo=?, amenities=?, guide=?, regionName=?, "
					+ " checkinTime=?, checkoutTime=?, addr=?, addrDetail=?, zip=?, notice=?, businessNum=?"
					+ " WHERE companyNum = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCompanyName());
			pstmt.setString(2, dto.getCompanyTel());
			pstmt.setString(3, dto.getCompanyInfo());
			pstmt.setString(4, dto.getAmenities());
			pstmt.setString(5, dto.getGuide());
			pstmt.setString(6, dto.getRegionName());
			pstmt.setString(7, dto.getCheckinTime());
			pstmt.setString(8, dto.getCheckoutTime());
			pstmt.setString(9, dto.getAddr());
			pstmt.setString(10, dto.getAddrDetail());
			pstmt.setString(11, dto.getZip());
			pstmt.setString(12, dto.getNotice());
			pstmt.setString(13, dto.getBusinessNum());
			pstmt.setInt(14, dto.getCompanyNum());

			pstmt.executeUpdate();
			pstmt.close();
			pstmt = null;

			if (dto.getImageFiles() != null) {
				sql = "INSERT INTO companyFile(fileNum,imageFilename,companyNum) "
						+ " VALUES(companyFile_seq.NEXTVAL,?,?)";
				pstmt = conn.prepareStatement(sql);

				for (int i = 0; i < dto.getImageFiles().length; i++) {
					pstmt.setString(1, dto.getImageFiles()[i]);
					pstmt.setInt(2, dto.getCompanyNum());

					pstmt.executeUpdate();

				}
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
		}
	}

	public void deletePhoto(int num) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "DELETE FROM companyFile WHERE num = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, num);
		} catch (Exception e) {
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

	public List<CeoDTO> listqna(int offset, int size, String id) {
		List<CeoDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT r.inquiryNum, r.content,r.reg_date,c.companyNum,nickName,companyName,answhether"
					+ " FROM reserveq r " + " JOIN member m ON r.userId = m.userId "
					+ " JOIN company c ON c.companyNum = r.companyNum "
					+ " LEFT OUTER JOIN reservea a ON a.inquiryNum = r.inquiryNum"
					+ " WHERE c.companyNum IN (SELECT companyNum from company where userId = ?) "
					+ " ORDER BY inquiryNum DESC " + " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);

			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				CeoDTO dto = new CeoDTO();
				dto.setInquiryNum(rs.getInt("inquiryNum"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setNickName(rs.getString("nickName"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setAnswhether(rs.getInt("answhether"));

				list.add(dto);
			}
		} catch (Exception e) {
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

	public CeoDTO readqna(int num) {
		CeoDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT inquiryNum, r.content,r.reg_date,c.companyNum,nickName FROM reserveq r"
					+ " JOIN company c ON c.companyNum = r.companyNum" + " JOIN member m ON r.userId = m.userId"
					+ " WHERE c.companyNum = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new CeoDTO();
				dto.setInquiryNum(rs.getInt("inquiryNum"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setNickName(rs.getString("nickName"));

			}

		} catch (Exception e) {
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

	public void insertAnswer(CeoDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO reservea(answerNum,content,reg_date,inquiryNum,companyNum,answhether)"
					+ " VALUES(reservea_seq.NEXTVAL,?,SYSDATE,?,?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getContent());
			pstmt.setInt(2, dto.getInquiryNum());
			pstmt.setInt(3, dto.getCompanyNum());
			pstmt.setInt(4, dto.getAnswhether());

			pstmt.executeUpdate();
		} catch (Exception e) {
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

	public CeoDTO readAnswer(int num) {
		CeoDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT answerNum,r.content,r.reg_date,r.inquiryNum,c.companyNum " + " FROM reservea r"
					+ " JOIN reserveq e ON r.inquiryNum = e.inquiryNum"
					+ " JOIN company c ON c.companyNum = r.companyNum" + " WHERE e.inquiryNum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new CeoDTO();
				dto.setAnswerNum(rs.getInt("answerNum"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setInquiryNum(rs.getInt("inquiryNum"));
				dto.setCompanyNum(rs.getInt("companyNum"));
			}
		} catch (Exception e) {
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

	public void deleteCompany(int num) {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "DELETE FROM company where companyNum = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
	}

	public List<ReservationDTO> ceoReseravationList(String id, int offset, int size) {
		List<ReservationDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
			sql = " SELECT TO_CHAR(start_date, 'YYYY-MM-DD') AS startDate, TO_CHAR(end_date, 'YYYY-MM-DD') AS endDate, "
					+ " r.checkInTime, r.checkOutTime, TO_CHAR(reservation_Date, 'YYYY-MM-DD') AS  RegDate, "
					+ " paymentPrice, realheadCount,room.roomname,c.companyName,c.companyNum,r.userId,r.realUsertel, r.reservationNum,r.realUsername "
					+ " FROM reservation r " + " LEFT OUTER JOIN reservationDetail d "
					+ " ON r.reservationNum = d.reservationNum " + " LEFT OUTER JOIN room room "
					+ " ON room.roomNum = d.roomNum " + " LEFT OUTER JOIN company c "
					+ " ON c.companyNum = room.companyNum " + " LEFT OUTER JOIN member m " + " ON m.userId = r.userId "
					+ " WHERE c.companyNum IN (SELECT companyNum from company where userId = ?) "
					+ " ORDER BY reservationNum DESC " + " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReservationDTO dto = new ReservationDTO();
				dto.setStart_date(rs.getString("startDate"));
				dto.setEnd_date(rs.getString("endDate"));
				dto.setCheckInTime(rs.getString("checkInTime"));
				dto.setCheckOutTime(rs.getString("checkOutTime"));
				dto.setReservation_date(rs.getString("RegDate"));
				dto.setPaymentPrice(rs.getInt("paymentPrice"));
				dto.setRealHeadCount(rs.getInt("realHeadCount"));
				dto.setRoomName(rs.getString("roomName"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setRealUserTel(rs.getString("realUserTel"));
				dto.setReservationNum(rs.getLong("reservationNum"));
				dto.setRealUserName(rs.getString("realUserName"));
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

	public int dataReservationCount(String id) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT COUNT(*) FROM reservation r " + " LEFT OUTER JOIN reservationDetail d "
					+ " ON r.reservationNum = d.reservationNum" + " LEFT OUTER JOIN room room  "
					+ " ON room.roomNum = d.roomNum " + " LEFT OUTER JOIN company c  "
					+ " ON c.companyNum = room.companyNum " + " LEFT OUTER JOIN member m  "
					+ " ON m.userId = r.userId  "
					+ "  WHERE c.companyNum IN(SELECT companyNum from company where userId =?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);

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

	public ReservationDTO readreservation(long reservationNum) {
		ReservationDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT TO_CHAR(start_date, 'YYYY-MM-DD') AS startDate, TO_CHAR(end_date, 'YYYY-MM-DD') AS endDate, "
					+ " r.checkInTime, r.checkOutTime, TO_CHAR(reservation_Date, 'YYYY-MM-DD') AS  RegDate, "
					+ " paymentPrice, realheadCount,room.roomname,c.companyName,c.companyNum,r.userId,r.realUsertel, r.reservationNum,r.realUsername "
					+ " FROM reservation r " + " LEFT OUTER JOIN reservationDetail d "
					+ " ON r.reservationNum = d.reservationNum " + " LEFT OUTER JOIN room room "
					+ " ON room.roomNum = d.roomNum " + " LEFT OUTER JOIN company c "
					+ " ON c.companyNum = room.companyNum " + " LEFT OUTER JOIN member m " + " ON m.userId = r.userId "
					+ " WHERE r.reservationNum=? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, reservationNum);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new ReservationDTO();
				dto.setStart_date(rs.getString("startDate"));
				dto.setEnd_date(rs.getString("endDate"));
				dto.setCheckInTime(rs.getString("checkInTime"));
				dto.setCheckOutTime(rs.getString("checkOutTime"));
				dto.setReservation_date(rs.getString("RegDate"));
				dto.setPaymentPrice(rs.getInt("paymentPrice"));
				dto.setRealHeadCount(rs.getInt("realHeadCount"));
				dto.setRoomName(rs.getString("roomName"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setRealUserTel(rs.getString("realUserTel"));
				dto.setReservationNum(rs.getLong("reservationNum"));
				dto.setRealUserName(rs.getString("realUserName"));

			}

		} catch (SQLException e) {
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
					rs.close();
				} catch (SQLException e) {
				}
			}
		}
		return dto;
	}

	
	public int payListCount(String id) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
				sql =  "SELECT COUNT(*) FROM "
					+ " (SELECT c.companyNum "
					+ " FROM reservation r 			"
					+ " LEFT OUTER JOIN reservationDetail d ON r.reservationNum = d.reservationNum "
					+ " LEFT OUTER JOIN room room  ON room.roomNum = d.roomNum  "
					+ " LEFT OUTER JOIN company c  ON c.companyNum = room.companyNum  "
					+ " LEFT OUTER JOIN member m  ON m.userId = r.userId " 
					+ " WHERE c.companyNum IN(SELECT companyNum FROM company WHERE userId = ? ) "
					+ " GROUP BY c.companyNum )" ;

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
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
	
	
	public ServiceDTO readService() {
		ServiceDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT serviceNum, serviceName, serviceImg FROM service ";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new ServiceDTO();

				dto.setServiceNum(rs.getInt("serviceNum"));
				dto.setServiceName(rs.getString("serviceName"));
				dto.setServiceImg(rs.getString("serviceImg"));
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
		return dto;

	}
	
	public List<ServiceDTO> listCategory() {
		List<ServiceDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT serviceNum, serviceName, serviceImg " + " FROM service ";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ServiceDTO dto = new ServiceDTO();

				dto.setServiceNum(rs.getInt("serviceNum"));
				dto.setServiceName(rs.getString("serviceName"));
				dto.setServiceImg(rs.getString("serviceImg"));

				list.add(dto);
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
		return list;

	}

	// 모든 업체의 총 매출액
	public long sales(String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		long result = 0;

		try {
			sql = " SELECT SUM(paymentPrice) FROM "
					+ " (SELECT TO_CHAR(reservation_Date, 'YYYY-MM-DD') AS  ReserveDate, "
					+ " paymentPrice, room.roomname,c.companyName,c.companyNum "
					+ " FROM reservation r 				"
					+ " LEFT OUTER JOIN reservationDetail d ON r.reservationNum = d.reservationNum "
					+ " LEFT OUTER JOIN room room  ON room.roomNum = d.roomNum "
					+ " LEFT OUTER JOIN company c  ON c.companyNum = room.companyNum "
					+ " LEFT OUTER JOIN member m  ON m.userId = r.userId "
					+ " WHERE c.companyNum IN(SELECT companyNum FROM company WHERE userId = ? )) ";

			pstmt = conn.prepareStatement(sql);

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getLong(1);
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

	// 업체별 매출액
	public List<ReservationDTO> salesList(String Userid, int offset, int size) {
		List<ReservationDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT c.companyName, c.companyNum, SUM(paymentPrice) AS sales"
					+ " FROM reservation r 			"
					+ " LEFT OUTER JOIN reservationDetail d ON r.reservationNum = d.reservationNum "
					+ " LEFT OUTER JOIN room room  ON room.roomNum = d.roomNum "
					+ " LEFT OUTER JOIN company c  ON c.companyNum = room.companyNum "
					+ " LEFT OUTER JOIN member m  ON m.userId = r.userId "
					+ " WHERE c.companyNum IN ( SELECT companyNum FROM company WHERE userId = ? ) "
					+ " GROUP BY c.companyNum, c.companyName  "
					+ " ORDER BY c.companyNum ASC  "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, Userid);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReservationDTO dto = new ReservationDTO();
				dto.setCompanyNum(rs.getInt("companyNum"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setPaymentPrice(rs.getInt("sales"));
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

}
