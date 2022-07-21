package com.kh.sinsa.inquire.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.inquire.model.service.InquireService;



@WebServlet("/inquire/inquireDelete")
public class InquireDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private InquireService inquireService = new InquireService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		try {
			// 1. 사용자입력값 처리
			String inquireNo = request.getParameter("inquireNo");			
			// 2. 업무로직
			int result = inquireService.deleteInquire(inquireNo);
			
			request.getSession().setAttribute("msg", "게시글을 성공적으로 삭제했습니다.");
			response.sendRedirect(request.getContextPath() + "/inquire/inquireList");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
