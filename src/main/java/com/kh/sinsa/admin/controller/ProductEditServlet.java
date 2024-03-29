package com.kh.sinsa.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.admin.model.dto.ProductManagementExt;
import com.kh.sinsa.admin.model.service.AdminService;
import com.kh.sinsa.common.KhsinsaRenamePolicy;
import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * Servlet implementation class ProductEditServlet
 */
@WebServlet("/admin/productManagement/productEdit")
public class ProductEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
 			String proNo = request.getParameter("proNo");
			
			//업무로직
 			Product product = adminService.findByProNo(proNo);
			List<ProductAttachment> productattachmentList = adminService.findProductAttachmentByProNo(proNo);
			
			// view처리
 			request.setAttribute("product", product);
			request.setAttribute("productattachmentList", productattachmentList);
 			request.getRequestDispatcher("/WEB-INF/views/admin/productEdit.jsp").forward(request, response);
 			
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 서버컴퓨터 파일저장
			ServletContext application = getServletContext();
			String saveDirectory = application.getRealPath("/upload/product");
			int maxPostSize = 1024 * 1024 * 10 * 30;// 10MB
			String encoding = "utf-8";
			FileRenamePolicy policy = new KhsinsaRenamePolicy(); 

			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			// 2. db update처리
			// 삭제파일 처리
			String[] delFiles = multiReq.getParameterValues("delFile");
			if(delFiles != null) {
				for(String temp : delFiles) {
					int proAttachmentNo = Integer.parseInt(temp);
					// 첨부파일 삭제
					ProductAttachment productAttach = adminService.findProductAttachmentByProAttachmentNo(proAttachmentNo);
					File delFile = new File(saveDirectory, productAttach.getProRenameFilename());
					delFile.delete();
			
					// db 레코드 삭제
					int result = adminService.deleteProductAttachment(proAttachmentNo);
				}
			}

			String proNo = multiReq.getParameter("proNo");
			String productType = multiReq.getParameter("productType");
			String proName = multiReq.getParameter("proName");
			int proPrice = Integer.parseInt(multiReq.getParameter("proPrice"));
			String proSize = multiReq.getParameter("proSize");
			String proContent = multiReq.getParameter("proContent");
			ProductManagementExt product = new ProductManagementExt(proNo, productType, proName, proPrice, proSize, null, proContent);
			
			Enumeration<String> filenames = multiReq.getFileNames();
			while(filenames.hasMoreElements()) {
					String filename = filenames.nextElement();
					File upFile = multiReq.getFile(filename);
					if(upFile != null) {
						ProductAttachment productAttach = new ProductAttachment();
						productAttach.setProNo(proNo); // 상품 번호 PK
						productAttach.setProOriginalFilename(multiReq.getOriginalFileName(filename));
						productAttach.setProRenameFilename(multiReq.getFilesystemName(filename));
						product.addProductAttachment(productAttach);
					}
			}
			
			// 2. 업무로직
			int result = adminService.productEdit(product);
			
			// 3. redirect
 			request.getSession().setAttribute("msg", "상품을 성공적으로 수정했습니다.");
 			response.sendRedirect(request.getContextPath() + "/admin/productManagement");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
