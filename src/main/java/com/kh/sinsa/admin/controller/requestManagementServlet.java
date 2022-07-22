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
				int cPage = 1;
				int numPerPage = 5;
				try {
					cPage = Integer.parseInt(request.getParameter("cPage"));
				} catch (NumberFormatException e) {}
				
				// 2. 업무로직
				// a. content 영역 - paging query
				int start = (cPage - 1) * numPerPage + 1;
				int end = cPage * numPerPage;
				Map<String, Object> param = new HashMap<>();
				param.put("start", start);
				param.put("end", end);
				
				System.out.printf("cPage = %s, numPerPage = %s, start = %s, end = %s%n",
						cPage, numPerPage, start, end);
				List<Inquire> inquirelist = adminService.inquireFindAll(param);
				System.out.println("inquirelist = " + inquirelist);
				
				
				// b. pagebar 영역
				// select count(*) from member
				int inquireTotalContent = adminService.inquireGetTotalContent();
				System.out.println("inquireTotalContent = " + inquireTotalContent);
				String url = request.getRequestURI();
				String pagebar = KhsinsaUtils.getPagebar(cPage, numPerPage, inquireTotalContent, url);
				System.out.println("pagebar = " + pagebar);
				
				// 3. view단처리
				request.setAttribute("inquirelist", inquirelist);
				request.setAttribute("pagebar", pagebar);
				request.getRequestDispatcher("/WEB-INF/views/admin/requestManagement.jsp")
					.forward(request, response);
				System.out.println("list@requestmanagement = " + inquirelist);
			} 
			catch(Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
	
	}

