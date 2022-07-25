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
	String commNo = codi.getCommNo();
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
 	<span>추천수 : </span><span id="recommand"><%= codi.getCommRecommand() %></span>
 	<br /><br />
 	<button type="button" id="like" class="btn btn-outline-secondary">👍</button>
 	<br /><br />
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
%>
        <tr>
<%
           if(cl.getCommentLevel().equals(CommentLevel.COMMENT)){
%>
			<th>💬</th>
            <th><%= cl.getUserId() %></th>
<%} else { %>
			<td>↳</td>
            <th><%= cl.getUserId() %></th>
			
<% } %>
            <td><%= cl.getCommentContent() %></td>
            <td><%= cl.getCommentDate() %></td>
            <td>
<% if(loginUser != null) {%>
<% if(cl.getCommentLevel() == CommentLevel.COMMENT){ %>            
            	<button type="button" value="<%= cl.getNo() %>" class="btn btn-outline-primary replyComment">답글</button>
<%  } if(loginUser.getUserId().equals(cl.getUserId()) || loginUser.getUserRole() == UserRole.A){ %>
            	<button type="button" value="<%= cl.getNo() %>" class="btn btn-outline-danger deleteComment">삭제</button>
<% } } %>
            </td>
        </tr>
<% 
		}
	} else {
%>
		<tr>
			<th></th><td></td><td></td><td></td><td></td><td></td><td></td><th></th><td></td>
			<td>여러분의 댓글이 필요해요 🥲</td>
		</tr>
<% } %>
        </tbody>
      </table>
      <br>
      <form action="<%= request.getContextPath() %>/community/codiCommentAdd" name="commentFrm" method="post">
        <div class="input-group input-group-md">
        	<input type="hidden" name="commNo" value="<%= codi.getCommNo() %>" />
            <input type="hidden" name="userId" value="<%= loginUser != null ? loginUser.getUserId() : "" %>" />
            <input type="hidden" name="commCommentLevel" value="1" />
            <input type="hidden" name="commCommentRef" value="0" />  
            <span class="input-group-text" id="inputGroup-sizing-md">COMMENT</span>
            <input type="text" name="commCommentContent" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
            <button type="submit" class="btn btn-secondary btn-md">Enter</button>
        </div>
    </form>
 </div>
</main>
<form action="<%= request.getContextPath() %>/share/shareCommentDelete" method="post" name="deleteCommunityCommentFrm">
<input type="hidden" name="no" />
</form>
<script>
	// 로그인 메시징
	const loginAlert = () => {
		alert("로그인후 이용할 수 있습니다.");
	};
	
	// 댓글 등록시 유효성검사와 로그인 검사
	document.commentFrm.addEventListener('submit', (e) => {
		if(e.target.matches("form[name=commentFrm]")){		
			if(<%=loginUser == null %>){
				loginAlert();
				e.preventDefault();
				return;		
			}
			
			if(!/^(.|\n)+$/.test(e.target.content.value)){
				alert("내용을 작성해주세요.");
				e.preventDefault();
				return;			
			}
		}

	});

	// 댓글 삭제
	document.querySelectorAll(".deleteComment").forEach((btn) => {
		btn.addEventListener('click', (e) => {
			if(confirm("해당 댓글을 정말 삭제하시겠습니까?")){
				const {value} = e.target;
				const frm = document.deleteCommunityCommentFrm;
				frm.no.value = value;
				frm.submit();
			}	
		});
	});
	
	// 답글 등록
	document.querySelectorAll(".replyComment").forEach((btn) => {
		btn.addEventListener('click', (e) => {
			<% if(loginUser == null){%>
				loginAlert(); return;
			<% } %>
			
			const {value} = e.target;
			console.log(value);
			
			const tr = `
			<tr>
				<td colspan="5">
					<form name="recommentAddFrm" action="<%=request.getContextPath()%>/community/codiCommentAdd" method="post">
			            <input type="hidden" name="commNo" value="<%= codi.getCommNo() %>" />
			            <input type="hidden" name="userId" value="<%= loginUser != null ? loginUser.getUserId() : "" %>" />
			            <input type="hidden" name="commCommentLevel" value="2" />
			            <input type="hidden" name="commCommentRef" value="\${value}" />    
		            	<div class="input-group input-group-md recomand">
			                <span class="input-group-text" id="inputGroup-sizing-md">RECOMMENT</span>
			                <input type="text" name="commCommentContent" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-md">
			                <button type="submit" class="btn btn-secondary btn-md">Enter</button>
		            	</div>
			        </form>
				</td>
			</tr>`;
			
	        const target = e.target.parentElement.parentElement; 
	        target.insertAdjacentHTML('afterend', tr);
	        
		}, {once: true});
	});
	// 추천이여!!
 	document.querySelector("#like").addEventListener('click', (e) => {
 		const reco = Number(document.querySelector('#recommand').textContent) + 1;
<% if(loginUser != null){%>
 		$.ajax({
			url : '<%= request.getContextPath() %>/community/communityRecommend',
			method : 'POST',
			data : {commNo : "<%= commNo %>"},
			success(response){
				alert("해당 게시물을 추천하였습니다.");
			},
			error : console.log,
			complete(){
				document.querySelector('#recommand').innerHTML = reco;
			}
	  })
 <% } else { %>
 		loginAlert();
 <% } %>
 });
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>