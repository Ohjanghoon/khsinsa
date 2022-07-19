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
import com.kh.sinsa.inquire.model.dto.Inquire;
import com.kh.sinsa.mypage.model.service.MypageService;
import com.kh.sinsa.user.model.dto.User;

/**
 * Servlet implementation class MypagemyCommunityServlet
 */
@WebServlet("/mypage/myCommunityInquire")
public class MyCommunityInquireServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = "";
		List<Inquire> list = null;
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
				list = mypageService.inquireListFindById(userId, param);
//				System.out.println("list@AdminMemberListServlet = " + list);
				
			}
						
			//b. pagebar 영역
			// getTotalMyInquireContent = select * from inquire where user_id = ?
			int totalMyInquireContent = mypageService.getTotalMyInquireContent(userId);
			System.out.println("TotalMyInquireContent = " + totalMyInquireContent);
			
			String url = request.getRequestURI();
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, totalMyInquireContent, url);
			//System.out.println("pagebar = " + pagebar);
			
			
			//3. view 응답 처리
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/user/mypage/myCommunityInquire.jsp").forward(request, response);
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
