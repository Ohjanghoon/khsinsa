package com.kh.sinsa.product.controller;

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
import com.kh.sinsa.product.model.service.ProductService;

/**
 * Servlet implementation class ProductAlignServlet
 */
@WebServlet("/product/productAlign")
public class ProductAlignServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductService productService = new ProductService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			// 사용자 입력값
			int cPage = 1;
			int numPerPage = 9;
			
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			String align = request.getParameter("align");
			
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			param.put("align", align);
			
			// 업무로직
			List<Product> list = productService.productAlign(param);
			List<ProductAttachment> attachList = productService.productAttachmentFindAll();
			int totalContent = productService.getTotalContent();
			String url = request.getRequestURI();
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, totalContent, url);

			// view단 처리
			request.setAttribute("attachList", attachList);
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/product/productList.jsp").forward(request, response);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		

	}

}
