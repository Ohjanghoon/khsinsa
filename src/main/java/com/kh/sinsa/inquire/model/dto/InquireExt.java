package com.kh.sinsa.inquire.model.dto;

import java.sql.Date;

public class InquireExt extends Inquire{

	private int answerStatus;

	public InquireExt() {
		super();
	}

	public InquireExt(String inquireNo, String userId, String inquireAnswerRef, String inquireTitle,
			String inquireContent, Date inquireDate, String inquireCategory) {
		super(inquireNo, userId, inquireAnswerRef, inquireTitle, inquireContent, inquireDate, inquireCategory);
	}

	public int getAnswerStatus() {
		return answerStatus;
	}

	public void setAnswerStatus(int answerStatus) {
		this.answerStatus = answerStatus;
	}

	@Override
	public String toString() {
		return "InquireExt [answerStatus=" + answerStatus + ", " + super.toString() + "]";
	}



	
}
