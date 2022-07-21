package com.kh.sinsa.inquire.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.inquire.model.dto.InquireExt;
import com.kh.sinsa.inquire.model.service.InquireService;

/**
 * Servlet implementation class InquireAddServlet
 */
@WebServlet("/inquire/inquireAdd")
public class InquireAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private InquireService inquireService = new InquireService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/inquire/inquireAdd.jsp")
		.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
//			// 0. 첨부파일처리
//			ServletContext application = getServletContext();
//			String saveDirectory = application.getRealPath("/upload/inquire");
//			System.out.println("saveDirectory = " + saveDirectory);
//			int maxPostSize = 1024 * 1024 * 10; 
//			String encoding = "utf-8";
//			FileRenamePolicy policy = new KhsinsaRenamePolicy(); 
//			
//			MultipartRequest multiReq = new MultipartRequest(
//					request, saveDirectory, maxPostSize, encoding, policy);
//	
			// 1. 사용자입력값 처리
			String userId = request.getParameter("userId");
			String inquireTitle = request.getParameter("inquireTitle");
			String inquireContent = request.getParameter("inquireContent");
			String inquireCategory = request.getParameter("inquireCategory");
			
			
			InquireExt inquire = new InquireExt(null, userId, null, inquireTitle, inquireContent, null ,inquireCategory);
	
			
//			Enumeration<String> filenames = multiReq.getFileNames();
//			while(filenames.hasMoreElements()) {
//				String filename = filenames.nextElement();
//				File upFile = multiReq.getFile(filename);
//				if(upFile != null) {
//					Attachment attach = new Attachment();
//					attach.setOriginalFilename(multiReq.getOriginalFileName(filename));
//					attach.setRenamedFilename(multiReq.getFilesystemName(filename));
//					inquire.addAttachment(attach);
//				}
//			}
//			
			
			// 2. 업무로직
			int result = inquireService.insertInquire(inquire);
			
			// 3. redirect
			request.getSession().setAttribute("msg", "게시글을 성공적으로 등록했습니다.");
			response.sendRedirect(request.getContextPath() + "/inquire/inquireList");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
