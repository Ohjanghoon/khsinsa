package com.kh.sinsa.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.service.UserService;

/**
 * Servlet implementation class AdminMemberListServlet
 */
@WebServlet("/admin/adminpage")
public class adminpageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자입력값
			int cPage = 1;
			int numPerPage = 10;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
						
			// 2. 업무로직
			// a. content 영역 - paging query
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
					
			System.out.printf("cPage = %s, numPerPage = %s, start = %s, end = %s%n",
							cPage, numPerPage, start, end);
			List<User> list = userService.findAll(param);
			System.out.println("list = " + list);
						
			
			// b. pagebar영역
			// select count(*) from member
			int totalContent = userService.getTotalContent();
			System.out.println("totalContent = " + totalContent);
			String url = request.getRequestURI();
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, totalContent, url);
			System.out.println("pagebar = " + pagebar);
						
			// 3. view단처리
			request.setAttribute("list", list);
			request.getRequestDispatcher("/WEB-INF/views/admin/adminpage.jsp")
			.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}