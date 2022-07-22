package com.kh.sinsa.inquire.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class InquireExt extends Inquire{

	private int answerStatus;
	private List<Attachment> attachments = new ArrayList<>();
	private int attachCount;
	
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
	
	

	public int getAttachCount() {
		return attachCount;
	}

	public void setAttachCount(int attachCount) {
		this.attachCount = attachCount;
	}

	public List<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}

	@Override
	public String toString() {
		return "InquireExt [answerStatus=" + answerStatus + ", attachments=" + attachments + ", attachCount="
				+ attachCount + "]";
	}

	public void addAttachment(Attachment attach) {
		this.attachments.add(attach);
		
	}








	
}
