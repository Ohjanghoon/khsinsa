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
List<CommunityComment> commentList = (List<CommunityComment>) request.getAttribute("commentList");
%>


<div class="content_wrapper">

	<div id="headlist">
		<div id="header2">COMMUNITY</div>
		<nav>
			<ul class="navi">
				<li><a href="#">OOTD</a></li>
				<li><a href="#">코디북</a></li>
				<li><a href="<%= request.getContextPath()%>/share/shareList" />정보공유</a></li>
				<li><a href="#">자유게시판</a></li>
				<li><a href="#">패션토크</a></li>
			</ul>
		</nav>


	</div>
	<h2 style="font-size: 35px; color: rgb(101, 101, 252);">
		정보공유 게시판 <span style="font-size: 18px;"> Share Information</span>
	</h2>
	<hr style="border-top: 3px solid rgb(101, 101, 252);">
	<div class="main">

		<ul>
			<li id="title"><h2><%=community.getCommTitle()%></h2></li>
			<li id="writer"><h3><%=community.getUserId()%></h3></li>
			<li id="readCount">조회수 : <%=community.getCommReadCount()%> | 추천수
				: <%=community.getCommRecommand()%>
				<button id="good" style="border: 0; background-color: white;">

					<img src="<%=request.getContextPath()%>/images/emptyHeart.png"
						alt="버튼" style="width: 20px; height: 20px;">

				</button>
			</li>
			<hr style="color: gainsboro;">
			<li style="margin-top: 50px; background-color: white; height: 500px;"><p>
					<%=community.getCommContent()%>
				</p></li>

			<hr>

			<li style="margin-top: 13px;">

				<div class="comment-container">
					<!-- 댓글 작성부 -->
					<div class="comment-editor">
						<form name="communityCommentFrm"
							action="<%=request.getContextPath()%>/share/shareCommentAdd"
							method="post">
							<input type="hidden" name="commNo"
								value="<%=community.getCommNo()%>" /> <input type="hidden"
								name="writer" value="<%= loginUser != null ? loginUser.getUserId() : "" %>" /> <input
								type="hidden" name="commentLevel" value="1" /> <input
								type="hidden" name="commentRef" value="0" />
							<textarea name="content" cols="60" rows="3"
								placeholder="댓글을 입력하세요."></textarea>
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
						<tr
							class="<%=cc.getCommentLevel() == CommentLevel.COMMENT ? "level1" : "level2"%>">
						<tr class="">
							<td><sub class="comment-writer"><%=cc.getUserId()%></sub> <sub
								class="comment-date"><%=sdf.format(cc.getCommentDate())%></sub>
								<div>
									<p><%= cc.getCommentContent() %></p>

								</div></td>
							<td>
								<%
									if (cc.getCommentLevel() == CommentLevel.COMMENT) {
								%>
								<button class="btn-reply" value="<%= cc.getNo()%>"
									style="margin-top: 30px;">답글</button> <%
 									}
								 %> <%
 										if (canDelete) {
 									%>
								<button class="btn-delete" value="<%= cc.getNo()%>"
									style="margin-top: 30px;">삭제</button> <%
 										}
								 %>
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
<form 
	action="<%= request.getContextPath() %>/share/shareCommentDelete"
	method="post" 
	name="shareCommentDelFrm">
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

document.communityCommentFrm.content.addEventListener('focus', (e) => {
	if(<%= loginUser == null %>)
		loginAlert();
});

const loginAlert = () => {
	alert("로그인후 이용할 수 있습니다.");
	document.querySelector("#btn-comment-enroll1").focus();
};
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
