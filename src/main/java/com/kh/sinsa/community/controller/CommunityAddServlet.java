package com.kh.sinsa.community.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaRenamePolicy;
import com.kh.sinsa.community.model.dto.CommunityAttachment;
import com.kh.sinsa.community.model.dto.CommunityExt;
import com.kh.sinsa.community.model.service.CommunityService;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * Servlet implementation class CommunityAddServlet
 */
@WebServlet("/share/shareAdd")
public class CommunityAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();
	
	/**
	 * GET 게시글 등록폼 요청
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("/WEB-INF/views/share_community/shareAdd.jsp")
			.forward(request, response);
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 0. 첨부파일처리
			ServletContext application = getServletContext();
			String saveDirectory = application.getRealPath("/upload/share");
			System.out.println("saveDirectory = " + saveDirectory);
			int maxPostSize = 1024 * 1024 * 10; // 10MB
			String encoding = "utf-8";
			FileRenamePolicy policy = new KhsinsaRenamePolicy(); 
						
			MultipartRequest multiReq = new MultipartRequest(
					request, saveDirectory, maxPostSize, encoding, policy);
			
			// 1. 사용자 입력값 처리
			String writer = multiReq.getParameter("writer");
			String title = multiReq.getParameter("title");
			String content = multiReq.getParameter("content");
			CommunityExt community = new CommunityExt (null, writer, title, content, null, 0, 0, 0);
			System.out.println("writer = " + writer + ", title = " + title + ", content = " + content);

			Enumeration<String> filenames = multiReq.getFileNames();
			while(filenames.hasMoreElements()) {
				String filename = filenames.nextElement();
				File upFile = multiReq.getFile(filename);
				if(upFile != null) {
					CommunityAttachment attach = new CommunityAttachment();
					attach.setOriginalFilename(multiReq.getOriginalFileName(filename));
					attach.setRenamedFilename(multiReq.getFilesystemName(filename));
					community.addAttachment(attach);
				}
			}
			
			// 2. 업무로직
			int result = communityService.insertCommunity(community);
			
			// 3. 리다이렉트
			request.getSession().setAttribute("msg", "게시글 등록 완료입니다.");
			response.sendRedirect(request.getContextPath() + "/share/shareList");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
