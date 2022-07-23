package com.kh.sinsa.mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.mypage.model.service.MypageService;
import com.kh.sinsa.user.model.dto.User;

/**
 * Servlet implementation class MyCartChangeStockServlet
 */
@WebServlet("/mypage/myCart/editStock")
public class MyCartEditStockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//1. 사용자 입력값 처리
			User loginUser = (User) request.getSession().getAttribute("loginUser");
			
			String userId = loginUser.getUserId();
			String proNo = request.getParameter("proNo");
			int cartBuyStock = Integer.parseInt(request.getParameter("cartBuyStock"));
			System.out.println("userId = " + userId + ", proNo = " + proNo + ", cartBuyStock = " + cartBuyStock);
			
			//2. 업무로직
			int result = mypageService.editStock(userId, proNo, cartBuyStock); 
					
			//3. 응답 처리
			request.getSession().setAttribute("msg", "수량이 변경되었습니다.");
			response.sendRedirect(request.getHeader("Referer"));
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
