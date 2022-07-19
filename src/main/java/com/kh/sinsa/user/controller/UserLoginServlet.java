package com.kh.sinsa.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.service.UserService;

/**
 * Servlet implementation class UserLoginServlet
 */
@WebServlet("/user/login")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/userLogin.jsp").forward(request, response);
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		try {
			// 1.사용자 입력값 처리
			String userId = request.getParameter("userId");
			String password = KhsinsaUtils.getEncryptedPassword(request.getParameter("pwd"), userId);
			String saveId = request.getParameter("saveId");	
			
			// 2.업무로직: 로그인 여부 판단 
			User user = userService.findById(userId);
			System.out.println("user@UserLoginServlet = " + user);
			
			HttpSession session = request.getSession(true); //세션이 존재하지 않으면, 새로 생성해서 반환, true 생락 가능.
			System.out.println(session.getId()); //클라이언트쪽과 동일 
			
			//로그인 성공
			if(user != null && password.equals(user.getPassword())) {
//				System.out.println("로그인 성공");
				session.setAttribute("loginUser", user);
				
				//saveId처리
				Cookie cookie = new Cookie("saveId", userId);
				cookie.setPath(request.getContextPath());// /khsinsa -> /khsinsa로 시작하는 요청주소에 cookie를 함께 전송 
			
				//saveId를 사용하는 경우
				if(saveId != null) {
					// session cookie (서버에 접속한 동안만 client에 보관)
					//persistent cookie (maxAge를 지정한 경우)
					cookie.setMaxAge(7 * 24  * 60 * 60); // 초단위로 설정 - 7일 
				}
				//saveId를 사용하지 않는 경우
				else {
					cookie.setMaxAge(0);
				}
				response.addCookie(cookie);
			}
			//로그인 실패 (아이디가 존재하지 않는 경우 || 비밀번호가 틀린 경우)
			else {
				session.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다. ");
			}
			// 3. 응답처리 : 로그인 후 url변경을 위해 리다이렉트 처리
			// 응답 302 redirect 전송.
			// 브라우저에게 location으로 재요청을 명령.
			
			response.sendRedirect(request.getContextPath());
		} catch (Exception e) {
			e.printStackTrace(); // 로깅
			throw e; // 톰캣에 예외 던짐 
		}
	}

}
