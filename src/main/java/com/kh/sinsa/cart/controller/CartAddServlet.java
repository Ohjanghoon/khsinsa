package com.kh.sinsa.cart.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.sinsa.cart.model.dto.Cart;
import com.kh.sinsa.cart.model.service.CartService;

/**
 * Servlet implementation class CartAddServlet
 */
@WebServlet("/cart/cartAdd")
public class CartAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CartService cartService = new CartService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
			String userId = request.getParameter("userId");
			String proNo = request.getParameter("proNo");
			int cartBuyStock = Integer.parseInt(request.getParameter("cartBuyStock"));
			String cartSize = request.getParameter("cartSize");
			
			Cart cart = new Cart(userId, proNo, cartBuyStock, cartSize); 
			
			// 업무로직
			int result = cartService.cartAdd(cart);
			
			// gson 전달
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(result, response.getWriter());
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
