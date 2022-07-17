package com.kh.sinsa.product.model.dto;

public class ProductAttachment{
	private int proAttachmentNo;
	private String proNo;
	private String proOriginalFilename;
	private String proRenameFilename;
	
	public ProductAttachment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductAttachment(int proAttachmentNo, String proNo, String proOriginalFilename, String proRenameFilename) {
		super();
		this.proAttachmentNo = proAttachmentNo;
		this.proNo = proNo;
		this.proOriginalFilename = proOriginalFilename;
		this.proRenameFilename = proRenameFilename;
	}

	public int getProAttachmentNo() {
		return proAttachmentNo;
	}

	public void setProAttachmentNo(int proAttachmentNo) {
		this.proAttachmentNo = proAttachmentNo;
	}

	public String getProNo() {
		return proNo;
	}

	public void setProNo(String proNo) {
		this.proNo = proNo;
	}

	public String getProOriginalFilename() {
		return proOriginalFilename;
	}

	public void setProOriginalFilename(String proOriginalFilename) {
		this.proOriginalFilename = proOriginalFilename;
	}

	public String getProRenameFilename() {
		return proRenameFilename;
	}

	public void setProRenameFilename(String proRenameFilename) {
		this.proRenameFilename = proRenameFilename;
	}

	@Override
	public String toString() {
		return "ProductAttachment [proAttachmentNo=" + proAttachmentNo + ", proNo=" + proNo + ", proOriginalFilename="
				+ proOriginalFilename + ", proRenameFilename=" + proRenameFilename + "]";
	}
	
}
