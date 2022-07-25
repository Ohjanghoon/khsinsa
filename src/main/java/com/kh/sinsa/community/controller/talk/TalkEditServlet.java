package com.kh.sinsa.community.controller.talk;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.sinsa.common.KhsinsaRenamePolicy;
import com.kh.sinsa.community.model.dto.CommunityAttachment;
import com.kh.sinsa.community.model.dto.CommunityExt;
import com.kh.sinsa.community.model.service.CommunityService;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * Servlet implementation class TalkEditServlet
 */
@WebServlet("/community/talkEdit")
public class TalkEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String no = request.getParameter("no");
			String commNo = request.getParameter("no");
					
			CommunityExt community = communityService.findByNo(no);
			List<CommunityAttachment> attach = communityService.findTalkAttachmentByCommNo(commNo);
			
			request.setAttribute("community", community);
			request.setAttribute("attach", attach);
			request.getRequestDispatcher("/WEB-INF/views/talk/talkEdit.jsp")
				.forward(request, response);
			
			System.out.println("1 comm : " + attach);
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 서버컴퓨터 파일저장
			ServletContext application = getServletContext();
			String saveDirectory = application.getRealPath("/upload/talk");
			int maxPostSize = 1024 * 1024 * 10; // 10MB
			String encoding = "utf-8";
			FileRenamePolicy policy = new KhsinsaRenamePolicy(); 
						
			MultipartRequest multiReq = new MultipartRequest(
					request, saveDirectory, maxPostSize, encoding, policy);
				
			// 2. db update처리
			// 삭제파일 처리
			String[] delFiles = multiReq.getParameterValues("delFile");
			if(delFiles != null) {
				for(String temp : delFiles) {
					String attachNo = temp;
					// 첨부파일 삭제
					CommunityAttachment attach = communityService.findTalkAttachmentByNo(attachNo);
					File delFile = new File(saveDirectory, attach.getRenamedFilename());
					delFile.delete();
					// db 레코드 삭제
					int result = communityService.deleteTalkAttachment(attachNo);
					System.out.println("[첨부파일 " + attachNo + "번 삭제! : " + attach.getRenamedFilename());
				}
			}
			
			// 3. 입력값
			String no = multiReq.getParameter("no");
			String writer = multiReq.getParameter("writer");
			String title = multiReq.getParameter("title");
			String content = multiReq.getParameter("content");
			CommunityExt community = new CommunityExt(no, writer, title, content, null, 0, 0);
			
			Enumeration<String> filenames = multiReq.getFileNames();
			while(filenames.hasMoreElements()) {
				String filename = filenames.nextElement();
				File commUpFile = multiReq.getFile(filename);
				if(commUpFile != null) {
					CommunityAttachment attach = new CommunityAttachment();
					attach.setCommNo(no); // 게시글 번호 PK
					attach.setOriginalFilename(multiReq.getOriginalFileName(filename));
					attach.setRenamedFilename(multiReq.getFilesystemName(filename));
					community.addAttachment(attach);
				}
			}
			
			// 4. 업무로직
			int result = communityService.editTalk(community);
			System.out.println("ccc : " + community);
			
			// 5. redirect
			request.getSession().setAttribute("msg", "게시글을 성공적으로 수정했습니다.");
			response.sendRedirect(request.getContextPath() + "/community/talkView?no=" + no);
			
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
