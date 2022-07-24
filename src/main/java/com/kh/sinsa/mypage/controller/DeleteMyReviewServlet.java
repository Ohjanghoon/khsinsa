package com.kh.sinsa.mypage.controller;

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
@WebServlet("/mypage/myReviewDel")
public class DeleteMyReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			//1. 사용자 입력값 처리
			String[] reviewList = request.getParameterValues("reviewNo");
			System.out.println("reviewList@MyReviewDeleteServlet = " + reviewList);
			
			if(reviewList == null) {
				request.getSession().setAttribute("msg", "선택된 리뷰글이 없습니다.");
			} else {
				//2. 업무 로직
				int result = mypageService.myReviewDelete(reviewList);
				//myInquireDelete = delete from inquire where inquire_no in (?)
				request.getSession().setAttribute("msg", "리뷰글이 삭제되었습니다.");
			}
			
			//3. 응답처리
			response.sendRedirect(request.getHeader("Referer"));
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
