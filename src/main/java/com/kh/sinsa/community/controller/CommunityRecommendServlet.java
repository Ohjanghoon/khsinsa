package com.kh.sinsa.community.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.community.model.service.CommunityService;

/**
 * Servlet implementation class CommunityRecommendServlet
 */
@WebServlet("/community/commnityRecommend")
public class CommunityRecommendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
			String commNo = request.getParameter("commNo");
			Community community = new Community(commNo, null, null, null, null,  0, 0);
			
			// 업무로직
			int result = communityService.recommendAdd(community);
			
			// gson 전달
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(result, response.getWriter());
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
