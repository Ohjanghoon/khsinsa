package com.kh.sinsa.community.controller.free;

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
 * Servlet implementation class FreeCommentAddServlet
 */
@WebServlet("/community/freeCommentAdd")
public class FreeCommentAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result = 0;
		
		try {
			// 1. 사용자 입력값 처리
			String commNo = request.getParameter("commNo");
			String writer = request.getParameter("writer");
			String content = request.getParameter("content");
			CommentLevel commentLevel = CommentLevel.valueOf(Integer.parseInt(request.getParameter("commentLevel")));
			String commentRef = request.getParameter("commentRef");
			CommunityComment communityComment = new CommunityComment(null, commNo, writer, content, null, commentLevel, commentRef);
			
			// 2. 업무로직

			result = communityService.insertFreeComment(communityComment);
			System.out.println("ccccc : " + communityComment);


			
			// 3. redirect 응답
			response.sendRedirect(request.getContextPath() + "/community/freeView?no=" + commNo);
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
