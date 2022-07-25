package com.kh.sinsa.mypage.controller.myCommunity;

import java.io.IOException;
import java.sql.Array;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.mypage.model.service.MypageService;

/**
 * Servlet implementation class MyInquireDeleteServlet
 */
@WebServlet("/mypage/myInquireDel")
public class DeleteMyInquireServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			//1. 사용자 입력값 처리
			String[] inquireList = request.getParameterValues("inquireNo");
			System.out.println("inquireList@MyInquireDeleteServlet = ");
			
			if(inquireList == null) {
				request.getSession().setAttribute("msg", "선택된 문의글이 없습니다.");
			} else {
				//2. 업무 로직
				int result = mypageService.myInquireDelete(inquireList);
				//myInquireDelete = delete from inquire where inquire_no in (?)
				request.getSession().setAttribute("msg", "1:1문의글이 삭제되었습니다.");
			}
			
			//3. 응답처리
			response.sendRedirect(request.getHeader("Referer"));
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
