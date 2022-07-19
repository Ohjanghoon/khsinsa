package com.kh.sinsa.order.model.dto;

import java.sql.Timestamp;

public class Order {

	private int orderNo;
	private String userId;
	private String proNo;
	private String orderAddress;
	private String orderPhone;
	private String orderEmail;
	private Timestamp orderDate;
	private String orderReq;
	private int orderPrice;
	private String orderStatus;
	private int orderAmount;
	
	public Order() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Order(int orderNo, String userId, String proNo, String orderAddress, String orderPhone, String orderEmail,
			Timestamp orderDate, String orderReq, int orderPrice, String orderStatus, int orderAmount) {
		super();
		this.orderNo = orderNo;
		this.userId = userId;
		this.proNo = proNo;
		this.orderAddress = orderAddress;
		this.orderPhone = orderPhone;
		this.orderEmail = orderEmail;
		this.orderDate = orderDate;
		this.orderReq = orderReq;
		this.orderPrice = orderPrice;
		this.orderStatus = orderStatus;
		this.orderAmount = orderAmount;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
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

	public String getOrderAddress() {
		return orderAddress;
	}

	public void setOrderAddress(String orderAddress) {
		this.orderAddress = orderAddress;
	}

	public String getOrderPhone() {
		return orderPhone;
	}

	public void setOrderPhone(String orderPhone) {
		this.orderPhone = orderPhone;
	}

	public String getOrderEmail() {
		return orderEmail;
	}

	public void setOrderEmail(String orderEmail) {
		this.orderEmail = orderEmail;
	}

	public Timestamp getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}

	public String getOrderReq() {
		return orderReq;
	}

	public void setOrderReq(String orderReq) {
		this.orderReq = orderReq;
	}

	public int getOrderPrice() {
		return orderPrice;
	}

	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public int getOrderAmount() {
		return orderAmount;
	}

	public void setOrderAmount(int orderAmount) {
		this.orderAmount = orderAmount;
	}

	@Override
	public String toString() {
		return "Order [orderNo=" + orderNo + ", userId=" + userId + ", proNo=" + proNo + ", orderAddress="
				+ orderAddress + ", orderPhone=" + orderPhone + ", orderEmail=" + orderEmail + ", orderDate="
				+ orderDate + ", orderReq=" + orderReq + ", orderPrice=" + orderPrice + ", orderStatus=" + orderStatus
				+ ", orderAmount=" + orderAmount + "]";
	}
	
}
