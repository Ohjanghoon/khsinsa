package com.kh.sinsa.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaRenamePolicy;
import com.kh.sinsa.mypage.model.service.MypageService;
import com.kh.sinsa.review.model.dto.Review;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * Servlet implementation class ReviewAddServlet
 */
@WebServlet("/mypage/review/reviewAdd")
public class ReviewAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. 사용자 입력값 처리
		String proNo = request.getParameter("proNo");
		String orderNo = request.getParameter("orderNo");
		
		//2. view단 처리
		request.setAttribute("proNo", proNo);
		request.setAttribute("orderNo", orderNo);
		request.getRequestDispatcher("/WEB-INF/views/user/mypage/review.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			// 1. 서버컴퓨터 파일저장
			ServletContext application = getServletContext();
			String saveDirectory = application.getRealPath("/upload/review");
			int maxPostSize = 1024 * 1024 * 10 * 10; // 100MB
			String encoding = "utf-8";
			FileRenamePolicy policy = new KhsinsaRenamePolicy(); 
			
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			// 사용자 입력값
			int orderNo = Integer.parseInt(multiReq.getParameter("orderNo"));
			String proNo = multiReq.getParameter("proNo");
			String reviewWriter = multiReq.getParameter("reviewWriter");
			String reviewContent = multiReq.getParameter("reviewContent");
			Review review = new Review(null, proNo, orderNo, reviewWriter, reviewContent, null, null, null, 0); 
			
			Enumeration<String> filenames = multiReq.getFileNames();
			while(filenames.hasMoreElements()) {
				String filename = filenames.nextElement();
				File commUpFile = multiReq.getFile(filename);
				if(commUpFile != null) {
					review.setReviewOriginalFilename(multiReq.getOriginalFileName(filename));;
					review.setReviewRenamedFilename(multiReq.getFilesystemName(filename));
				}
			}
			
			// 2. 업무로직
			int result = mypageService.reviewAdd(review);
			
			// 3. redirect
			request.getSession().setAttribute("msg", "리뷰를 성공적으로 작성하였습니다.");
			response.sendRedirect(request.getContextPath() + "/mypage/myOrderList");
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

}
