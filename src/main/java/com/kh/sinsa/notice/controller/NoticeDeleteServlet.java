package com.kh.sinsa.notice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.notice.model.service.NoticeService;

/**
 * Servlet implementation class noticeDeleteServlet
 */
@WebServlet("/notice/noticeDelete")
public class NoticeDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService noticeService = new NoticeService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자 입력값 처리
			int no = Integer.parseInt(request.getParameter("no"));
			System.out.println("no = " + no);
			
			// 2. 업무로직
			int result = noticeService.deleteNotice(no);
			
			// 3. 리다이렉트
			request.getSession().setAttribute("msg", "게시글 삭제 성공!");
			response.sendRedirect(request.getContextPath() + "/notice/noticeList");

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
