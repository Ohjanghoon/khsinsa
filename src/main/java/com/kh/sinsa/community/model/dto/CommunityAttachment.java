package com.kh.sinsa.community.model.dto;

public class CommunityAttachment {
	
	private String no;
	private String commNo;
	private String originalFilename;
	private String renamedFilename;
	
	public CommunityAttachment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CommunityAttachment(String no, String commNo, String originalFilename, String renamedFilename) {
		super();
		this.no = no;
		this.commNo = commNo;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
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

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

	public String getRenamedFilename() {
		return renamedFilename;
	}

	public void setRenamedFilename(String renamedFilename) {
		this.renamedFilename = renamedFilename;
	}

	@Override
	public String toString() {
		return "CommunityAttachment [no=" + no + ", commNo=" + commNo + ", originalFilename=" + originalFilename
				+ ", renamedFilename=" + renamedFilename + "]";
	}
	
	
}

