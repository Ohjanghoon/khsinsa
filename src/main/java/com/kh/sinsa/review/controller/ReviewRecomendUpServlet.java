package com.kh.sinsa.review.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.sinsa.review.model.service.ReviewService;

/**
 * Servlet implementation class ReviewRecomendUpServlet
 */
@WebServlet("/review/reviewRecommendUp")
public class ReviewRecomendUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReviewService reviewService = new ReviewService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			// 사용자 입력값
			String reviewNo = request.getParameter("reviewNo"); 
			int up = 1; // 추천 수
			
			// 업무로직
			int result = reviewService.reviewRecommendUp(reviewNo);
			
			// gson 전달 
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(result, response.getWriter());
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	
	}

}
