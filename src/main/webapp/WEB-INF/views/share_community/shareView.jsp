<%@page import="com.kh.sinsa.community.model.dto.CommunityExt"%>
<%@page import="com.kh.sinsa.community.model.dto.CommunityAttachment"%>
<%@page import="com.kh.sinsa.community.model.dto.CommentLevel"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.kh.sinsa.community.model.dto.CommunityComment"%>
<%@page import="com.kh.sinsa.community.model.dto.Community"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/share/shareView.css" />
<%
Community community = (Community) request.getAttribute("community");
List<CommunityAttachment> attachments = (List<CommunityAttachment>) request.getAttribute("attach");
List<CommunityComment> commentList = (List<CommunityComment>) request.getAttribute("commentList");
System.out.println("############commentList = " + commentList + "########################");
String commNo = (String) request.getAttribute("no");
%>


<div class="container">

	<div id="headlist">
		<div id="header2">COMMUNITY</div>
		<nav class="navi">
			<ul>
				<li><a href="#">OOTD</a></li>
				<li><a href="#">코디북</a></li>
				<li><a href="<%= request.getContextPath()%>/share/shareList" />정보공유</a></li>
				<li><a href="#">자유게시판</a></li>
				<li><a href="#">패션토크</a></li>
			</ul>
		</nav>


	</div>
	<h2 style="font-size: 35px; color: rgb(101, 101, 252);">정보공유 게시판 <span style="font-size: 18px;"> Share Information</span>
	</h2>
	<hr style="border-top: 3px solid rgb(101, 101, 252);">
	<div class="main">

		<ul>
			<li id="title"><h2><%=community.getCommTitle()%></h2></li>
			<li id="writer"><h3><%=community.getUserId()%></h3></li>
			<li id="readCount">조회수 : <%=community.getCommReadCount()%> | 추천수 : <%=community.getCommRecommand()%>
				
				<button id="like" name="like" style="border: 0; background-color: white;">
					<img src="<%=request.getContextPath()%>/images/emptyHeart.png" alt="버튼" style="width: 20px; height: 20px;">
				</button>
			</li>
			
			<li id="date">
				<span>작성일 <%= new SimpleDateFormat("yy-MM-dd HH:mm").format(community.getCommDate()) %></span>
			</li>
			
			<hr style="color: gainsboro;">
			
			<li style="margin-top: 50px; background-color: white; height: 500px;">
			<% 
				if(attachments != null && !attachments.isEmpty()) { 
					for(CommunityAttachment attach : attachments){
			%> <img src ="<%= request.getContextPath() %>/upload/share/<%= attach.getRenamedFilename() %>" name="upload">
				<%}
					} %>
				<p><%= community.getCommContent() %></p>
			</li>
			
		
			

		<%
				boolean canEdit = loginUser != null && 
						(loginUser.getUserId().equals(community.getUserId()) 
								|| loginUser.getUserRole() == UserRole.A);
			if(canEdit){ 
		%>

			<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
			<li>
				<input type="button" value="수정하기" onclick="editCommunity()">
				<input type="button" value="삭제하기" onclick="deleteCommunity()">
			</li>
		
		<% } %>

			<hr>


	<li>
				<div class="comment-container">
					<!-- 댓글 작성부 -->
					<div class="comment-editor">
						<form name="communityCommentFrm"
							action="<%=request.getContextPath()%>/share/shareCommentAdd"
							method="post" style="border-bottom:0px;">
								<input type="hidden" name="commNo" value="<%=community.getCommNo()%>" /> 
								<input type="hidden" name="writer" value="<%= loginUser != null ? loginUser.getUserId() : "" %>" />
							<input type="hidden" name="commentLevel" value="1" /> 
							<input type="hidden" name="commentRef" value="0" />
							<textarea name="content" cols="60" rows="3" placeholder="댓글을 입력하세요."></textarea>
							<button type="submit" id="btn-comment-enroll1">등록</button>
							<br>
						</form>
					</div>
					
					
					
					<table id="tbl-comment">
						<%
						if (commentList != null && !commentList.isEmpty()) {
							SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
							for (CommunityComment cc : commentList) {
								boolean canDelete = loginUser != null
								&& (loginUser.getUserId().equals(cc.getUserId()) || loginUser.getUserRole() == UserRole.A);
						%>
						<tr class="<%=cc.getCommentLevel() == CommentLevel.COMMENT ? "level1" : "level2"%>">
							<td>
							<sub class="comment-writer"><%=cc.getUserId()%></sub> 
							<sub class="comment-date"><%=sdf.format(cc.getCommentDate())%></sub>
								<div>
									<p><%= cc.getCommentContent() %></p>
									

								</div>
							</td>
							
							<td>
								<% if (cc.getCommentLevel() == CommentLevel.COMMENT) { %>
								<button class="btn-reply" value="<%= cc.getNo()%>" style="margin-top: 30px;">답글</button> 
								<% } %> 
								
								<% if (canDelete) { %>
								<button class="btn-delete" value="<%= cc.getNo()%>"
									style="margin-top: 30px;">삭제</button> 
									<% } %>
							</td>
						</tr>
						
						
						<%
							}
						}
						%>
					</table>
					<hr>
				</div>
			</li>
		</ul>

	</div>

