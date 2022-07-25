package com.kh.sinsa.community.controller.talk;

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
 * Servlet implementation class TalkSearchServlet
 */
@WebServlet("/community/talkSearch")
public class TalkSearchServlet extends HttpServlet {
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
			String search = request.getParameter("search");
			
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			param.put("search", search);
			
			// 업무로직
			List<Community> list = communityService.talkSearch(param);
//			List<CommunityAttachment> attachList = communityService.findAttachmentFindAll();
			
			int codiTotalContent = communityService.getTalkTotalContent();
			String url = request.getRequestURI()+ "?search=" + search;
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, codiTotalContent, url);
			
			// view단 처리
//			request.setAttribute("attachList", attachList);
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/talk/talkList.jsp").forward(request, response);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
