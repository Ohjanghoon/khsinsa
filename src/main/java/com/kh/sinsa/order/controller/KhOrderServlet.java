package com.kh.sinsa.order.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.order.model.dto.Order;
import com.kh.sinsa.order.model.service.OrderService;

/**
 * Servlet implementation class KhOrderServlet
 */
@WebServlet("/order/khOrder")
public class KhOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private OrderService orderService = new OrderService();
	
    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
			String proNo = request.getParameter("proNo");
			String userId = request.getParameter("userId");
			String orderAddress = request.getParameter("orderAddress");
			String orderPhone = request.getParameter("orderPhone");
			String orderEmail = request.getParameter("orderEmail");
			String orderReq = request.getParameter("orderReq");
			int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
			int orderAmount = Integer.parseInt(request.getParameter("orderAmount"));
			
			Order order = new Order(0, userId, proNo, orderAddress, orderPhone, orderEmail, null, orderReq, orderPrice, null, orderAmount);
			
			// 업무로직
			int result = orderService.insertOrder(order);
			
			// 리다이렉트
			request.getSession().setAttribute("msg", "주문이 완료 되었습니다.");
			response.sendRedirect(request.getContextPath()+"/mypage/myOrderList"); 
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
