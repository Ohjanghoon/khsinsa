package com.kh.sinsa.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.kh.sinsa.common.TempPassword;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.service.UserService;

/**
 * Servlet implementation class UserPwdUpdate
 */
@WebServlet("/user/UserPwdUpdate")
public class UserPwdUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();
	private TempPassword tempPassword = new TempPassword();

//	updatePwd =  update kh_user set user_pwd =?  where user_id = ? and user_name = ? and user_email = ?
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			request.getRequestDispatcher("/WEB-INF/views/user/userForgotPwd.jsp").forward(request, response);
	}

	/**
	 * @param tempPassword 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response, TempPassword tempPassword)
			throws ServletException, IOException {
		try {
			// 1. 사용자 입력값 처리
			request.setCharacterEncoding("UTF-8");
//			String userId = request.getParameter("userId");
//			String username = request.getParameter("userName");
//			String emailId = request.getParameter("emailId"); // qwertyu
//			String emailAddr = request.getParameter("emailAddr"); // naver.com
//			String tempPwd = request.getParameter("tempPwd");
//			String tempPwd =  tempPassword.getRandomPassword(10);
//			String userEmail = emailId + "@" + emailAddr;
			
			User user = new User();


			// 2. 업무로직
			String tempPwd =  tempPassword.getRandomPassword(10);
			System.out.println("tempPwd = " + tempPwd);
			int result = userService.updatePwd(user, tempPwd);
			// 3. 응답 리다이렉트
			HttpSession session = request.getSession();
			String msg = "";
			
//			request.setAttribute("user", result);
			// 비밀번호 업데이트 성공
			if (result > 0) {
				msg = "비밀번호 업데이트  성공!"; 
				session.setAttribute("user", userService.editUser(user));
				request.getSession().getAttribute(tempPwd);
				System.out.println(4);
			}
			// 실패할 수가 없지...?
			else {
				request.getSession().setAttribute("msg", "정확한 회원정보를 입력해주세요. ");
			}

			String location = request.getHeader("Referer");
			response.sendRedirect(location);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	

}


