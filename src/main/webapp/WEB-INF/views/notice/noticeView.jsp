<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.kh.sinsa.notice.model.dto.Notice"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/share/shareView.css" />
<%
Notice notice = (Notice) request.getAttribute("notice");


%>


<div class="container">


		<div id="header2"></div>

	<h2 style="font-size: 35px; color: red; font-weight:bold;">공지사항 <span style="font-size: 18px;"> Notice</span>
	</h2>
	<hr style="border-top: 3px solid red;">
	<div class="main">

		<ul>
			<li id="title"><h2><%=notice.getNoticeTitle()%></h2></li>
			<li id="writer"><h3><%=notice.getNoticeWriter()%></h3></li>
			<li id="readCount">조회수 : <%= notice.getNoticeReadCount() %></li>
			
			<li id="date">
				<span>작성일 <%= new SimpleDateFormat("yy-MM-dd HH:mm").format(notice.getNoticeDate()) %></span>
			</li>
			
			<hr style="color: gainsboro;">
			
			<li style="margin-top: 50px; background-color: white; height: 500px;"><p>
					<%=notice.getNoticeContent()%>
				</p></li>
				
		<%
			boolean canEdit = (loginUser != null && 
						loginUser.getUserRole() == UserRole.A);
			if(canEdit){ 
		%>

			<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
			<li style="float:right">
				<input type="button" value="수정하기" onclick="editNotice()" style="background-color:black; color:white;">
				<input type="button" value="삭제하기" onclick="deleteNotice()" style="background-color:black; color:white;">
			</li>
		
		<% } %>

			
				
		
		<div id="goList">
			<input type="image" src="<%= request.getContextPath() %>/images/menuIcon.png" onclick="location.href = '<%=request.getContextPath() %>/notice/noticeList'" id="btn_goList"
			style="width:60px; height:auto;">
		</div>	
		</ul>
		
</div>		

</div>

<form 
	action="<%= request.getContextPath() %>/notice/noticeDelete"
	method="post" 
	name="noticeDelFrm">
	<input type="hidden" name="no" value="<%= notice.getNoticeNo() %>" />
</form>
<script>
const deleteNotice = () => {
	if(confirm("게시글을 삭제하시겠습니까?"))
		document.noticeDelFrm.submit();
};

const editNotice = () => {
	location.href = "<%= request.getContextPath() %>/notice/noticeEdit?no=<%= notice.getNoticeNo() %>";	
};

</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>