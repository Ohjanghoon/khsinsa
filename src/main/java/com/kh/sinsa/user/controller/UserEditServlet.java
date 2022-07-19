package com.kh.sinsa.user.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.service.AdminService;

/**
 * Servlet implementation class UserEditServlet
 * 
 * 회원 정보 수정
 * 
 * 
 * 
 */
@WebServlet("/mypage/myUserEdit")
public class UserEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService userService = new AdminService();

//	editUser = update user set  user_name = ?, birthday = ?, email = ?, phone = ?, address = ? where user_id = ?
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/user/mypage/userEdit.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// 1. 사용자 입력값 처리
			String userId = request.getParameter("userId");
			String userName = request.getParameter("userName");
			String _birthday = request.getParameter("birthday");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String address = request.getParameter("address");

			Date birthday = (_birthday != null & !"".equals(_birthday)) ? Date.valueOf(_birthday) : null;

			User user = new User(userId, null, userName, null, birthday, null, email, phone, address, null);

			System.out.println("user@UserEnrollServlet = " + user);

			// 2. 업무로직
			int result = userService.editUser(user);

			// 3. 응답 리다이렉트
			HttpSession session = request.getSession();
			String msg = "";

			if (result > 0) {
				msg = "회원정보 수정성공!";
				// 세션 정보 갱신
				session.setAttribute("loginUser", userService.findById(userId));
			}

			session.setAttribute("msg", msg);
			response.sendRedirect(request.getContextPath() + "/user/userView"); // 여기 path 어쩌지..
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
