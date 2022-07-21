package com.kh.sinsa.notice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.notice.model.dto.Notice;
import com.kh.sinsa.notice.model.service.NoticeService;

/**
 * Servlet implementation class CommunityEditServlet
 */
@WebServlet("/notice/noticeEdit")
public class NoticeEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService noticeService = new NoticeService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int no =  Integer.parseInt(request.getParameter("no"));
			Notice notice = noticeService.findByNo(no);
			request.setAttribute("notice", notice);
			request.getRequestDispatcher("/WEB-INF/views/notice/noticeEdit.jsp")
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
			int no = Integer.parseInt(request.getParameter("no"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			Notice notice = new Notice(no, title, content, writer, null, 0 );
			
			// 2. 업무로직
			int result = noticeService.editNotice(notice);
			System.out.println("ccc : " + notice);
			
			// 3. redirect
			request.getSession().setAttribute("msg", "게시글을 성공적으로 수정했습니다.");
			response.sendRedirect(request.getContextPath() + "/notice/noticeView?no=" + no);
			
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
