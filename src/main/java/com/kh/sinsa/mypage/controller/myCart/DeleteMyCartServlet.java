package com.kh.sinsa.mypage.controller.myCart;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.mypage.model.service.MypageService;
import com.kh.sinsa.user.model.dto.User;

/**
 * Servlet implementation class DeleteMyCartServlet
 */
@WebServlet("/mypage/myCartDel")
public class DeleteMyCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			//1. 사용자 입력값 처리
			User loginUser = (User) request.getSession().getAttribute("loginUser");
			
			if(loginUser != null) {
				
				String userId = loginUser.getUserId();
				String[] cartList = request.getParameterValues("proNo");
				System.out.println("cartList@DeleteMyCartServlet = " + Arrays.toString(cartList));
				
//				for(String cartNo : cartList) {
//					System.out.println("cartNo = " + cartNo);
//					String[] splitCartNo = cartNo.split("/");
//					System.out.println("proNo = " + splitCartNo[0] + ", cartSize = " + splitCartNo[1]);
//				}
				if(cartList == null) {
					request.getSession().setAttribute("msg", "선택된 상품이 없습니다.");
				} else {
					//2. 업무 로직
					int result = mypageService.myCartDelete(userId, cartList);
					//myInquireDelete = delete from inquire where inquire_no in (?)
					request.getSession().setAttribute("msg", "해당 상품이 장바구니 목록에서 제외되었습니다.");
				}
			}
			
			//3. 응답처리
			response.sendRedirect(request.getHeader("Referer"));
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
