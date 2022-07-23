<%@page import="com.kh.sinsa.community.model.dto.CommentLevel"%>
<%@page import="com.kh.sinsa.community.model.dto.CommunityAttachment"%>
<%@page import="com.kh.sinsa.community.model.dto.CommunityComment"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.sinsa.community.model.dto.Community"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/codi/codiList.css" />
<%
	Community codi = (Community) request.getAttribute("codi");
	List<CommunityComment> codiCommentList = (List<CommunityComment>) request.getAttribute("codiCommentList");
	List<CommunityAttachment> codiAttach = (List<CommunityAttachment>) request.getAttribute("codiAttach"); 
%>
<main>
 <div class="container">
	<section class="py-5 text-center container">
    	<h3>How to codi</h3>
	</section>
	<nav class="py-2 bg-white border-top border-bottom" id="commnavi">
		<ul class="nav me-auto">
			<li class="nav-item"><a href="#" class="nav-link link-dark px-2">OTTD</a></li>
	   		<li class="nav-item"><a href="<%= request.getContextPath() %>/community/codiList" class="nav-link link-dark px-2">코디북</a></li>
	   		<li class="nav-item"><a href="#" class="nav-link link-dark px-2">정보공유</a></li>
	   		<li class="nav-item"><a href="#" class="nav-link link-dark px-2">자유게시판</a></li>
	   		<li class="nav-item"><a href="#" class="nav-link link-dark px-2">패션토크</a></li>
		</ul>
	</nav>
   	<br>
	<div id="gita">
 	<p>작성일 : <%= codi.getCommDate() %></p>
 	<p>조회수 : <%= codi.getCommReadCount() %></p>
	</div>
	<div class="text-center">              
		<h3><%= codi.getCommTitle() %></h3>
	 	<br>
<% for(CommunityAttachment ca : codiAttach){ %>
	 	<img src="<%= request.getContextPath() %>/upload/codi/<%= ca.getRenamedFilename() %>" class="rounded" alt="..." width="55%">
<% } %>
	 	<br><br><br>
	 	<h5><%= codi.getCommContent() %></h5>
	 	<br><br>
	</div>
    <hr><br />
    <h5>Comment</h5>
    <table class="table">
        <thead>
        </thead>
        <tbody>
<% 
	if(codiCommentList != null && !codiCommentList.isEmpty()){
		for(CommunityComment cl : codiCommentList){ 
			boolean canDelete = loginUser != null && (loginUser.getUserId().equals(cl.getUserId()) || loginUser.getUserRole() == UserRole.A);
%>
        <tr>
            <th class="<%= cl.getCommentLevel() == CommentLevel.COMMENT ? "level1" : "level2" %>"></th>
            <th scope="row"><%= cl.getUserId() %></th>
            <td><%= cl.getCommentContent() %></td>
            <td><%= cl.getCommentDate() %></td>
            <td>
<% if(cl.getCommentLevel() == CommentLevel.COMMENT){ %>            
            	<button type="button" class="btn btn-outline-success">답글</button>
<% } if(canDelete){ %>
            	<button type="button" class="btn btn-outline-danger">삭제</button>
<% } %>
            </td>
        </tr>
<% 
		}
	} else {
%>
		<tr>
			<td>여러분의 댓글이 필요해요 🥲</td>
		</tr>
<% } %>
        </tbody>
      </table>
      <br>
      <form action="">
        <div class="input-group input-group-md">
            <span class="input-group-text" id="inputGroup-sizing-md">COMMENT</span>
            <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
            <a href="#" class="btn btn-secondary btn-lg disabled" tabindex="-1" role="button" aria-disabled="true">Enter</a>
        </div>
    </form>
 </div>
</main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>