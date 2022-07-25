package com.kh.sinsa.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.admin.model.dto.ProductManagementExt;
import com.kh.sinsa.admin.model.service.AdminService;
import com.kh.sinsa.common.KhsinsaRenamePolicy;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * Servlet implementation class topProductAddServlet
 */
@WebServlet("/admin/productManagement/productTopAdd")
public class ProductTopAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();
	
	/**
	 * GET 게시글 등록폼 요청
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("/WEB-INF/views/admin/productTopAdd.jsp")
			.forward(request, response);
	}
	
	/**
	 * POST db insert 요청
	 * 
	 * 첨부파일이 포함된 게시글 등록
	 * - 1. 서버컴퓨터에 파일저장 - cos.jar
	 * 		- MultipartRequest객체 생성
	 * 			- HttpServletRequest
	 * 			- saveDirecotory
	 * 			- maxPostSize
	 * 			- encoding
	 * 			- FileRenamePolicy객체 - DefaultFileRenamePolicy(기본)
	 * 		*기존 request객체가 아닌 MultipartRequest객체에서 모든 사용자입력값을 가져와야 한다.
	 * - 2. 저장된 파일정보 attachment 레코드로 등록
	 * 
	 * 
	 */
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			// 0. 첨부파일처리
			ServletContext application = getServletContext();
			String saveDirectory = application.getRealPath("/upload/product");
			int maxPostSize = 1024 * 1024 * 10 * 10; //300MB
			String encoding = "utf-8";
			FileRenamePolicy policy = new KhsinsaRenamePolicy();
			
			MultipartRequest multiReq = new MultipartRequest(
					request, saveDirectory, maxPostSize, encoding, policy);

			// 1. 사용자 입력값 처리
			String proName = multiReq.getParameter("proName");
			String proType = multiReq.getParameter("proType");
			int proPrice = Integer.parseInt(multiReq.getParameter("proPrice"));
			String proSize = multiReq.getParameter("proSize");
			String proContent = multiReq.getParameter("proContent");
			
			
			ProductManagementExt product = new ProductManagementExt(null, proType, proName, proPrice, proSize, null, proContent); 

			Enumeration<String> filenames = multiReq.getFileNames();
			while(filenames.hasMoreElements()) {
				String filename = filenames.nextElement();
				File upFile = multiReq.getFile(filename);
				if(upFile != null) {
					ProductAttachment productAttach = new ProductAttachment();
					productAttach.setProOriginalFilename(multiReq.getOriginalFileName(filename));
					productAttach.setProRenameFilename(multiReq.getFilesystemName(filename));
					product.addProductAttachment(productAttach);
				}
			}
			
			
			// 2. 업무로직
			int result = adminService.insertTopProduct(product);
			
			// 3. 리다이렉트
			request.getSession().setAttribute("msg", "상품 등록 완료입니다.");
			response.sendRedirect(request.getContextPath() + "/admin/productManagement");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
