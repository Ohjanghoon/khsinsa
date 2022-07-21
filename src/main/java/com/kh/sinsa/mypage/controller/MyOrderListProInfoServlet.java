package com.kh.sinsa.mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MyOrderListProInfoServlet
 */
@WebServlet("/mypage/myOrderList/proInfo")
public class MyOrderListProInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			//1. 사용자 입력값 처리
			String 
			//2. 업무 로직
			
			//3. 응답 json 처리 
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
