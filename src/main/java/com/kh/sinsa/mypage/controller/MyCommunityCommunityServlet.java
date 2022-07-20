package com.kh.sinsa.mypage.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.mypage.model.service.MypageService;
import com.kh.sinsa.user.model.dto.User;

/**
 * Servlet implementation class MyCommunityCommunityServlet
 */
@WebServlet("/mypage/myCommunityCommunity")
public class MyCommunityCommunityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//1. 사용자 입력값
			int cPage = 1;
			int numPerPage = 10;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			
			User loginUser = (User) request.getSession().getAttribute("loginUser");
			String userId = "";
			List<Community> list = null;
			
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
				list = mypageService.communityListFindById(userId, param);
				//System.out.println("list@MyCommunityCommnunityServlet = " + list);
				
			}
			
			//b. pagebar 영역
			// getTotalMyInquireContent = select * from inquire where user_id = ?
			int totalMyCommunityContent = mypageService.getTotalMyCommunityContent(userId);
			//System.out.println("totalMyCommunityContent = " + totalMyCommunityContent);
			
			String url = request.getRequestURI();
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, totalMyCommunityContent, url);
			//System.out.println("pagebar = " + pagebar);
		
			//3. view단 처리
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/user/mypage/myCommunityCommunity.jsp").forward(request, response);
		} catch (Exception e) {
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
