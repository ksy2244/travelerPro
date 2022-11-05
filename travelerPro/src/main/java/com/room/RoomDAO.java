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
		sql="INSERT INTO room(roomNum, roomName, roomInfo, price, discountRate, headCount, companyNum )"
				+ " VALUES(room_seq.NEXTVAL, ?, ?, ?, ?, ?, ? ) ";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,dto.getRoomName());
		pstmt.setString(2,dto.getRoomInfo());
		pstmt.setInt(3,dto.getPrice());
		pstmt.setInt(4,dto.getDiscountRate());
		pstmt.setInt(5,dto.getHeadCount());	
		pstmt.setLong(6, dto.getCompanyNum());
				
		pstmt.executeUpdate();
		pstmt.close();
		pstmt=null;
		
		if(dto.getImageFiles() !=null) {
			sql= "INSERT INTO roomFile(fileNum, imageFilename, roomNum)"
					+ "VALUES(roomFile_seq.NEXTVAL,?,room_seq.CURRVAL)";
			pstmt=conn.prepareStatement(sql);
			
			for(int i=0; i<dto.getImageFiles().length; i++) {
				pstmt.setString(1, dto.getImageFiles()[i]);
				pstmt.executeUpdate();
			}
		}
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
	public int dataCount(long companyNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM room WHERE companyNum=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, companyNum);
			
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
			pstmt.setInt(6, dto.getRoomNum());
			pstmt.executeUpdate();
			pstmt.close();
			pstmt =null;
			
			if(dto.getImageFiles() !=null) {
				sql= "INSERT INTO roomFile(fileNum, imageFilename,roomNum) "
						+ "VALUES(roomFile_seq.NEXTVAL, ?, ?)";
				pstmt =conn.prepareStatement(sql);
				for(int i=0; i<dto.getImageFiles().length;i++) {
					pstmt.setString(1, dto.getImageFiles()[i]);
					pstmt.setLong(2, dto.getRoomNum());
					
					pstmt.executeUpdate();
					
				}
			}
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
	
	public List<RoomDTO>listroom(int offset, int size, long companyNum){//int offset, int size
		List<RoomDTO>list =new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
	
		
		try {
			
			sql = "SELECT roomNum, roomName, roomInfo, price, disCountRate, headCount, companyNum "
					+ " FROM room "
					+ " WHERE companyNum=? "					
					+ " ORDER BY roomNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, companyNum);
			pstmt.setInt(2,offset);
			pstmt.setInt(3,size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				RoomDTO dto= new RoomDTO();
				dto.setRoomNum(rs.getInt("roomNum"));
				dto.setRoomName(rs.getString("roomName"));
				dto.setRoomInfo(rs.getString("roomInfo"));
				dto.setPrice(rs.getInt("price"));
				dto.setDiscountRate(rs.getInt("discountRate"));
				dto.setHeadCount(rs.getInt("headCount"));
				dto.setCompanyNum(rs.getLong("companyNum"));
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
			sql=" DELETE FROM room WHERE roomNum=? ";
			
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
	
		 public List<companyDTO>selectCeo(long  companyNum){
			 List<companyDTO>list=new ArrayList<>();
			 PreparedStatement pstmt=null;
			 ResultSet rs=null;			 
			 String sql;		
			 try {
					sql= " SELECT companyNum, companyName "
							+ " FROM company "
							+ " WHERE  companyNum=? ";
					pstmt=conn.prepareStatement(sql);
					pstmt.setLong(1, companyNum);
				
					rs=pstmt.executeQuery();
					while(rs.next()) {
						companyDTO dto=new companyDTO();
						dto.setCompanyNum(rs.getLong("companyNum"));
						dto.setCompanyName(rs.getString("companyName"));
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
				}
				return list;			
			 }
		 public List<RoomDTO>listphotoFile(int num){
			 List<RoomDTO>list=new ArrayList<>();
			 PreparedStatement pstmt=null;
			 ResultSet rs =null;
			 String sql;
			 try {
				sql="SELECT fileNum, imageFilename, roomNum FROM roomFile WHERE roomNum = ?";
				pstmt =conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					RoomDTO dto=new RoomDTO();
					
					dto.setFileNum(rs.getLong("fileNum"));
					dto.setImageFilename(rs.getString("imageFilename"));
					dto.setRoomNum(rs.getInt("roomNum"));
					
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
		 
		 
		
		 public RoomDTO readPhotoFile(long fileNum) {
			RoomDTO dto=null;
			PreparedStatement pstmt=null;
			ResultSet rs= null;
			String sql;
			try {
				sql= "SELECT fileNum,imageFilename, roomNum FROM roomFile WHERE fileNum= ?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setLong(1, fileNum);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					dto =new RoomDTO();
					dto.setFileNum(rs.getLong("fileNum"));
					dto.setImageFilename(rs.getString("imageFilename"));
					dto.setRoomNum(rs.getInt("roomNum"));
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
					} catch (Exception e) {
					}
				}
			}
			 return dto;
		 }
		 
		public void deleteRoomFile(String mode, long roomNum)throws SQLException{
			PreparedStatement pstmt =null;
			String sql;
			try {
				if(mode.equals("all")) {
					sql="DELETE FROM roomFile WHERE roomNum= ?";
				}else {
					sql="DELETE FROM roomfile where fileNum =?";
				}
				pstmt=conn.prepareStatement(sql);
				pstmt.setLong(1, roomNum);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e2) {
					}
				}
			}
		}
}
