package com.kh.sinsa.inquire.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.inquire.model.dto.Inquire;
import com.kh.sinsa.inquire.model.service.InquireService;

@WebServlet("/inquire/inquireView")
public class inquireViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private InquireService inquireService = new InquireService(); 


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

					request.getRequestDispatcher("/WEB-INF/views/inquire/inquireView.jsp")
						.forward(request, response);
				
			
	}
}


