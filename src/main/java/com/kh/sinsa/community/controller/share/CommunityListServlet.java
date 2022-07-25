package com.kh.sinsa.community.controller.share;

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
import com.kh.sinsa.community.model.service.CommunityService;

/**
 * Servlet implementation class ShareListServlet
 */
@WebServlet("/share/shareList")
public class CommunityListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();	

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try {
				// 1. 사용자입력값
				int numPerPage = 10;
				int cPage = 1;
				try {
					cPage = Integer.parseInt(request.getParameter("cPage"));
				} catch (NumberFormatException e) {}
				int start = (cPage - 1) * numPerPage + 1;
				int end = cPage * numPerPage;
				
				Map<String, Object> param = new HashMap<>();
				param.put("start", start);
				param.put("end", end);
				
				
				// 2. 업무로직
				List<Community> list = communityService.findAll(param);
				
				
				// 페이지바
				int totalContent = communityService.getTotalContent();
				String url = request.getRequestURI();
				System.out.println("url : " + request.getRequestURI());
				String pagebar = 
						KhsinsaUtils.getPagebar(cPage, numPerPage, totalContent, url);
				System.out.println("cpage = " + cPage + " numPerPage = " + numPerPage + "totalContent" + totalContent + "url : " + url);
				
				// 3. view단 처리
				request.setAttribute("list", list);
				request.setAttribute("pagebar", pagebar);
				request.getRequestDispatcher("/WEB-INF/views/share_community/shareList.jsp")
				.forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}

	}


}

