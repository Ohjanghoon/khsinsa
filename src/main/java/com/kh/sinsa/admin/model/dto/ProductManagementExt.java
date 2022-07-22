package com.kh.sinsa.admin.model.dto;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;

public class ProductManagementExt extends Product{
	
	private String proOriginalFilename;
	private List<ProductAttachment> productAttachment = new ArrayList<>();

	public ProductManagementExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductManagementExt(String proNo, String proType, String proName, int proPrice, String proSize, Timestamp regDate,
			String proContent) {
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
	
	public void addProductAttachment(ProductAttachment productattach) {
		this.productAttachment.add(productattach);
	}

	@Override
	public String toString() {
		return "ProductAddExt [proOriginalFilename=" + proOriginalFilename + ", productAttachment=" + productAttachment
				+ ", toString()=" + super.toString() + "]";
	}

}

