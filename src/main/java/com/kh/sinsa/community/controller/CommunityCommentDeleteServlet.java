package com.kh.sinsa.community.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.community.model.service.CommunityService;

/**
 * Servlet implementation class CommunityCommentDeleteServlet
 */
@WebServlet("/share/shareCommentDelete")
public class CommunityCommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자 입력값 처리
			String no = request.getParameter("no");
			System.out.println("no = " + no );
			
			// 2. 업무로직
			int result = communityService.deletecommunityComment(no);
			
			// 3. redirect
			response.sendRedirect(request.getHeader("Referer"));
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
