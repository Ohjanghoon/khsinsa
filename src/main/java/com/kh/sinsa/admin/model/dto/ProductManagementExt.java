package com.kh.sinsa.admin.model.dto;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;

public class ProductManagementExt extends Product{
	
	private String proNo;
	private String proType;
	private String proName;
	private int proPrice;
	private String proSize;
	private Timestamp regDate;
	private String proContent;
	private int productattachcount;
	private String proOriginalFilename;
	private List<ProductAttachment> productAttachmentList = new ArrayList<>();

	public ProductManagementExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductManagementExt(String proNo, String proType, String proName, int proPrice, String proSize, Timestamp regDate,
			String proContent) {
		super();
		this.proNo = proNo;
		this.proType = proType;
		this.proName = proName;
		this.proPrice = proPrice;
		this.proSize = proSize;
		this.regDate = regDate;
		this.proContent = proContent;
	}
	
	public String getProNo() {
		return proNo;
	}

	public void setProNo(String proNo) {
		this.proNo = proNo;
	}

	public String getProType() {
		return proType;
	}

	public void setProType(String proType) {
		this.proType = proType;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public int getProPrice() {
		return proPrice;
	}

	public void setProPrice(int proPrice) {
		this.proPrice = proPrice;
	}

	public String getProSize() {
		return proSize;
	}

	public void setProSize(String proSize) {
		this.proSize = proSize;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public String getProContent() {
		return proContent;
	}

	public void setProContent(String proContent) {
		this.proContent = proContent;
	}
	
	public int getProductAttachCount() {
		return productattachcount;
	}

	public void ProductAttachCount(int attachCount) {
		this.productattachcount = productattachcount;
	}

	public String getProOriginalFilename() {
		return proOriginalFilename;
	}

	public void setProOriginalFilename(String proOriginalFilename) {
		this.proOriginalFilename = proOriginalFilename;
	}

	public List<ProductAttachment> getProductAttachmentList() {
		return productAttachmentList;
	}

	public void setProductAttachment(List<ProductAttachment> productAttachmentList) {
		this.productAttachmentList = productAttachmentList;
	}
	
	public void addProductAttachment(ProductAttachment productattach) {
		this.productAttachmentList.add(productattach);
	}

	@Override
	public String toString() {
		return "ProductAddExt [proOriginalFilename=" + proOriginalFilename + ", productAttachmentList=" + productAttachmentList
				+ ", toString()=" + super.toString() + "]";
	}

}

