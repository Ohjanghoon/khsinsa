package com.kh.sinsa.user.controller;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.common.TempPassword;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.service.UserService;

/**
 * Servlet implementation class UserForgotPwdServlet
 */
@WebServlet("/user/userForgotPwd")
public class UserForgotPwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();
	private TempPassword tempPassword = new TempPassword();
	
	
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
	         //입력 : userId, username , userEmail ----> UserDto
			request.setCharacterEncoding("UTF-8");
			String userId = request.getParameter("userId");
			String username = request.getParameter("username");
			String userEmail = request.getParameter("userEmail");
		
			
			System.out.println("userId = " + userId);
			System.out.println("username = " + username);
			System.out.println("userEmail = " + userEmail);
			
			//2. 업무로직: 아이디 + 이름 + 이메일 일치 여부 판단 
			User user = userService.selectOneUser(userId, username, userEmail);
			System.out.println(user);
			
			// view단 처리
			request.setAttribute("user", user);
			//비밀번호 찾기 성공
			if(user != null) {
				
				String tempPwd =  tempPassword.getRandomPassword(10);
				request.getSession().setAttribute("tempPwd", tempPwd);
				System.out.println("tempPwd = " + tempPwd);
				
				tempPwd = KhsinsaUtils.getEncryptedPassword(tempPwd, userId);
				System.out.println("tempPwd = " + tempPwd);
				
				int result = userService.updatePwd(user, tempPwd);
		      
				String location = request.getContextPath() + "/user/userLogin";
				response.sendRedirect(location);
			}
			//비밀번호 찾기 실패 (아이디, 이름, 이메일이 일치하지 않는 경우)
			else {
				request.getSession().setAttribute("msg", "정확한 회원정보를 입력해주세요. ");
				String location = request.getHeader("Referer");
				response.sendRedirect(location);
			}
				
			
			
		} catch (Exception e) {

			
		}
	}
	
	
	
}
