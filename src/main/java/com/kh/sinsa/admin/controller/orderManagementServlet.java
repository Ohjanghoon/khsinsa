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
import com.kh.sinsa.order.model.dto.Order;
import com.kh.sinsa.user.model.dto.User;

/**
 * Servlet implementation class orderManagementServlet
 */
@WebServlet("/admin/orderManagement")
public class orderManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();

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
			List<Order> orderlist = adminService.orderFindAll(param);
			System.out.println("orderlist = " + orderlist);
						
			
			// b. pagebar영역
			// select count(*) from member
			int orderTotalContent = adminService.orderGetTotalContent();
			System.out.println("ordertotalContent = " + orderTotalContent);
			String url = request.getRequestURI();
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, orderTotalContent, url);
			System.out.println("pagebar = " + pagebar);
						
			// 3. view단처리
			request.setAttribute("orderlist", orderlist);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/admin/orderManagement.jsp")
			.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
