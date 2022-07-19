package com.kh.sinsa.inquire.model.dto;



public class Attachment {
	private int no;
	private int boardNo;
	private String originalFilename;
	private String renamedFilename;

	public Attachment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Attachment(int no, int boardNo, String originalFilename, String renamedFilename) {
		super();
		this.no = no;
		this.boardNo = boardNo;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
	
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
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
		return "Attachment [no=" + no + ", boardNo=" + boardNo + ", originalFilename=" + originalFilename
				+ ", renamedFilename=" + renamedFilename +"]";
	}
	
	
	
	
}
