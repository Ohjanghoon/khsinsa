package com.kh.sinsa.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.service.UserService;

/**
 * Servlet implementation class PasswordEditServlet
 * 
 * 비밀번호 수정
 */
@WebServlet("/user/userPasswordEdit")
public class PasswordEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService= new UserService();
	

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/user/userEditPwd.jsp")
		.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자 입력값 처리 
			String userId = request.getParameter("userId");
			String tempPwd = KhsinsaUtils.getEncryptedPassword(request.getParameter("tempPwd"), userId);
			String newPwd = KhsinsaUtils.getEncryptedPassword(request.getParameter("newPwd"), userId);
			System.out.println("tempPwd = " + tempPwd);
			System.out.println("newPwd = " + newPwd);
			// 2. 업무로직
			// a. 기존 비밀번호 검증
			User user = userService.findById(userId);
			String msg = null;
			String location = request.getContextPath();
			if(user != null && tempPwd.equals(user.getPassword())) {
				// b. 신규 비밀번호 업데이트
				// update user set user_pwd = ? where user_id = ?
				int result = userService.editPassword(userId, tempPwd, newPwd); 
				msg = "비밀번호를 성공적으로 변경했습니다.";
				location += "/";
			
				// 세션 비밀번호도 갱신
				User loginUser = (User) request.getSession().getAttribute("loginUser");
				loginUser.setUserPwd(newPwd);
			}
			else {
				msg = "기존 비밀번호가 일치하지 않습니다.";
				location += "/user/userPasswordEdit";
				// 3. 응답
				// a. 비밀번호 정상 변경후 내정보보기 페이지로 이동
				// b. 비밀번호 변경 실패시(기존비밀번호 불일치) 비밀번호 변경페이지로 이동
			}
				request.getSession().setAttribute("msg", msg);
				response.sendRedirect(location);
				
				
			} 
			catch (Exception e) {
				e.printStackTrace();
				throw e;
		}
	}
	
	
}




