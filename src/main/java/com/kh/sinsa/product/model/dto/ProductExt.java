package com.kh.sinsa.product.model.dto;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ProductExt extends Product{
	
	private String proOriginalFilename;
	private List<ProductAttachment> productAttachment = new ArrayList<>();

	public ProductExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductExt(String proNo, String proType, String proName, int proPrice, String proSize, Timestamp regDate,
			String proContent, String proOriginalFilename2) {
		super(proNo, proType, proName, proPrice, proSize, regDate, proContent);
		// TODO Auto-generated constructor stub
	}

	public String getProOriginalFilename() {
		return proOriginalFilename;
	}

	public void setProOriginalFilename(String proOriginalFilename) {
		this.proOriginalFilename = proOriginalFilename;
	}

	public List<ProductAttachment> getProductAttachment() {
		return productAttachment;
	}

	public void setProductAttachment(List<ProductAttachment> productAttachment) {
		this.productAttachment = productAttachment;
	}

	@Override
	public String toString() {
		return "ProductExt [proOriginalFilename=" + proOriginalFilename + ", productAttachment=" + productAttachment
				+ ", toString()=" + super.toString() + "]";
	}

}
