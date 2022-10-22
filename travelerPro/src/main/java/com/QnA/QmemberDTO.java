package com.QnA;

public class QmemberDTO {
	private long questionNum;
	private String subject;
	private String content;
	private String reg_date;
	private String userId;
	private long categoryNum;
	public long getQuestionNum() {
		return questionNum;
	}
	public void setQuestionNum(long questionNum) {
		this.questionNum = questionNum;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public long getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(long categoryNum) {
		this.categoryNum = categoryNum;
	}
	
	
	
}
