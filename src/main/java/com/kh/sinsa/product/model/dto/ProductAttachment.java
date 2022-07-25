package com.kh.sinsa.product.model.dto;

import java.util.Objects;

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

	@Override
	public int hashCode() {
		return Objects.hash(proAttachmentNo, proNo, proOriginalFilename, proRenameFilename);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProductAttachment other = (ProductAttachment) obj;
		return proAttachmentNo == other.proAttachmentNo && Objects.equals(proNo, other.proNo)
				&& Objects.equals(proOriginalFilename, other.proOriginalFilename)
				&& Objects.equals(proRenameFilename, other.proRenameFilename);
	}
	
	
}
