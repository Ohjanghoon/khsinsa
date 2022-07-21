package com.kh.sinsa.inquire.controller;

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
import com.kh.sinsa.inquire.model.service.InquireService;


/**
 * Servlet implementation class InquireViewSh
 */
@WebServlet("/inquire/inquireViewSh")
public class InquireViewSh extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private InquireService inquireService = new InquireService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자입력값 처리
			int cPage = 1;
			int numPerPage = 5;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			
			String searchType = request.getParameter("searchType");
			String searchKeyword = request.getParameter("searchKeyword");
			
			Map<String, Object> param = new HashMap<>();
			param.put("searchType", searchType);
			param.put("searchKeyword", searchKeyword);
			param.put("start", (cPage - 1) * numPerPage + 1);
			param.put("end", cPage * numPerPage);
			
			// 2. 업무로직
			// a. content 영역
			List<Inquire> list = inquireService.findInquireLike(param);
			
			
			// b. pagebar 영역
			int totalContent = inquireService.getTotalContentLike(param);

			String url = request.getRequestURI() + "?searchType=" + searchType + "&searchKeyword=" + searchKeyword;
			String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, totalContent, url);
			
			// 3. view단처리
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/inquire/inquireList.jsp")
				.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
