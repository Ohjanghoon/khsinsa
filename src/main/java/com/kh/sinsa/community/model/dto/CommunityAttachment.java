package com.kh.sinsa.community.model.dto;

public class CommunityAttachment {
	
	private String no;
	private String boardNo;
	private String originalFilename;
	private String renamedFilename;
	
	public CommunityAttachment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CommunityAttachment(String no, String boardNo, String originalFilename, String renamedFilename) {
		super();
		this.no = no;
		this.boardNo = boardNo;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
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
		return "CommunityAttachment [no=" + no + ", boardNo=" + boardNo + ", originalFilename=" + originalFilename
				+ ", renamedFilename=" + renamedFilename + "]";
	}
	
	
}

