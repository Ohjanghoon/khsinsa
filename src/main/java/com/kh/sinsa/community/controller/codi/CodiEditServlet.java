package com.kh.sinsa.community.controller.codi;

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
import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.community.model.dto.CommunityAttachment;
import com.kh.sinsa.community.model.dto.CommunityExt;
import com.kh.sinsa.community.model.service.CommunityService;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * Servlet implementation class CodiEditServlet
 */
@WebServlet("/community/codiEdit")
public class CodiEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
			String commNo = request.getParameter("commNo");
			String no = request.getParameter("commNo");
			
			// 업무로직
			Community codi = communityService.findByNo(no);
			List<CommunityAttachment> codiAttach = communityService.findAttachmentByCommNo(commNo);
			
			// view처리
			request.setAttribute("codi", codi);
			request.setAttribute("codiAttach", codiAttach);
			request.getRequestDispatcher("/WEB-INF/views/codi_community/codiEdit.jsp")
			.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 서버컴퓨터 파일저장
			ServletContext application = getServletContext();
			String saveDirectory = application.getRealPath("/upload/codi");
			int maxPostSize = 1024 * 1024 * 10 * 10; // 100MB
			String encoding = "utf-8";
			FileRenamePolicy policy = new KhsinsaRenamePolicy(); 
			
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
	
			// 2. db update처리
			// 삭제파일 처리
			String[] delFiles = multiReq.getParameterValues("delFile");
			if(delFiles != null) {
				for(String temp : delFiles) {
					String commAttachNo = temp;
					// 첨부파일 삭제
					CommunityAttachment commAttach = communityService.findCodiAttachmentByNo(commAttachNo);
					File delFile = new File(saveDirectory, commAttach.getRenamedFilename());
					delFile.delete();
					// db 레코드 삭제
					int result = communityService.deleteCodiAttachment(commAttachNo);
				}
			}
			
			
			String commNo = multiReq.getParameter("commNo");
			String commTitle = multiReq.getParameter("commTitle");
			String commContent = multiReq.getParameter("commContent");
			CommunityExt codi = new CommunityExt(commNo, null, commTitle, commContent, null, 0, 0); 
			
			Enumeration<String> filenames = multiReq.getFileNames();
			while(filenames.hasMoreElements()) {
				String filename = filenames.nextElement();
				File commUpFile = multiReq.getFile(filename);
				if(commUpFile != null) {
					CommunityAttachment attach = new CommunityAttachment();
					attach.setCommNo(commNo); // 게시글 번호 PK
					attach.setOriginalFilename(multiReq.getOriginalFileName(filename));
					attach.setRenamedFilename(multiReq.getFilesystemName(filename));
					codi.addAttachment(attach);
				}
			}
			
			// 2. 업무로직
			int result = communityService.codiEdit(codi);
			
			// 3. redirect
			request.getSession().setAttribute("msg", "게시글을 성공적으로 수정했습니다.");
			response.sendRedirect(request.getContextPath() + "/community/codiView?commNo=" + commNo);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
	}

}
