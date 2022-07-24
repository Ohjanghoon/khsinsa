package com.kh.sinsa.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.admin.model.service.AdminService;
import com.kh.sinsa.order.model.dto.Order;

@WebServlet("/admin/orderManagement/orderStatusEdit")

public class orderStatusEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		editFree = update community set comm_title = ?, comm_content = ? where comm_no = ?
		try {
			int orderNo = Integer.parseInt(request.getParameter("orderNo"));
			Order order = adminService.findByOrderNo(orderNo);
			request.setAttribute("order", order);
			request.getRequestDispatcher("/WEB-INF/views/admin/orderManagement.jsp")
			.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 입력값
			int orderNo = Integer.parseInt(request.getParameter("orderNo"));
			String orderStatus = request.getParameter("orderStatus");
			Order order = new Order(orderNo, null, null, null, null, null, null, null, 0, orderStatus, 0);
//			?부분 어떻게 처리하지?
			
			// 2. 업무로직
			int result = adminService.editOrderStatus(order);
			
			// 3. redirect
			request.getSession().setAttribute("msg", "배송상태를 수정했습니다.");
			response.sendRedirect(request.getContextPath() + "/admin/orderManagement");
			
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}