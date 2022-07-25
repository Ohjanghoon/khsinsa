package com.kh.sinsa.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.sinsa.user.model.service.UserService;

/**
 * Servlet implementation class UserDeleteServlet
 * 
 * 회원 탈퇴
 */
@WebServlet("/user/userDelete")
public class UserDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			//1. 사용자 입력값 처리
			String userId = request.getParameter("userId");
			//System.out.println("userId@UserDeleteServlet = " + userId);
			
			//2. 업무로직
			int result = userService.deleteById(userId);
			
			HttpSession session = request.getSession(false);  //세션객체가 존재하지 않으면 null 반환
			
			if(session != null) {
				session.invalidate();   //세션과 세션에 속해있는 값 삭제
			}
			//3. 응답처리
			request.getSession().setAttribute("msg", "지금까지 주신사를 이용해주셔서 감사합니다.");
			response.sendRedirect(request.getContextPath() + "/");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
