package com.kh.sinsa.notice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.notice.model.dto.Notice;
import com.kh.sinsa.notice.model.service.NoticeService;



/**
 * Servlet implementation class noticeAddServlet
 */
@WebServlet("/notice/noticeAdd")
public class NoticeAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService noticeService = new NoticeService();
	
	/**
	 * GET 게시글 등록폼 요청
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("/WEB-INF/views/notice/noticeAdd.jsp")
			.forward(request, response);
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자 입력값 처리
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			Notice notice = new Notice(0, title, content, writer, null, 0);
			System.out.println("writer = " + writer + ", title = " + title + ", content = " + content);

			
			// 2. 업무로직
			int result = noticeService.insertNotice(notice);
			
			// 3. 리다이렉트
			request.getSession().setAttribute("msg", "공지사항 등록 완료입니다.");
		response.sendRedirect(request.getContextPath() + "/notice/noticeList");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
