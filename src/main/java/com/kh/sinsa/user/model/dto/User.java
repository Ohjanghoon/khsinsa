package com.kh.sinsa.user.model.dto;

import java.sql.Timestamp;
import java.sql.Date;

public class User {
	
	private String userId;
	private String userPwd;
	private String userName;
	private UserRole userRole; // U A
	private Date userBirthday;
	private Del userDel; // Y N
	private String userEmail;
	private String userPhone;
	private String userAddress;
	private Timestamp enrollDate; // 날짜/ 시각
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public User(String userId, String userPwd, String userName, UserRole userRole, Date userBirthday, Del userDel,
			String userEmail, String userPhone, String userAddress, Timestamp enrollDate) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.userRole = userRole;
		this.userBirthday = userBirthday;
		this.userDel = userDel;
		this.userEmail = userEmail;
		this.userPhone = userPhone;
		this.userAddress = userAddress;
		this.enrollDate = enrollDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public UserRole getUserRole() {
		return userRole;
	}
	public void setUserRole(UserRole userRole) {
		this.userRole = userRole;
	}
	public Date getUserBirthday() {
		return userBirthday;
	}
	public void setUserBirthday(Date userBirthday) {
		this.userBirthday = userBirthday;
	}
	public Del getUserDel() {
		return userDel;
	}
	public void setUserDel(Del userDel) {
		this.userDel = userDel;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserAddress() {
		return userAddress;
	}
	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}
	
	public Timestamp getEnrollDate() {
		return enrollDate;
	}
	public void setEnrollDate(Timestamp enrollDate) {
		this.enrollDate = enrollDate;
	}
	
	public String getPassword() {
		// TODO Auto-generated method stub
		return userPwd;
	}
	
	
	@Override
	public String toString() {
		return "User [userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName + ", userRole=" + userRole
				+ ", userBirthday=" + userBirthday + ", userDel=" + userDel + ", userEmail=" + userEmail
				+ ", userPhone=" + userPhone + ", userAddress=" + userAddress + ", enrollDate=" + enrollDate + "]";
	}

	

}
