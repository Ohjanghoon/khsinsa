package com.kh.sinsa.community.controller;

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
 * Servlet implementation class codiViewServlet
 */
@WebServlet("/community/codiList")
public class CodiListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
			int cPage = 1;
			int numPerPage = 6;
			
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			
			// 업무로직
			List<Community> codiList = communityService.findCodiAll(param);
			List<CommunityAttachment> codiAttachList = communityService.findCodiAttachmentFindAll();
			
			int codiTotalContent = communityService.getCodiTotalContent();
			String url = request.getRequestURI();
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, codiTotalContent, url);

			// view단 처리
			request.setAttribute("codiAttachList", codiAttachList);
			request.setAttribute("codiList", codiList);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/codi_community/codiList.jsp").forward(request, response);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
