package com.reservation;

public class ReservationDTO {
	// 객실 테이블
	private int roomNum; // 객실 번호
	private String roomName; // 객실 이름
	private String roomInfo; // 객실 정보
	private int roomPrice; // 객실 가격
	private int discountRate; // 사업자 등록 번호
	private int headCount; // 허용 인원수
	private int companyNum;// 업체 번호
	private int price; // 객실 가격

	public int getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getRoomInfo() {
		return roomInfo;
	}

	public void setRoomInfo(String roomInfo) {
		this.roomInfo = roomInfo;
	}

	public int getRoomPrice() {
		return roomPrice;
	}

	public void setRoomPrice(int roomPrice) {
		this.roomPrice = roomPrice;
	}

	public int getDiscountRate() {
		return discountRate;
	}

	public void setDiscountRate(int discountRate) {
		this.discountRate = discountRate;
	}

	public int getHeadCount() {
		return headCount;
	}

	public void setHeadCount(int headCount) {
		this.headCount = headCount;
	}

	public int getCompanyNum() {
		return companyNum;
	}

	public void setCompanyNum(int companyNum) {
		this.companyNum = companyNum;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

}
