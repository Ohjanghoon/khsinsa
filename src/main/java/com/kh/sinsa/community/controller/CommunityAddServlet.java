package com.kh.sinsa.community.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.community.model.service.CommunityService;

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
			// 1. 사용자 입력값 처리
			String title = request.getParameter("title");
			String writer = request.getParameter("writer");
			String content = request.getParameter("content");
			Community community = new Community(null, writer, title, content, null, 0, 0 );
			
			// 2. 업무로직
			int result = communityService.insertCommunity(community);
			System.out.println("community : " + community);
			
			// 3. 리다이렉트
			request.getSession().setAttribute("msg", "게시글 등록 완료입니다.");
			response.sendRedirect(request.getContextPath() + "/share/shareList");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
