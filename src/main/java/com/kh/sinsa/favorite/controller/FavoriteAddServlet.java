package com.kh.sinsa.favorite.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.sinsa.favorite.model.dto.Favorite;
import com.kh.sinsa.favorite.model.service.FavoriteService;

/**
 * Servlet implementation class FavoriteAddServlet
 */
@WebServlet("/favorite/favoriteAdd")
public class FavoriteAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private FavoriteService favoriteService = new FavoriteService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
			String proNo = request.getParameter("proNo");
			String userId = request.getParameter("userId");
			System.out.println(proNo);
			System.out.println(userId);
			
			Favorite favorite = new Favorite(proNo, userId);
			
			// 업무로직
			int result = favoriteService.favoriteAdd(favorite);
			
			// gson 전달
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(result, response.getWriter());
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
