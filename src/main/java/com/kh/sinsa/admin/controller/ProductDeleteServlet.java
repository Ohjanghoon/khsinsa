package com.kh.sinsa.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.admin.model.service.AdminService;
import com.kh.sinsa.admin.model.dto.ProductManagementExt;

/**
 * Servlet implementation class ProductDeleteServlet
 */
@WebServlet("/admin/productManagement/productDelete")

public class ProductDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();

	/**
	 * 1. 저장된 첨부파일 조회 및 삭제 (java.io.File#delete) 
	 * 2. board 삭제 (on delete cascade에 의해서 attachment 연쇄 삭제)
	 * 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		try {
			// 1. 사용자입력값 처리
			String proNo = request.getParameter("proNo");
			System.out.println("prono = " + proNo);
			
			// a. 저장된 첨부파일 조회 및 삭제 (java.io.File#delete)
			List<ProductAttachment> productattachmentList = adminService.findProductAttachmentByProNo(proNo);
			System.out.println("productattachmentList = " + productattachmentList);
			if(productattachmentList != null && !productattachmentList.isEmpty()) {
				String saveDirectory = getServletContext().getRealPath("/upload/product");
				for(ProductAttachment productattach : productattachmentList) {
					File delFile = new File(saveDirectory, productattach.getProRenameFilename());
					boolean hasDeleted = delFile.delete();
					// 파일이동 
					// File destFile = new File(newDirectory, productattach.getProRenameFilename());
					// delFile.renameTo(destFile);
					System.out.println("[파일삭제 " + productattach.getProRenameFilename() + " : " + hasDeleted);
				}
			}
			
			// b. product 삭제 (on delete cascade에 의해서 productattachment 연쇄 삭제)
			int result = adminService.deleteProduct(proNo);
			
			// 3. 리다이렉트
			request.getSession().setAttribute("msg", "상품을 성공적으로 삭제했습니다.");
			response.sendRedirect(request.getContextPath() + "/admin/productManagement");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
