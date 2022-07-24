package com.kh.sinsa.review.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.sinsa.review.model.dto.Review;
import com.kh.sinsa.review.model.service.ReviewService;

/**
 * Servlet implementation class ReviewServlet
 */
@WebServlet("/review/reviewList")
public class ReviewListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReviewService reviewService = new ReviewService();
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			// 사용자 입력값
			String proNo = request.getParameter("proNo");
			int cPage = Integer.parseInt(request.getParameter("cPage"));
			int numPerPage = 3;
			int start = (cPage -1) * numPerPage + 1;
			int end = cPage * numPerPage;
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			param.put("proNo", proNo);

			// 업무로직 
			List<Review> rList = reviewService.findByReview(param);
			
			// view 처리
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(rList, response.getWriter());
			
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
		
	}

}
