package com.kh.sinsa.community.model.dto;

import java.sql.Date;

public class CommunityComment {
	
	private String no;
	private String commNo;
	private String userId;
	private String commentContent;
	private Date commentDate;
	private CommentLevel commentLevel;
	private String commentRef;
	
	public CommunityComment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CommunityComment(String no, String commNo, String userId, String commentContent, Date commentDate,
			CommentLevel commentLevel, String commentRef) {
		super();
		this.no = no;
		this.commNo = commNo;
		this.userId = userId;
		this.commentContent = commentContent;
		this.commentDate = commentDate;
		this.commentLevel = commentLevel;
		this.commentRef = commentRef;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
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

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public Date getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	public CommentLevel getCommentLevel() {
		return commentLevel;
	}

	public void setCommentLevel(CommentLevel commentLevel) {
		this.commentLevel = commentLevel;
	}

	public String getCommentRef() {
		return commentRef;
	}

	public void setCommentRef(String commentRef) {
		this.commentRef = commentRef;
	}

	@Override
	public String toString() {
		return "CommunityComment [no=" + no + ", commNo=" + commNo + ", userId=" + userId + ", commentContent="
				+ commentContent + ", commentDate=" + commentDate + ", commentLevel=" + commentLevel + ", commentRef="
				+ commentRef + "]";
	}
	
	
	
}
