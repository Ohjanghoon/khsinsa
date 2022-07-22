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
 * Servlet implementation class CommunityEditServlet
 */
@WebServlet("/share/shareEdit")
public class CommunityEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String no = request.getParameter("no");
			Community community = communityService.findByNo(no);
			request.setAttribute("community", community);
			request.getRequestDispatcher("/WEB-INF/views/share_community/shareEdit.jsp")
			.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 입력값
			String no = request.getParameter("no");
			String writer = request.getParameter("writer");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			Community community = new Community(no, writer, title, content, null, 0, 0 );
			
			// 2. 업무로직
			int result = communityService.editCommunity(community);
			System.out.println("ccc : " + community);
			
			// 3. redirect
			request.getSession().setAttribute("msg", "게시글을 성공적으로 수정했습니다.");
			response.sendRedirect(request.getContextPath() + "/share/shareView?no=" + no);
			
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
