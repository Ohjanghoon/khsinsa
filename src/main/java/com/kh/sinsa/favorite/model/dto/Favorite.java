package com.kh.sinsa.favorite.model.dto;

public class Favorite {
	
	private String proNo;
	private String userId;
	
	public Favorite() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Favorite(String proNo, String userId) {
		super();
		this.proNo = proNo;
		this.userId = userId;
	}

	public String getProNo() {
		return proNo;
	}

	public void setProNo(String proNo) {
		this.proNo = proNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Favorite [proNo=" + proNo + ", userId=" + userId + "]";
	}
	
}
