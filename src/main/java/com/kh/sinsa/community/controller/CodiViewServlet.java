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
 * Servlet implementation class CodiViewServlet
 */
@WebServlet("/community/codiView")
public class CodiViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
			String commNo = request.getParameter("commNo");
			String no = request.getParameter("commNo");
			
			// 읽음여부판단
			Cookie[] cookies = request.getCookies();
			String communityCookieVal = "";
			boolean hasRead = false;
			
			if(cookies != null) {
				for(Cookie c : cookies) {
					String name = c.getName();
					String value = c.getValue();
					if("communityCookie".equals(name)) {
						communityCookieVal = value;
						if(value.contains("["+no+"]")) {
							hasRead = true;
						}
						break;
					}
				}
			}
			
			// 쿠키처리
			if(!hasRead) {
				Cookie cookie = new Cookie("communityCookie", communityCookieVal + "[" + no + "]");
				cookie.setPath(request.getContextPath()+ "/community/codiView");
				cookie.setMaxAge(365*24*60*60);
				response.addCookie(cookie);
			}
			
			// 업무처리
			// 코디 찾기
			Community codi = hasRead ? communityService.findByNo(no): communityService.findByNo(no, hasRead);
			// 댓글
			List<CommunityComment> codiCommentList = communityService.findCommunityCommentByCommNo(commNo);
			// 사진찾기
			List<CommunityAttachment> codiAttach = communityService.findAttachmentByCommNo(commNo);
			// 상품 찾기
			
			// XSS공격대비 (Cross-site Scripting)
			codi.setCommTitle(KhsinsaUtils.escapeXml(codi.getCommTitle()));
			codi.setCommContent(KhsinsaUtils.escapeXml(codi.getCommContent()));
			
			// 개행문자 처리
			codi.setCommContent(KhsinsaUtils.convertLineFeedToBr(codi.getCommContent()));

			// view 처리
			request.setAttribute("codi", codi);
			request.setAttribute("codiCommentList", codiCommentList);
			request.setAttribute("codiAttach", codiAttach);
			request.getRequestDispatcher("/WEB-INF/views/codi_community/codiView.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	

}
