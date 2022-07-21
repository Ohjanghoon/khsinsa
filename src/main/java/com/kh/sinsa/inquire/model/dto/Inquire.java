package com.kh.sinsa.inquire.model.dto;

import java.sql.Connection;
import java.sql.Date;
import java.util.List;
import java.util.Map;

public class Inquire {

	private String inquireNo;
	private String userId;
	private String inquireAnswerRef;
	private String inquireTitle;
	private String inquireContent;
	private Date inquireDate;
	private String inquireCategory;
	
	public Inquire() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Inquire(String inquireNo, String userId, String inquireAnswerRef, String inquireTitle, String inquireContent,
			Date inquireDate, String inquireCategory) {
		super();
		this.inquireNo = inquireNo;
		this.userId = userId;
		this.inquireAnswerRef = inquireAnswerRef;
		this.inquireTitle = inquireTitle;
		this.inquireContent = inquireContent;
		this.inquireDate = inquireDate;
		this.inquireCategory = inquireCategory;
	}

	public String getInquireNo() {
		return inquireNo;
	}

	public void setInquireNo(String inquireNo) {
		this.inquireNo = inquireNo;
	}

	public  String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getInquireAnswerRef() {
		return inquireAnswerRef;
	}

	public void setInquireAnswerRef(String inquireAnswerRef) {
		this.inquireAnswerRef = inquireAnswerRef;
	}

	public String getInquireTitle() {
		return inquireTitle;
	}

	public void setInquireTitle(String inquireTitle) {
		this.inquireTitle = inquireTitle;
	}

	public String getInquireContent() {
		return inquireContent;
	}

	public void setInquireContent(String inquireContent) {
		this.inquireContent = inquireContent;
	}

	public Date getInquireDate() {
		return inquireDate;
	}

	public void setInquireDate(Date inquireDate) {
		this.inquireDate = inquireDate;
	}

	public String getInquireCategory() {
		return inquireCategory;
	}

	public void setInquireCategory(String inquireCategory) {
		this.inquireCategory = inquireCategory;
	}

	@Override
	public String toString() {
		return "Inquire [inquireNo=" + inquireNo + ", userId=" + userId + ", inquireAnswerRef=" + inquireAnswerRef
				+ ", inquireTitle=" + inquireTitle + ", inquireContent=" + inquireContent + ", inquireDate="
				+ inquireDate + ", inquireCategory=" + inquireCategory + "]";
	}






	}




	

