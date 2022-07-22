package com.kh.sinsa.admin.controller;

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
import com.kh.sinsa.review.model.dto.Review;
import com.kh.sinsa.review.model.service.ReviewService;

/**
 * Servlet implementation class productManagementDetailServlet
 */

@WebServlet("/admin/productManagementDetail")
public class productManagementDetailServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private ProductService productService = new ProductService();
	private ReviewService reviewService = new ReviewService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
			String proNo = request.getParameter("proNo");
			
			// 업무처리
			Product product = productService.findByProNo(proNo);
			
			List<ProductAttachment> attachList = productService.findProductAttachmentByProductProNo(proNo);
			
			int totalReview = reviewService.getTotalReview(proNo);
			int numPerPage = 1;
			int totalPage = (int) Math.ceil((double) totalReview/ numPerPage);
			
			// view 처리
			request.setAttribute("proNo", proNo);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("product", product);
			request.setAttribute("attachList", attachList);
			request.getRequestDispatcher("/WEB-INF/views/product/productDetail.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}

