package com.kh.sinsa.community.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class CommunityExt extends Community {
	private int attachCount;
	private List<CommunityAttachment> attachments = new ArrayList<>();
	private int commentCount;
	
	public CommunityExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CommunityExt(String commNo, String userId, String commTitle, String commContent, Date commDate,
			int commRecommand, int commReadCount, int attachCount, List<CommunityAttachment> attachments,
			int commentCount) {
		super(commNo, userId, commTitle, commContent, commDate, commRecommand, commReadCount);
		this.attachCount = attachCount;
		this.attachments = attachments;
		this.commentCount = commentCount;
	}

	public int getAttachCount() {
		return attachCount;
	}

	public void setAttachCount(int attachCount) {
		this.attachCount = attachCount;
	}

	public List<CommunityAttachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<CommunityAttachment> attachments) {
		this.attachments = attachments;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

	@Override
	public String toString() {
		return "CommunityExt [attachCount=" + attachCount + ", attachments=" + attachments + ", commentCount="
				+ commentCount + "]";
	}
}
