package com.kh.sinsa.inquire.model.dto;



public class Attachment {
	private String inqAttachmentNo;
	private String inquireNo;
	private String inqOriginalFilename;
	private String inqRenamedFilename;
	public Attachment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Attachment(String inqAttachmentNo, String inquireNo, String inqOriginalFilename, String inqRenamedFilename) {
		super();
		this.inqAttachmentNo = inqAttachmentNo;
		this.inquireNo = inquireNo;
		this.inqOriginalFilename = inqOriginalFilename;
		this.inqRenamedFilename = inqRenamedFilename;
	}
	public String getInqAttachmentNo() {
		return inqAttachmentNo;
	}
	public void setInqAttachmentNo(String inqAttachmentNo) {
		this.inqAttachmentNo = inqAttachmentNo;
	}
	public String getInquireNo() {
		return inquireNo;
	}
	public void setInquireNo(String inquireNo) {
		this.inquireNo = inquireNo;
	}
	public String getInqOriginalFilename() {
		return inqOriginalFilename;
	}
	public void setInqOriginalFilename(String inqOriginalFilename) {
		this.inqOriginalFilename = inqOriginalFilename;
	}
	public String getInqRenamedFilename() {
		return inqRenamedFilename;
	}
	public void setInqRenamedFilename(String inqRenamedFilename) {
		this.inqRenamedFilename = inqRenamedFilename;
	}
	@Override
	public String toString() {
		return "Attachment [inqAttachmentNo=" + inqAttachmentNo + ", inquireNo=" + inquireNo + ", inqOriginalFilename="
				+ inqOriginalFilename + ", inqRenamedFilename=" + inqRenamedFilename + "]";
	}


	
	
	
}
