package com.kh.sinsa.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.service.UserService;

/**
 * Servlet implementation class CheckIdDuplicateServlet
 */
@WebServlet("/user/userEnroll/findByEmail")
public class CheckEmailDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String userEmail = request.getParameter("tempEmail");
		System.out.println("userEmail = " + userEmail);
		
		//2. 업무로직
		User user = userService.findByEmail(userEmail);
		
		boolean available = user == null;
		
		//3. 응답 json으로 작성
		String jsonStr = new Gson().toJson(available);
		System.out.println("jsonStr = " + jsonStr);
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(jsonStr);
		
	}

}
