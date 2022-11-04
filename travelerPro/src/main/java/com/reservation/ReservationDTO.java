package com.reservation;

public class ReservationDTO {
	private long reservationNum; // 예약 번호
	private String start_date; // 시작일
	private String end_date; // 종료일
	private int realHeadCount; // 예약한 인원수
	private int totalPrice; // 총금액 (할인 적용 X)
	private String reservation_date;
	private String checkInTime; // 체크인 시간
	private String checkOutTime; // 체크아웃 시간
	private String status; // 예약 현황
	private int discountRate; // 할인금액
	private int paymentPrice; // 지불 금액
	private String userId; // 사용자
	private int couponPrice; // 쿠폰 가격
	private String realUserName; // 실제 사용자 이름
	private String realUserTel; // 실제 사용자 전화번호
	private int roomNum;
	private int companyNum;
	private int headCount;
	private String companyName;
	private String roomName;
	private String userName;
	private String imageFileName;
	private int day;

	private String addr;
	private String addrDetail;
	private String roomInfo;
	private int roomPrice;
	private String couponName;
	private int sales;
	private String tel;

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public int getSales() {
		return sales;
	}

	public void setSales(int sales) {
		this.sales = sales;
	}

	public int getRoomPrice() {
		return roomPrice;
	}

	public void setRoomPrice(int roomPrice) {
		this.roomPrice = roomPrice;
	}

	public String getRoomInfo() {
		return roomInfo;
	}

	public void setRoomInfo(String roomInfo) {
		this.roomInfo = roomInfo;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getAddrDetail() {
		return addrDetail;
	}

	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}

	public int getHeadCount() {
		return headCount;
	}

	public void setHeadCount(int headCount) {
		this.headCount = headCount;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

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

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getDiscountRate() {
		return discountRate;
	}

	public void setDiscountRate(int discountRate) {
		this.discountRate = discountRate;
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

	public int getCouponPrice() {
		return couponPrice;
	}

	public void setCouponPrice(int couponPrice) {
		this.couponPrice = couponPrice;
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

	public int getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}

	public int getCompanyNum() {
		return companyNum;
	}

	public void setCompanyNum(int companyNum) {
		this.companyNum = companyNum;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

}
