package com.kh.sinsa.review.model.dto;

import java.sql.Timestamp;

public class Review {
	private String reviewNo;
	private String proNo;
	private int orderNo;
	private String reviewWriter;
	private String reviewContent;
	private String reviewOriginalFilename;
	private String reviewRenamedFilename;
	private Timestamp reviewDate;
	private int reviewRecommend;
	
	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Review(String reviewNo, String proNo, int orderNo, String reviewWriter, String reviewContent,
			String reviewOriginalFilename, String reviewRenamedFilename, Timestamp reviewDate, int reviewRecommend) {
		super();
		this.reviewNo = reviewNo;
		this.proNo = proNo;
		this.orderNo = orderNo;
		this.reviewWriter = reviewWriter;
		this.reviewContent = reviewContent;
		this.reviewOriginalFilename = reviewOriginalFilename;
		this.reviewRenamedFilename = reviewRenamedFilename;
		this.reviewDate = reviewDate;
		this.reviewRecommend = reviewRecommend;
	}

	public String getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(String reviewNo) {
		this.reviewNo = reviewNo;
	}

	public String getProNo() {
		return proNo;
	}

	public void setProNo(String proNo) {
		this.proNo = proNo;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public String getReviewWriter() {
		return reviewWriter;
	}

	public void setReviewWriter(String reviewWriter) {
		this.reviewWriter = reviewWriter;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public String getReviewOriginalFilename() {
		return reviewOriginalFilename;
	}

	public void setReviewOriginalFilename(String reviewOriginalFilename) {
		this.reviewOriginalFilename = reviewOriginalFilename;
	}

	public String getReviewRenamedFilename() {
		return reviewRenamedFilename;
	}

	public void setReviewRenamedFilename(String reviewRenamedFilename) {
		this.reviewRenamedFilename = reviewRenamedFilename;
	}

	public Timestamp getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(Timestamp reviewDate) {
		this.reviewDate = reviewDate;
	}

	public int getReviewRecommend() {
		return reviewRecommend;
	}

	public void setReviewRecommend(int reviewRecommend) {
		this.reviewRecommend = reviewRecommend;
	}

	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", proNo=" + proNo + ", orderNo=" + orderNo + ", reviewWriter="
				+ reviewWriter + ", reviewContent=" + reviewContent + ", reviewOriginalFilename="
				+ reviewOriginalFilename + ", reviewRenamedFilename=" + reviewRenamedFilename + ", reviewDate="
				+ reviewDate + ", reviewRecommend=" + reviewRecommend + "]";
	}
	
}
