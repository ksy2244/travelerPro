package com.answer;

public class FaqDTO {
	private long faqNum;
	private String subject;
	private String content;
	private String userId;
	private int categoryNum;
	
	public long getFaqNum() {
		return faqNum;
	}
	public void setFaqNum(long faqNum) {
		this.faqNum = faqNum;
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	
	
}
