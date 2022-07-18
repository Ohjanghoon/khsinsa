package com.kh.sinsa.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.user.model.service.UserService;

/**
 * Servlet implementation class UserEditServlet
 * 
 * 회원 정보 수정
 */
@WebServlet("/mypage/userEdit")
public class UserEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService  userService = new UserService();
	
	/**
	 * update user set user_name = ?, user_pwd = ?, user_birthday = ?, user_email = ?, user_phone = ?, user_address = ? where member_id = ?
	 */
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			// 1. 사용자 입력값 처리 
			String userId = request.getParameter("userId");
			String userName = request.getParameter("userName");
			String _birthday = request.getParameter("birthday");
			String email = request.getParameter("email");
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		
		
	}
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/user/mypage/userEdit.jsp").forward(request,response);
	}

}
