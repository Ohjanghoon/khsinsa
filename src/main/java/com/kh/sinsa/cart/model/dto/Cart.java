package com.kh.sinsa.cart.model.dto;

import java.sql.Date;

public class Cart {
	private String userId;
	private String proNo;
	private int cartBuyStock;
	private String cartSize;
	private Date cartDate;
	
	public Cart() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Cart(String userId, String proNo, int cartBuyStock, String cartSize, Date cartDate) {
		super();
		this.userId = userId;
		this.proNo = proNo;
		this.cartBuyStock = cartBuyStock;
		this.cartSize = cartSize;
		this.cartDate = cartDate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getProNo() {
		return proNo;
	}

	public void setProNo(String proNo) {
		this.proNo = proNo;
	}

	public int getCartBuyStock() {
		return cartBuyStock;
	}

	public void setCartBuyStock(int cartBuyStock) {
		this.cartBuyStock = cartBuyStock;
	}

	public String getCartSize() {
		return cartSize;
	}

	public void setCartSize(String cartSize) {
		this.cartSize = cartSize;
	}

	public Date getCartDate() {
		return cartDate;
	}

	public void setCartDate(Date cartDate) {
		this.cartDate = cartDate;
	}

	@Override
	public String toString() {
		return "Cart [userId=" + userId + ", proNo=" + proNo + ", cartBuyStock=" + cartBuyStock + ", cartSize="
				+ cartSize + ", cartDate=" + cartDate + "]";
	}
	
}
