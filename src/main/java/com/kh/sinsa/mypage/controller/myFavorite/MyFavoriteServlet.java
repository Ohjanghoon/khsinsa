package com.kh.sinsa.mypage.controller.myFavorite;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.mypage.model.service.MypageService;
import com.kh.sinsa.order.model.dto.Order;
import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.user.model.dto.User;

/**
 * Servlet implementation class MyFavoriteServlet
 */
@WebServlet("/mypage/myFavorite")
public class MyFavoriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = "";
		List<String> myFavList = null;
		List<Product> proInfoList = new ArrayList<>();
		List<ProductAttachment> proAttachList = new ArrayList<>();
		
		try {
			//1. 사용자 입력값
			int cPage = 1;
			int numPerPage = 10;
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
				myFavList = mypageService.favListFindById(userId, param);
				//System.out.println("list@MyOrderListServlet = " + list);
				
				Product proInfo = null;
				ProductAttachment proAttach = null;
				for(String proNo : myFavList) {
					proInfo = mypageService.findByProNo(proNo);
					proInfoList.add(proInfo);
					
					proAttach = mypageService.findAttachByProNo(proNo);
					proAttachList.add(proAttach);
				}
			}
			
			//b. pagebar 영역
			// getTotalMyFavListContent = select * from inquire where user_id = ?
			int totalMyFavListContent = mypageService.getTotalMyFavListContent(userId);
			//System.out.println("totalMyOrderListContent = " + totalMyOrderListContent);
			
			String url = request.getRequestURI();
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, totalMyFavListContent, url);
			//System.out.println("pagebar = " + pagebar);
			
			//3. view 응답 처리
//			System.out.println("myOrderList = " + myOrderList);
//			System.out.println("proInfoList = " + proInfoList);
//			System.out.println("proAttachList = " + proAttachList);
			
			request.setAttribute("myFavList", myFavList);
			request.setAttribute("proInfoList", proInfoList);
			request.setAttribute("proAttachList", proAttachList);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/user/mypage/myFavorite.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
