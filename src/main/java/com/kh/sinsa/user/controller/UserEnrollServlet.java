package com.kh.sinsa.user.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.service.UserService;

/**
 * Servlet implementation class UserEnrollServlet
 * 
 * 회원가입
 */
@WebServlet("/user/userEnroll")
public class UserEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/user/userEnroll.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//1. 사용자 입력값 처리
			String userId = request.getParameter("userId");
			String userPwd = KhsinsaUtils.getEncryptedPassword(request.getParameter("userPwd"), userId);
			String userName = request.getParameter("userName");
			Date userBirth = Date.valueOf(request.getParameter("userBirth"));
			//휴대전화
			String phone1 = request.getParameter("phone1");
			String phone2 = request.getParameter("phone2");
			String userPhone = phone1 + phone2;
			//이메일
			String emailId = request.getParameter("emailId");
			String emailAddr = request.getParameter("emailAddr");
			String userEmail = emailId + "@" + emailAddr;
			//주소
			String roadAddr = request.getParameter("roadAddr");
			String roadDetail = request.getParameter("roadDetail");
			String userAddress = roadAddr + " " + roadDetail;
			
			User user = new User(userId, userPwd, userName, null, userBirth, null, userEmail, userPhone, userAddress, null);
			System.out.println("user@UserEnrollServlet = " + user);
			
			//2. 업무 로직 db에 insert
			int result = userService.insertUser(user);
			
			//3. 응답 처리
			request.getSession().setAttribute("msg", "반갑습니다, 회원가입을 축하드립니다!");
			response.sendRedirect(request.getContextPath() + "/");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
