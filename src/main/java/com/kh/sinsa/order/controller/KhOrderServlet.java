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
		int result = 0;
		try {
			// 사용자 입력값
			String[] proNo = request.getParameterValues("proNo");
			String userId = request.getParameter("userId");
			String orderAddress1 = request.getParameter("orderAddress1");
			String orderAddress2 = request.getParameter("orderAddress2");
			String orderPhone = request.getParameter("orderPhone");
			String orderEmail = request.getParameter("orderEmail");
			String orderReq = request.getParameter("orderReq");
			String[] _orderPrice = request.getParameterValues("orderPrice");
			String[] _orderAmount = request.getParameterValues("orderAmount");
			String orderAddress = orderAddress1 + "+" + orderAddress2;
			
			int[] orderPrice = new int[_orderPrice.length];
			for(int i = 0; i < _orderPrice.length; i++) {
				orderPrice[i] = Integer.parseInt(_orderPrice[i]);
			}
			
			int[] orderAmount = new int[_orderAmount.length];
			for(int i = 0; i < _orderAmount.length; i++) {
				orderAmount[i] = Integer.parseInt(_orderAmount[i]);
			}
			
			// 업무로직
			for(int i = 0; i < proNo.length; i++) {
				Order order = new Order(0, userId, proNo[i], orderAddress, orderPhone, orderEmail, null, orderReq, orderPrice[i], null, orderAmount[i]);
				System.out.println(order);
				result = orderService.insertOrder(order);
			}
			
			// 리다이렉트
			request.getSession().setAttribute("msg", "주문이 완료 되었습니다.");
			response.sendRedirect(request.getContextPath()+"/mypage/myOrderList"); 
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
