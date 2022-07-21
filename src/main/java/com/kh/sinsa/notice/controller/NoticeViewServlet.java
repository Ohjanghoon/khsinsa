package com.kh.sinsa.notice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.notice.model.dto.Notice;
import com.kh.sinsa.notice.model.service.NoticeService;


/**
 * Servlet implementation class noticeViewServlet
 */
@WebServlet("/notice/noticeView")
public class NoticeViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService noticeService = new NoticeService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// 1. 사용자 입력값 처리
			int no = Integer.parseInt(request.getParameter("no"));

			System.out.println(no);

			// 읽음여부판단
			Cookie[] cookies = request.getCookies();
			String noticeCookieVal = "";
			boolean hasRead = false;

			if (cookies != null) {
				for (Cookie c : cookies) {
					String name = c.getName();
					String value = c.getValue();
					if ("noticeCookie".equals(name)) {
						noticeCookieVal = value;
						if (value.contains("[" + no + "]")) {
							hasRead = true;
						}
						break;
					}
				}
			}

			// 쿠키처리
			if (!hasRead) {
				Cookie cookie = new Cookie("noticeCookie", noticeCookieVal + "[" + no + "]");
				cookie.setPath(request.getContextPath() + "/notice/noticeView");
				cookie.setMaxAge(24 * 60 * 60);
				response.addCookie(cookie);
				System.out.println("[noticeCookie 새로 발급되었음 : " + cookie.getValue() + "]");
			}

			// 2. 업무 로직
			Notice notice = hasRead ? noticeService.findByNo(no) : noticeService.findByNo(no, hasRead);
			System.out.println("notice : " + notice);
			

			// XSS공격대비 (Cross-site Scripting)
			notice.setNoticeTitle(KhsinsaUtils.escapeXml(notice.getNoticeTitle()));
			notice.setNoticeContent(KhsinsaUtils.escapeXml(notice.getNoticeContent()));

			// 개행문자 변환처리
			notice.setNoticeContent(KhsinsaUtils.convertLineFeedToBr(notice.getNoticeContent()));

			// 3. view단 처리
			request.setAttribute("notice", notice);
			System.out.println("notice : " + notice);
			request.getRequestDispatcher("/WEB-INF/views/notice/noticeView.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}
}