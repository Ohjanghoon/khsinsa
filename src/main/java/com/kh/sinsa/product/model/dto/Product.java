package com.kh.sinsa.product.model.dto;

import java.sql.Timestamp;

public class Product {
	
	private String proNo;
	private String proType;
	private String proName;
	private int proPrice;
	private String proSize;
	private Timestamp regDate;
	private String proContent;
	
	public Product() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Product(String proNo, String proType, String proName, int proPrice, String proSize, Timestamp regDate,
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

	@Override
	public String toString() {
		return "Product [proNo=" + proNo + ", proType=" + proType + ", proName=" + proName + ", proPrice=" + proPrice
				+ ", proSize=" + proSize + ", regDate=" + regDate + ", proContent=" + proContent + "]";
	}
	
}

