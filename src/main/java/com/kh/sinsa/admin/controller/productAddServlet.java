package com.kh.sinsa.admin.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import com.kh.sinsa.admin.model.service.AdminService;
import com.kh.sinsa.common.KhsinsaRenamePolicy;
import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.admin.model.dto.ProductManagementExt;
import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;

/**
 * Servlet implementation class topProductAddServlet
 */
@WebServlet("/admin/productManagement/productAdd")
public class productAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();
	
	/**
	 * GET 게시글 등록폼 요청
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("/WEB-INF/views/admin/productAdd.jsp")
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
			System.out.println("saveDirectory = " + saveDirectory);
			int maxPostSize = 1024 * 1024 * 10; //10MB
			String encoding = "utf-8";
			FileRenamePolicy policy = new KhsinsaRenamePolicy();
			
			MultipartRequest multiReq = new MultipartRequest(
					request, saveDirectory, maxPostSize, encoding, policy);
			
			// 1. 사용자 입력값 처리
			//insertTopProduct = insert into product (pro_no,pro_type,pro_name,pro_price,pro_size,pro_content) values ('C30' || seq_product_pro_no.nextval, ?, ?, ?, ?, ?)
//			create table product(
//			        pro_no varchar2(100) ,
//			        pro_type varchar2(30),
//			        pro_name varchar2(50) not null,
//			        pro_price number not null,
//			        pro_size varchar2(2) not null,
//			        reg_date date default current_date,
//			        pro_content varchar2(4000) not null,
//			        constraint pk_pro_no primary key(pro_no)
//			); 
			String productType = request.getParameter("productType");
			String name = request.getParameter("name");
			int price = Integer.parseInt(request.getParameter("price").trim());
			String size = request.getParameter("size");
			String content = request.getParameter("content");
			
//			public ProductExt(String proNo, String proType, String proName, int proPrice, String proSize, Timestamp regDate,
//					String proContent, String proOriginalFilename2) {
//				super(proNo, proType, proName, proPrice, proSize, regDate, proContent);
//				// TODO Auto-generated constructor stub
//			}
			
			ProductManagementExt productaddext = new ProductManagementExt(null, productType, name, price, size, null, content); 
			System.out.println("productType = " + productType + ", name = " + name + ", price = " + price + ", size = " + size + ", content = " + content);

			Map<String, Object> param = new HashMap<>();
			param.put("productType", productType);
			
			Enumeration<String> filenames = multiReq.getFileNames();
			while(filenames.hasMoreElements()) {
				String filename = filenames.nextElement();
				File imgproduct = multiReq.getFile(filename);
				if(imgproduct != null) {
					ProductAttachment productattach = new ProductAttachment();
					productattach.setProOriginalFilename(multiReq.getOriginalFileName(filename));
					productattach.setProRenameFilename(multiReq.getFilesystemName(filename));
					productaddext.addProductAttachment(productattach);
				}
			}
			
			System.out.println("productaddext = " + productaddext);
			
			// 2. 업무로직
			int result = adminService.insertProduct(productaddext, param);
			
			// 3. 리다이렉트
			request.getSession().setAttribute("msg", "상품 등록 완료입니다.");
			response.sendRedirect(request.getContextPath() + "/admin/productManagement");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
