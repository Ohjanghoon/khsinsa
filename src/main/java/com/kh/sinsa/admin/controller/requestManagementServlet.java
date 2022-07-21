package com.kh.sinsa.admin.controller;

import java.io.IOException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.admin.model.service.AdminService;
import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.inquire.model.dto.Inquire;
import com.kh.sinsa.inquire.model.dto.InquireExt;
import com.kh.sinsa.inquire.model.service.InquireService;

/**
 * Servlet implementation class requestManagementServlet
 */

@WebServlet("/admin/requestManagement")
public class requestManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService(); 


		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try {
				// 1. 사용자입력값
				int numPerPage = 5;
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
				// a. content 영역
				
				
				List<Inquire> inquirelist = adminService.inquireFindAll(param);
				
				
				// b. pagebar 영역
				int totalContent = adminService.inquireGetTotalContent();
				String url = request.getRequestURI();
				String pagebar = 
						KhsinsaUtils.getPagebar(cPage, numPerPage, totalContent, url);
				
				// 3. view단처리
				request.setAttribute("inqurelist", inquirelist);
				request.setAttribute("pagebar", pagebar);
				request.getRequestDispatcher("/WEB-INF/views/admin/requestManagement.jsp")
					.forward(request, response);
			} 
			catch(Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
	
	}
