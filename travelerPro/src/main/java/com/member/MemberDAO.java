package com.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.util.DBConn;

public class MemberDAO {
	private Connection conn = DBConn.getConnection();

	public MemberDTO loginMember(String userId, String userPwd) {
		MemberDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT userId, userName, userPwd, register_date, nickName, email, tel, roll ");
			sb.append(" FROM member ");
			sb.append(" WHERE userId = ? AND userPwd = ? AND enabled = 1");

			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new MemberDTO();

				dto.setUserId(rs.getString("userId"));
				dto.setUserPwd(rs.getString("userPwd"));
				dto.setUserName(rs.getString("userName"));
				dto.setReg_date(rs.getString("register_date"));
				dto.setNickName(rs.getString("nickName"));
				dto.setEmail(rs.getString("email"));
				dto.setTel(rs.getString("tel"));
				dto.setRoll(rs.getInt("roll"));
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

	public void insertMember(MemberDTO dto) throws SQLException {
		// 회원 등록

		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO member(userId, userName, userPwd, register_date, nickName, birth, email, tel, enabled, modify_date) "
					+ " VALUES (?, ?, ?, SYSDATE, ?, TO_DATE(?,'YYYYMMDD'), ?, ?, 1, null)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getUserName());
			pstmt.setString(3, dto.getUserPwd());
			pstmt.setString(4, dto.getNickName());
			pstmt.setString(5, dto.getBirth());
			pstmt.setString(6, dto.getEmail());
			pstmt.setString(7, dto.getTel());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
		}

	}

	public MemberDTO readMember(String userId) {
		// 아이디 검색

		MemberDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append("SELECT userId, userName, userPwd,");
			sb.append("      register_date, nickName,  TO_CHAR(birth, 'YYYY-MM-DD') birth, ");
			sb.append("      email, tel, enabled, roll, modify_date, mAlarm, pAlarm, eAlarm, sAlarm ");
			sb.append("  FROM member");
			sb.append("  WHERE userId = ?");

			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new MemberDTO();

				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setUserPwd(rs.getString("userPwd"));
				dto.setReg_date(rs.getString("register_date"));
				dto.setNickName(rs.getString("nickName"));
				dto.setBirth(rs.getString("birth"));
				dto.setEmail(rs.getString("email"));
				if (dto.getEmail() != null) {
					String[] ss = dto.getEmail().split("@");
					if (ss.length == 2) {
						dto.setEmail1(ss[0]);
						dto.setEmail2(ss[1]);
					}
				}

				dto.setTel(rs.getString("tel"));

				if (dto.getTel() != null) {
					String[] ss = dto.getTel().split("-");
					if (ss.length == 3) {
						dto.setTel1(ss[0]);
						dto.setTel2(ss[1]);
						dto.setTel3(ss[2]);
					}
				}

				dto.setEnabled(rs.getInt("enabled"));
				dto.setRoll(rs.getInt("roll"));

				dto.setModify_date(rs.getString("modify_date"));
				dto.setmAlarm(rs.getInt("mAlarm"));
				dto.setpAlarm(rs.getInt("pAlarm"));
				dto.seteAlarm(rs.getInt("eAlarm"));
				dto.setsAlarm(rs.getInt("sAlarm"));

			}

		} catch (Exception e) {

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

	public void updateMember(MemberDTO dto) throws SQLException {

		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "UPDATE member SET userName=?, userPwd=?, nickName=?, " + " birth=TO_DATE(?,'YYYYMMDD'), "
					+ " email=?, tel=?, mAlarm=?, pAlarm=?, eAlarm=?, sAlarm=? WHERE userId=? ";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getUserName());
			pstmt.setString(2, dto.getUserPwd());
			pstmt.setString(3, dto.getNickName());
			pstmt.setString(4, dto.getBirth());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getTel());
			pstmt.setInt(7, dto.getmAlarm());
			pstmt.setInt(8, dto.getpAlarm());
			pstmt.setInt(9, dto.geteAlarm());
			pstmt.setInt(10, dto.getsAlarm());
			pstmt.setString(11, dto.getUserId());

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

	public void deleteMember(MemberDTO dto) throws SQLException {
		// 탈퇴
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "DELETE FROM member WHERE userId=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getUserId());

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

	public void updateAlarm(MemberDTO dto) throws SQLException {

		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "UPDATE member SET mAlarm=?, pAlarm=?, eAlarm=?, sAlarm=?, modify_date=? WHERE userId=? ";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getmAlarm());
			pstmt.setInt(2, dto.getpAlarm());
			pstmt.setInt(3, dto.geteAlarm());
			pstmt.setInt(4, dto.getsAlarm());
			pstmt.setString(5, dto.getModify_date());
			pstmt.setString(6, dto.getUserId());

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

	public String sysdate() {
		String result = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT SYSDATE FROM dual";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				result += rs.getString(1);
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
