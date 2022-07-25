package com.kh.sinsa.mypage.controller.myCart;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.cart.model.dto.Cart;
import com.kh.sinsa.mypage.model.service.MypageService;
import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.product.model.service.ProductService;
import com.kh.sinsa.user.model.dto.User;

/**
 * Servlet implementation class MyCartOrderServlet
 */
@WebServlet("/mypage/myCart/orderList")
public class MyCartOrdeListrServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Cart> cartList = new ArrayList<>();
		List<Product> proList = new ArrayList<>();
		List<ProductAttachment> proAttachList = new ArrayList<>();
		
		try {
			//1. 사용자 입력값 처리
			User loginUser = (User) request.getSession().getAttribute("loginUser");
			String userId = loginUser.getUserId();
			
			//2. 업무로직
			if(loginUser != null) {
				String[] cartOrder = request.getParameterValues("proNo");
				System.out.println("cartOrder = " + Arrays.toString(cartOrder));
				for(String cart : cartOrder) {
					String[] splitCart = cart.split("/");
					String proNo = splitCart[0];
					String cartSize = splitCart[1];
					int caryBuyStock = Integer.parseInt(splitCart[2]);
					cartList.add(new Cart(userId, proNo, caryBuyStock, cartSize, null));
					proList.add(mypageService.findByProNo(proNo));
					proAttachList.add(mypageService.findAttachByProNo(proNo));
				}
			}
			
			//3. 응답처리
			request.setAttribute("proList", proList);
			request.setAttribute("proAttachList", proAttachList);
			request.setAttribute("cartList", cartList);
			request.getRequestDispatcher("/WEB-INF/views/user/mypage/myCartOrderList.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
