package com.kh.sinsa.community.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaUtils;
import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.community.model.dto.CommunityAttachment;
import com.kh.sinsa.community.model.dto.CommunityComment;
import com.kh.sinsa.community.model.service.CommunityService;

/**
 * Servlet implementation class CommunityViewServlet
 */
@WebServlet("/share/shareView")
public class CommunityViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// 1. 사용자 입력값 처리
			String no = request.getParameter("no");
			
			System.out.println(no);

			// 읽음여부판단
			Cookie[] cookies = request.getCookies();
			String communityCookieVal = "";
			boolean hasRead = false;

			if (cookies != null) {
				for (Cookie c : cookies) {
					String name = c.getName();
					String value = c.getValue();
					if ("communityCookie".equals(name)) {
						communityCookieVal = value;
						if (value.contains("[" + no + "]")) {
							hasRead = true;
						}
						break;
					}
				}
			}

			// 쿠키처리
			if (!hasRead) {
				Cookie cookie = new Cookie("communityCookie", communityCookieVal + "[" + no + "]");
				cookie.setPath(request.getContextPath() + "/share/shareView");
				cookie.setMaxAge(24 * 60 * 60);
				response.addCookie(cookie);
				System.out.println("[communityCookie 새로 발급되었음 : " + cookie.getValue() + "]");
			}

			// 2. 업무 로직
			Community community = hasRead ?
					communityService.findByNo(no) :
						communityService.findByNo(no, hasRead);
			System.out.println("community : " + community);
			List<CommunityComment> commentList = communityService.findCommunityCommentByCommNo(no);
			
			List<CommunityAttachment> attach = communityService.findAttachmentByCommNo(no);

			// XSS공격대비 (Cross-site Scripting)
			community.setCommTitle(KhsinsaUtils.escapeXml(community.getCommTitle()));		
			community.setCommContent(KhsinsaUtils.escapeXml(community.getCommContent()));

			// 개행문자 변환처리
			community.setCommContent(KhsinsaUtils.convertLineFeedToBr(community.getCommContent()));

			// 3. view단 처리
			request.setAttribute("community", community);
			System.out.println("community : " + community);
			request.setAttribute("commentList", commentList);
			request.setAttribute("attach", attach);
			System.out.println("attach" + attach);
			request.getRequestDispatcher("/WEB-INF/views/share_community/shareView.jsp")
				.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}
}