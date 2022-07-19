package com.kh.sinsa.community.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaRenamePolicy;
import com.kh.sinsa.community.model.service.CommunityService;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

@WebServlet("/community/CommunityOotdAdd")
public class CommunityOotdAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.getRequestDispatcher("/WEB-INF/views/ootd_community/ootdAdd.jsp")
      .forward(request, response);
      		

	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//0.첨부파일처
		ServletContext application = getServletContext();
		String saveDirectory = application.getRealPath("upload/ootd");
		int maxPostSize = 1024 * 1024 * 10;
		FileRenamePolicy policy = new KhsinsaRenamePolicy(); 
		String encoding = "utf-8";
		
		MultipartRequest multiReq = new MultipartRequest(
				request, saveDirectory, maxPostSize, encoding, policy);
		
		//1.사용자입력값 처리
		
		
	}
}
