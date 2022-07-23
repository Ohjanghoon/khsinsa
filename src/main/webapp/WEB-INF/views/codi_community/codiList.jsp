<%@page import="com.kh.sinsa.community.model.dto.CommunityAttachment"%>
<%@page import="com.kh.sinsa.community.model.dto.Community"%>
<%@page import="java.util.List"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/codi/codiView.css" />
<%
	List<Community> codiList = (List<Community>) request.getAttribute("codiList");
	List<CommunityAttachment> codiAttachList = (List<CommunityAttachment>) request.getAttribute("codiAttachList");
%>
<main>
	<div class="container">
	    <section class="py-5 text-center container">
	        <h3>Codi Book</h3>
	    </section>
	    <nav class="py-2 bg-light border-bottom">
	        <div class="container d-flex flex-wrap" id="moveTovar">
	          <ul class="nav me-auto">
	            <li class="nav-item"><a href="#" class="nav-link link-dark px-2">OTTD</a></li>
	            <li class="nav-item"><a href="<%= request.getContextPath() %>/community/codiView" class="nav-link link-dark px-2">코디북</a></li>
	            <li class="nav-item"><a href="#" class="nav-link link-dark px-2">정보공유</a></li>
	            <li class="nav-item"><a href="#" class="nav-link link-dark px-2">자유게시판</a></li>
	            <li class="nav-item"><a href="#" class="nav-link link-dark px-2">패션토크</a></li>
	          </ul>
	        </div>
	      </nav>
	      
	    <br><br><br>
	    <div>
	        <h3>코디북</h3>
	        <p>전문 스타일리스트가 제안하는 다양한 코디로 매일 반복되는 코디 고민을 덜어보세요.</p>
	        <p>최신 트렌드부터 누구나 입기 쉬운 룩까지 다양한 코디법을 담았습니다.</p>
	        <p>※ 부적절한 게시글/댓글의 경우 '삭제', '제한' 될 수 있는점 알려드립니다.</p>
	    </div>
	    <div class="album py-5 bg-white">
            <div class="row row-cols-3 row-cols-md-3 g-4">
<% 
	if(codiList != null && !codiList.isEmpty()){  
		for(Community codi : codiList){
			for(CommunityAttachment codiAt : codiAttachList){
				if(codi.getCommNo().equals(codiAt.getCommNo())){
%>
                <div class="col">
                    <div class="card shadow-sm">
                       	<a href="%= request.getContextPath() %>/community/communityView?commNo=<%= codi.getCommNo() %>">
                        <img src="<%= request.getContextPath() %>/upload/codi/<%= codiAt.getRenamedFilename() %>" alt="" width="100%" height="600"/>
                        </a>
                        <div class="card-body">
                            <p class="card-text">[ <%= codi.getCommTitle() %> ]</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                                    <button type="button" class="btn btn-sm btn-outline-secondary">Delete</button>
                                </div>
                                <small class="text-muted"><%= codi.getCommDate() %></small>
                            </div>
                        </div>
                    </div>
                </div>
<%
				}
			}
		}
	}
%>
	        </div>
	    </div>
	</div>
	    <p class="pagination justify-content-center"><%= request.getAttribute("pagebar") %></p>
</main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>