package com.kh.sinsa.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.service.UserService;

/**
 * Servlet implementation class UserForgotPwdServlet
 */
@WebServlet("/user/userForgotPwd")
public class UserForgotPwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/user/userForgotPwd.jsp").forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			//1. 사용자 입력값 처리
	         //입력 : userId, username , userEmail ----> MemberDto
//			request.setCharacterEncoding("UTF-8");
			String userId = request.getParameter("userId");
			String username = request.getParameter("username");
			String userEmail = request.getParameter("userEmail");
		
			
			System.out.println("userId = " + userId);
			System.out.println("username = " + username);
			System.out.println("userEmail = " + userEmail);
			
			//2. 업무로직: 이름 + 이메일 일치 여부 판단 
			User user = userService.forgotPwd(userId, username, userEmail);
			String location ="";
			
			// view단 처리
			request.setAttribute("user", user);
			System.out.println(user);
			//로그인 성공
			if(user != null) {
				request.getSession().setAttribute("msg","아이디는 [ " + user.getUserId()+"] 입니다." );
				response.sendRedirect(request.getContextPath() + "/");
			}
			//로그인 실패 (아이디가 존재하지 않는 경우 || 비밀번호가 틀린 경우)
			else {
				request.getSession().setAttribute("msg", "이름 또는 이메일가 일치하지 않습니다. ");
				response.sendRedirect(request.getContextPath() + "/");
			}
			
			
			
		} catch (Exception e) {

			
		}
	}
	
}
