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
import com.kh.sinsa.admin.model.service.AdminService;

/**
 * Servlet implementation class productManagementDetailServlet
 */

@WebServlet("/admin/productManagementDetail")
public class productManagementDetailServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
			String proNo = request.getParameter("proNo");
			
			// 업무처리
			Product product = adminService.findByProNo(proNo);
			List<ProductAttachment> productattachList = adminService.findProductAttachmentByProductProNo(proNo);
			
			// view 처리
			request.setAttribute("product", product);
			request.setAttribute("productattachList", productattachList);
			request.getRequestDispatcher("/WEB-INF/views/admin/productManagementDetail.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}

