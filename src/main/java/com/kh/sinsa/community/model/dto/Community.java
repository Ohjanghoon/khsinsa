package com.kh.sinsa.community.model.dto;

import java.sql.Date;
import java.util.List;

public class Community {
	private String commNo;
	private String userId;
	private String commTitle;
	private String commContent;
	private Date commDate;
	private int commRecommand;
	private int commReadCount;
	
	public Community() {
		super();
	}

	public Community(String commNo, String userId, String commTitle, String commContent, Date commDate,
			int commRecommand, int commReadCount) {
		super();
		this.commNo = commNo;
		this.userId = userId;
		this.commTitle = commTitle;
		this.commContent = commContent;
		this.commDate = commDate;
		this.commRecommand = commRecommand;
		this.commReadCount = commReadCount;
	}

	public String getCommNo() {
		return commNo;
	}

	public void setCommNo(String commNo) {
		this.commNo = commNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCommTitle() {
		return commTitle;
	}

	public void setCommTitle(String commTitle) {
		this.commTitle = commTitle;
	}

	public String getCommContent() {
		return commContent;
	}

	public void setCommContent(String commContent) {
		this.commContent = commContent;
	}

	public Date getCommDate() {
		return commDate;
	}

	public void setCommDate(Date commDate) {
		this.commDate = commDate;
	}

	public int getCommRecommand() {
		return commRecommand;
	}

	public void setCommRecommand(int commRecommand) {
		this.commRecommand = commRecommand;
	}

	public int getCommReadCount() {
		return commReadCount;
	}

	public void setCommReadCount(int commReadCount) {
		this.commReadCount = commReadCount;
	}

	@Override
	public String toString() {
		return "Community [commNo=" + commNo + ", userId=" + userId + ", commTitle=" + commTitle + ", commContent="
				+ commContent + ", commDate=" + commDate + ", commRecommand=" + commRecommand + ", commReadCount="
				+ commReadCount + "]";
	}

	
	
	
}
