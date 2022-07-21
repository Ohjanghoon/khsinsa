package com.kh.sinsa.community.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.community.model.service.CommunityService;

/**
 * Servlet implementation class CommunityDeleteServlet
 */
@WebServlet("/share/shareDelete")
public class CommunityDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자 입력값 처리
			String no = request.getParameter("no");
			System.out.println("no = " + no);
			
			// 2. 업무로직
			int result = communityService.deleteCommunity(no);
			
			// 3. 리다이렉트
			request.getSession().setAttribute("msg", "게시글 삭제 성공!");
			response.sendRedirect(request.getContextPath() + "/share/shareList");

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