</div>
<form action="<%= request.getContextPath() %>/share/shareCommentDelete"
	method="post" name="shareCommentDelFrm">
	<input type="hidden" name="no" />
</form>

<script>
document.querySelectorAll(".btn-delete").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		if(confirm("해당 댓글을 정말 삭제하시겠습니까?")) {
			const {value} = e.target;
			const frm = document.shareCommentDelFrm;
			frm.no.value = value;
			frm.submit();
		}
	});
});

document.querySelectorAll(".btn-reply").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		<% if(loginUser == null){%>
			loginAlert(); return;
		<% } %>
		
		const {value} = e.target;
		console.log(value);
		
		const tr = `
		<tr>
			<td colspan="2" style="text-align:left;">
				<form
		        	name="communityCommentFrm"
					action="<%=request.getContextPath()%>/share/shareCommentAdd" 
					method="post">
		            <input type="hidden" name="commNo" value="<%= community.getCommNo() %>" />
		            <input type="hidden" name="writer" value="<%= loginUser != null ? loginUser.getUserId() : "" %>" />
		            <input type="hidden" name="commentLevel" value="2" />
		            <input type="hidden" name="commentRef" value="\${value}" />    
					<textarea name="content" cols="60" rows="1"></textarea>
		            <button type="submit" class="btn-comment-enroll2">등록</button>
		        </form>
			</td>
		</tr>`;
		
        const target = e.target.parentElement.parentElement; 
        target.insertAdjacentHTML('afterend', tr);
        
	}, {once: true});
});

document.addEventListener('submit', (e) => {
if(e.target.matches("form[name=communityCommentFrm]")){		
	if(<%=loginUser == null%>){
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

document.communityCommentFrm.content.addEventListener('focus', (e) => {
	if(<%=loginUser == null%>)
		loginAlert();
});

document.querySelector("#like").addEventListener('click', (e) => {
		
	$.ajax({
		url : '<%= request.getContextPath() %>/share/shareLike',
		method : 'POST',
		data : {commNo : "<%= commNo %>"}
	})
});

</script>

<form 
	action="<%= request.getContextPath() %>/share/shareDelete"
	method="post" 
	name="shareDelFrm">
	<input type="hidden" name="no" value="<%= community.getCommNo() %>" />
</form>
<script>

const loginAlert = () => {
	alert("로그인후 이용할 수 있습니다.");
	document.querySelector("#btn-comment-enroll1").focus();
};

const deleteCommunity = () => {
	if(confirm("게시글을 삭제하시겠습니까?"))
		document.shareDelFrm.submit();
};

const editCommunity = () => {
	location.href = "<%= request.getContextPath() %>/share/shareEdit?no=<%= community.getCommNo() %>";	
};

</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
