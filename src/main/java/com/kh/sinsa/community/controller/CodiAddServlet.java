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
 * Servlet implementation class CodiAddServlet
 */
@WebServlet("/community/codiAdd")
public class CodiAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/codi_community/codiAdd.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 서버컴퓨터 파일저장
			ServletContext application = getServletContext();
			String saveDirectory = application.getRealPath("/upload/codi");
			int maxPostSize = 1024 * 1024 * 10 * 10; // 100MB
			String encoding = "utf-8";
			FileRenamePolicy policy = new KhsinsaRenamePolicy(); 
			
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			// 사용자 입력값
			String userId = multiReq.getParameter("userId");
			String commTitle = multiReq.getParameter("commTitle");
			String commContent = multiReq.getParameter("commContent");
			CommunityExt codi = new CommunityExt(null, userId, commTitle, commContent, null, 0, 0, 0); 
			
			Enumeration<String> filenames = multiReq.getFileNames();
			while(filenames.hasMoreElements()) {
				String filename = filenames.nextElement();
				File commUpFile = multiReq.getFile(filename);
				if(commUpFile != null) {
					CommunityAttachment attach = new CommunityAttachment();
					attach.setOriginalFilename(multiReq.getOriginalFileName(filename));
					attach.setRenamedFilename(multiReq.getFilesystemName(filename));
					codi.addAttachment(attach);
				}
			}
			
			// 2. 업무로직
			int result = communityService.codiAdd(codi);
			
			// 3. redirect
			request.getSession().setAttribute("msg", "게시글을 성공적으로 등록하였습니다.");
			response.sendRedirect(request.getContextPath() + "/community/codiList");
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
