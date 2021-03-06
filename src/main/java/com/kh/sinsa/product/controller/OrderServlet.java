package com.kh.sinsa.product.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.product.model.service.ProductService;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.service.UserService;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/product/order")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private  UserService userService = new UserService();
	private ProductService productService = new ProductService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {

			// 사용자 입력값
			String size = request.getParameter("size");
			int orderAmount = Integer.parseInt(request.getParameter("orderAmount"));
			String proNo = request.getParameter("proNo");
			
			// 업무로직
			Product product = productService.findByProNo(proNo);
			List<ProductAttachment> attachList = productService.findProductAttachmentByProductProNo(proNo);
			
			
			// view 처리
			request.setAttribute("attachList", attachList);
			request.setAttribute("size", size);
			request.setAttribute("orderAmount", orderAmount);
			request.setAttribute("product", product);
			request.getRequestDispatcher("/WEB-INF/views/product/order.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
		
	}

}
