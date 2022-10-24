package com.room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class RoomDAO {
	private Connection conn=DBConn.getConnection();
	
	
public void insertRoom(RoomDTO dto)throws SQLException{
	PreparedStatement pstmt=null;
	String sql;
	
	try {
		sql="INSERT INTO room(roomNum, roomName, roomInfo, price, discountRate, headCount, companyNum, roomState)"
				+ "VALUES(room_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, 0)";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,dto.getRoomName());
		pstmt.setString(2,dto.getRoomInfo());
		pstmt.setInt(3,dto.getPrice());
		pstmt.setInt(4,dto.getDiscountRate());
		pstmt.setInt(5,dto.getHeadCount());	
		pstmt.setInt(6, dto.getCompanyNum());
				
		pstmt.executeUpdate();
		
	} catch (SQLException e) {
		e.printStackTrace();
		throw e;
	}finally {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
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
			sql = "SELECT COUNT(*) FROM room";
			
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
	
	public void updateroom(RoomDTO dto)throws SQLException{
		PreparedStatement pstmt =null;
		String sql;
		
		try {
			sql = "UPDATE room SET roomName=?, roomInfo=?, price=?, discountRate=?, headcount=? WHERE roomNum=?";
		
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1,dto.getRoomName());
			pstmt.setString(2,dto.getRoomInfo());
			pstmt.setInt(3,dto.getPrice());
			pstmt.setInt(4,dto.getDiscountRate());
			pstmt.setInt(5,dto.getHeadCount());
			
			pstmt.executeUpdate();
		}catch (SQLException e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
			}
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
	
	public List<RoomDTO>listroom(int offset, int size){
		List<RoomDTO>list =new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		try {
			sql = "SELECT roomNum, roomName, roomInfo, price, disCountRate, headCount "
					+ " FROM room "
					+ " ORDER BY roomNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1,offset);
			pstmt.setInt(2,size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				RoomDTO dto= new RoomDTO();
				dto.setRoomNum(rs.getInt("roomNum"));
				dto.setRoomName(rs.getString("roomName"));
				dto.setRoomInfo(rs.getString("roomInfo"));
				dto.setPrice(rs.getInt("price"));
				dto.setDiscountRate(rs.getInt("discountRate"));
				dto.setHeadCount(rs.getInt("headCount"));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
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
	
	public RoomDTO readRoom(int roomNum) {
		RoomDTO dto =null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		String sql;
		try {
			sql="SELECT roomNum, roomName, roomInfo, price, discountRate, headCount "
					+ " FROM room "
					+ " WHERE roomNum = ? ";
					

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, roomNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new RoomDTO();
				
				dto.setRoomNum(rs.getInt("roomNum"));
				dto.setRoomName(rs.getString("roomName"));
				dto.setRoomInfo(rs.getString("roomInfo"));
				dto.setPrice(rs.getInt("price"));
				dto.setDiscountRate(rs.getInt("discountRate"));
				dto.setHeadCount(rs.getInt("headCount"));
		
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
		
		return dto;
	}
	
	 public void deleteRoom(int roomNum) throws SQLException {
		 PreparedStatement pstmt=null;
		 String sql;
		 
		try {
			sql="DELETE FROM room WHERE roomNum=?";
			
			pstmt =conn.prepareStatement(sql);
			
			pstmt.setInt(1, roomNum);
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					
				}
			}
		}
		
		
	 }
	
	
	


}
