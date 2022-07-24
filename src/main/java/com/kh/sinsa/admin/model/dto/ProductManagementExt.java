package com.kh.sinsa.admin.model.dto;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;

public class ProductManagementExt extends Product{
	
	private int productAttachCount;
	private List<ProductAttachment> productAttachmentList = new ArrayList<>();

	public ProductManagementExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductManagementExt(String proNo, String proType, String proName, int proPrice, String proSize, Timestamp regDate,
			String proContent) {
		super(proNo, proType, proName, proPrice, proSize, regDate, proContent);
	}
	
	
	
	public int getProductAttachCount() {
		return productAttachCount;
	}

	public void setProductAttachCount(int productAttachCount) {
		this.productAttachCount = productAttachCount;
	}

	public List<ProductAttachment> getProductAttachmentList() {
		return productAttachmentList;
	}

	public void setProductAttachmentList(List<ProductAttachment> productAttachmentList) {
		this.productAttachmentList = productAttachmentList;
	}
	
	public void addProductAttachment(ProductAttachment productAttach) {
		this.productAttachmentList.add(productAttach);
	}

	@Override
	public String toString() {
		return "ProductManagementExt [productAttachCount=" + productAttachCount + ", productAttachmentList=" + productAttachmentList
				+ ", toString()=" + super.toString() + "]";
	}

}

