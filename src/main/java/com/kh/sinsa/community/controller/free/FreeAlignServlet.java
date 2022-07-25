package com.kh.sinsa.community.controller.free;

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
import com.kh.sinsa.community.model.dto.CommunityAttachment;
import com.kh.sinsa.community.model.service.CommunityService;

/**
 * Servlet implementation class FreeAlignServlet
 */
@WebServlet("/community/free")
public class FreeAlignServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();   
	 
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
try {
			
			// 사용자 입력값
			int cPage = 1;
			int numPerPage = 10;
			
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			String align = request.getParameter("align");
			
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			param.put("align", align);
		
			
			// 업무로직
			List<Community> list = communityService.freeAlign(param);
			
			int totalContent = communityService.getTotalContent();
			String url = request.getRequestURI();
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, totalContent, url);

			// view단 처리
			
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/free/freeList.jsp").forward(request, response);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
