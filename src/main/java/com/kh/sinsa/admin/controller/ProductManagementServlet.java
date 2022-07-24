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

import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.admin.model.dto.ProductManagementExt;
import com.kh.sinsa.admin.model.service.AdminService;

/**
 * Servlet implementation class AdminProductListServlet
 */

@WebServlet("/admin/productManagement")
public class ProductManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자입력값
			int cPage = 1;
			int numPerPage = 6;
			
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
								
			List<Product> productlist = adminService.productFindAll(param);
			List<ProductAttachment> productattachList = adminService.productAttachmentFindAll();
			
			// b. pagebar영역
			// select count(*) from member
			int producttotalContent = adminService.productGetTotalContent();
			System.out.println("producttotalContent = " + producttotalContent);
			String url = request.getRequestURI();
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, producttotalContent, url);
			System.out.println("pagebar = " + pagebar);
									
			// 3. view단처리
			request.setAttribute("productlist", productlist);
			request.setAttribute("productattachList", productattachList);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/admin/productManagement.jsp").forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		}

	}
