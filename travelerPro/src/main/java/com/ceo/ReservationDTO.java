package com.ceo;

public class ReservationDTO {
	private long reservationNum; // 예약 번호
	private String start_date; // 시작일
	private String end_date; // 종료일
	private int realHeadCount; // 예약한 인원수	
	private String reservation_date;
	private String checkInTime; // 체크인 시간
	private String checkOutTime; // 체크아웃 시간	
	private int paymentPrice; // 지불 금액
	private String userId; // 사용자	
	private String realUserName; // 실제 사용자 이름
	private String realUserTel; // 실제 사용자 전화번호
	
	private int companyNum;//업체번호
	private int realheadCount; //realheadCount로 고쳐야할듯
	private String companyName; //업체이름
	private String roomName; //방이름
	private String userName;//예약한 사람아이디
	
	public long getReservationNum() {
		return reservationNum;
	}
	public void setReservationNum(long reservationNum) {
		this.reservationNum = reservationNum;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public int getRealHeadCount() {
		return realHeadCount;
	}
	public void setRealHeadCount(int realHeadCount) {
		this.realHeadCount = realHeadCount;
	}
	public String getReservation_date() {
		return reservation_date;
	}
	public void setReservation_date(String reservation_date) {
		this.reservation_date = reservation_date;
	}
	public String getCheckInTime() {
		return checkInTime;
	}
	public void setCheckInTime(String checkInTime) {
		this.checkInTime = checkInTime;
	}
	public String getCheckOutTime() {
		return checkOutTime;
	}
	public void setCheckOutTime(String checkOutTime) {
		this.checkOutTime = checkOutTime;
	}
	public int getPaymentPrice() {
		return paymentPrice;
	}
	public void setPaymentPrice(int paymentPrice) {
		this.paymentPrice = paymentPrice;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRealUserName() {
		return realUserName;
	}
	public void setRealUserName(String realUserName) {
		this.realUserName = realUserName;
	}
	public String getRealUserTel() {
		return realUserTel;
	}
	public void setRealUserTel(String realUserTel) {
		this.realUserTel = realUserTel;
	}
	
	public int getCompanyNum() {
		return companyNum;
	}
	public void setCompanyNum(int companyNum) {
		this.companyNum = companyNum;
	}

	public int getRealheadCount() {
		return realheadCount;
	}
	public void setRealheadCount(int realheadCount) {
		this.realheadCount = realheadCount;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	private String imageFileName;
}
