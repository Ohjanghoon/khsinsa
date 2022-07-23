package com.kh.sinsa.mypage.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.cart.model.dto.Cart;
import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.mypage.model.service.MypageService;
import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.user.model.dto.User;

/**
 * Servlet implementation class MyCartServlet
 */
@WebServlet("/mypage/myCart")
public class MyCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = "";
		List<Cart> myCartList = null;
		List<Product> proInfoList = new ArrayList<>();
		List<ProductAttachment> proAttachList = new ArrayList<>();
		
		try {
			//1. 사용자 입력값
			int cPage = 1;
			int numPerPage = 5;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			
			User loginUser = (User) request.getSession().getAttribute("loginUser");
			
			//2. 업무 로직
			//a. content 영역 - paging query
			//start, end
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			
			if(loginUser != null) {
				userId = loginUser.getUserId();
				//System.out.printf("cPage = %s, numPerPage = %s, start = %s, end = %s%n", cPage, numPerPage, start, end);
				myCartList = mypageService.cartListFindById(userId, param);
				//System.out.println("list@MyOrderListServlet = " + list);
				
				Product proInfo = null;
				ProductAttachment proAttach = null;
				for(Cart cart : myCartList) {
					proInfo = mypageService.findByProNo(cart.getProNo());
					proInfoList.add(proInfo);
					
					proAttach = mypageService.findAttachByProNo(cart.getProNo());
					proAttachList.add(proAttach);
				}
			}
			
			//b. pagebar 영역
			// getTotalMyInquireContent = select * from inquire where user_id = ?
			int totalMyOrderListContent = mypageService.getTotalMyOrderListContent(userId);
			//System.out.println("totalMyOrderListContent = " + totalMyOrderListContent);
			
			String url = request.getRequestURI();
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, totalMyOrderListContent, url);
			//System.out.println("pagebar = " + pagebar);
			
			//3. view 응답 처리
			request.setAttribute("myCartList", myCartList);
			request.setAttribute("proInfoList", proInfoList);
			request.setAttribute("proAttachList", proAttachList);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/user/mypage/myCart.jsp").forward(request,response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
