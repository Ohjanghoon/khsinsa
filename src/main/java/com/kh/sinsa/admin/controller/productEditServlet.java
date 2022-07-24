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

import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.admin.model.dto.ProductManagementExt;
import com.kh.sinsa.admin.model.service.AdminService;
import com.kh.sinsa.common.KhsinsaRenamePolicy;
import com.kh.sinsa.community.model.dto.CommunityAttachment;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * Servlet implementation class productEditServlet
 */
@WebServlet("/admin/productManagement/productEdit")
public class productEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();
	/**
	 * GET 수정폼 요청
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
			request.getRequestDispatcher("/WEB-INF/views/admin/productEdit.jsp")
			.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * POST db update 요청
	 * 첨부파일이 포함된 게시글 수정
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
			// 1. 서버컴퓨터 파일저장
			ServletContext application = getServletContext();
			String saveDirectory = application.getRealPath("/upload/product");
			int maxPostSize = 1024 * 1024 * 10; // 10MB
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
					System.out.println("[첨부파일 " + proAttachmentNo + "번 삭제! : " + productAttach.getProRenameFilename());
				}
			}
			
			
			String proNo = multiReq.getParameter("proNo");
			String productType = multiReq.getParameter("productType");
			String proName = multiReq.getParameter("proName");
			int proPrice = Integer.parseInt(multiReq.getParameter("proPrice").trim());
			String proSize = multiReq.getParameter("proSize");
			String proContent = multiReq.getParameter("proContent");
			ProductManagementExt product = new ProductManagementExt(null, productType, proName, proPrice, proSize, null, proContent); 
//			pro_no,pro_type,pro_name,pro_price,pro_size,pro_content
			
			Enumeration<String> filenames = multiReq.getFileNames();
			while(filenames.hasMoreElements()) {
				String filename = filenames.nextElement();
				File imgproduct = multiReq.getFile(filename);
				if(imgproduct != null) {
					ProductAttachment productAttach = new ProductAttachment();
					productAttach.setProNo(proNo); // 상품 번호 PK
					productAttach.setProOriginalFilename(multiReq.getOriginalFileName(filename));
					productAttach.setProRenameFilename(multiReq.getFilesystemName(filename));
					product.addProductAttachment(productAttach);
				}
			}
			System.out.println("product = " + product);
			
			
			 //2. 업무로직
			int result = adminService.productEdit(product);
			 
			
			// 3. redirect
			request.getSession().setAttribute("msg", "상품을 성공적으로 수정했습니다.");
			response.sendRedirect(request.getContextPath() + "/admin/productManagement?proNo=" + proNo);
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
	}

}
