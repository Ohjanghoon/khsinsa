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

import com.kh.sinsa.admin.model.service.AdminService;
import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.user.model.dto.User;


/**
 * Servlet implementation class AdminMemberFinder
 */
@WebServlet("/admin/userFinder")
public class adminUserFinder extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자입력값 처리
			int cPage = 1;
			int numPerPage = 10;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			
			String searchKeyword = request.getParameter("searchKeyword");
			String searchType = request.getParameter("searchType");
			
			Map<String, Object> param = new HashMap<>();
			param.put("searchKeyword", searchKeyword);
			param.put("searchType", searchType);
			param.put("start", (cPage - 1) * numPerPage + 1);
			param.put("end", cPage * numPerPage);
			System.out.println(param);
			
			// 2. 업무로직
			// a. content 영역
			List<User> list = adminService.findUserLike(param);
			System.out.println("list = " + list);
			
			// b. pagebar 영역
			int totalContent = adminService.getTotalContentLike(param);
			System.out.println("totalContent = " + totalContent);
			String url = request.getRequestURI() + "&searchKeyword=" + searchKeyword;
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, totalContent, url);
			System.out.println("pagebar = " + pagebar);
			
			// 3. view단처리
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/admin/adminpage.jsp")
				.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
