package com.member;

public class MemberDTO {
	private String userId;
	private String userName;
	private String userPwd;
	private String reg_date;
	private String nickName;
	private String birth;
	private String email, email1, email2;
	private String tel, tel1, tel2, tel3;
	private int enabled;
	private int roll;
	private String modify_date;
	private int mAlarm;
	private int pAlarm;
	private int eAlarm;
	private int sAlarm;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getreg_date() {
		return reg_date;
	}

	public void setReg_date(String register_date) {
		this.reg_date = register_date;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getTel3() {
		return tel3;
	}

	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}

	public int getEnabled() {
		return enabled;
	}

	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}

	public int getRoll() {
		return roll;
	}

	public void setRoll(int roll) {
		this.roll = roll;
	}

	public String getModify_date() {
		return modify_date;
	}

	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}

	public int getmAlarm() {
		return mAlarm;
	}

	public void setmAlarm(int mAlarm) {
		this.mAlarm = mAlarm;
	}

	public int getpAlarm() {
		return pAlarm;
	}

	public void setpAlarm(int pAlarm) {
		this.pAlarm = pAlarm;
	}

	public int geteAlarm() {
		return eAlarm;
	}

	public void seteAlarm(int eAlarm) {
		this.eAlarm = eAlarm;
	}

	public int getsAlarm() {
		return sAlarm;
	}

	public void setsAlarm(int sAlarm) {
		this.sAlarm = sAlarm;
	}

}