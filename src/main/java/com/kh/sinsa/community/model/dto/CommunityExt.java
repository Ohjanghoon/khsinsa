package com.kh.sinsa.community.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;


public class CommunityExt extends Community {
	
	private int attachCount;
	private List<CommunityAttachment> attachments = new ArrayList<>();

	
	public CommunityExt() {
		super();
	}

	public CommunityExt(String commNo, String userId, String commTitle, String commContent, Date commDate,
			int commRecommand, int commReadCount, int attachCount) {
		super(commNo, userId, commTitle, commContent, commDate, commRecommand, commReadCount);
		this.attachCount = attachCount;

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
	
	public void addAttachment(CommunityAttachment attach) {
		this.attachments.add(attach);
	}



	@Override
	public String toString() {
		return "CommunityExt [attachCount=" + attachCount + ", attachments=" + attachments + ", toString()=" + super.toString()  + "]";
	}
}
