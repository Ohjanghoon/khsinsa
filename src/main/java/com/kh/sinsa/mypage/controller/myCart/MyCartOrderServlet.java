package com.kh.sinsa.mypage.controller.myCart;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.cart.model.dto.Cart;
import com.kh.sinsa.product.model.service.ProductService;

/**
 * Servlet implementation class MyCartOrderServlet
 */
@WebServlet("/product/order/cartOrder")
public class MyCartOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductService productService = new ProductService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Cart> cartList = new ArrayList<>();
		
		try {
			//1. 사용자 입력값 처리
			String[] cartOrder = request.getParameterValues("proNo");
			//System.out.println("cartOrder = " + Arrays.toString(cartOrder));
			for(String cart : cartOrder) {
				String[] splitCart = cart.split("/");
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
