package com.answer;

public class MemberADTO {
	private long answerNum;
	private String content;
	private String reg_date;
	private long questionNum;

	public long getAnswerNum() {
		return answerNum;
	}

	public void setAnswerNum(long answerNum) {
		this.answerNum = answerNum;
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

	public long getQuestionNum() {
		return questionNum;
	}

	public void setQuestionNum(long questionNum) {
		this.questionNum = questionNum;
	}
}
