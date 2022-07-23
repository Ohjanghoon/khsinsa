package com.kh.sinsa.community.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.community.model.dto.CommentLevel;
import com.kh.sinsa.community.model.dto.CommunityComment;
import com.kh.sinsa.community.model.service.CommunityService;

/**
 * Servlet implementation class CodiCommentAdd
 */
@WebServlet("/community/codiCommentAdd")
public class CodiCommentAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자 입력값 처리
			String commNo = request.getParameter("commNo");
			String writer = request.getParameter("userId");
			String content = request.getParameter("commCommentContent");
			CommentLevel commentLevel = CommentLevel.valueOf(Integer.parseInt(request.getParameter("commCommentLevel")));
			String commentRef = request.getParameter("commCommentRef");
			CommunityComment communityComment = new CommunityComment(null, commNo, writer, content, null, commentLevel, commentRef);
			
			// 2. 업무로직
			int result = communityService.codiCommentAdd(communityComment);

			// 3. redirect 응답
			response.sendRedirect(request.getHeader("Referer"));
			
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
