<%@page import="com.kh.sinsa.community.model.dto.CommunityExt"%>
<%@page import="com.kh.sinsa.community.model.dto.CommunityAttachment"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.sinsa.community.model.dto.Community"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/share/shareAdd.css" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	Community community = (Community) request.getAttribute("community");
	List<CommunityAttachment> attachments = (List<CommunityAttachment>) request.getAttribute("attach");
	System.out.println("attachments = " + attachments);
%>

<body>
	<div id="container">
		<div id="header1"></div>
		<div id="header2">COMMUNITY</div>

		<form name="talkEditFrm"
			action="<%=request.getContextPath()%>/community/talkEdit" 
			enctype="multipart/form-data"
			method="post">
			<h2 style="font-size: 30px; color: green; font-weight:bold">패션토크 게시글 수정</h2>
			<hr style="border-top: 3px solid green;">
			<div id="content" style="margin: 30px;">
				
				<br> 

				<input type="hidden" name="no" value="<%= community.getCommNo() %>">
				<input type="text" name="title" id="title" value="<%= community.getCommTitle().replace("\"", " &quot;") %>" placeholder="제목 입력"> 
					
				<br>
				
				<div id="writer">
					<span style="margin-left:130px;">작성자 : </span>
				<input type="text" name="writer" id="writer" value="<%= community.getUserId()%>" style="border:0px;" readonly />
				</div>
				<div>
				<p>
					<textarea name="content" cols="100" rows="50"><%= community.getCommContent()%></textarea>
				</p>
				</div>
				<br>
				<div>
			<% 
			if(attachments != null && !attachments.isEmpty()){
				for(int i = 0; i < attachments.size(); i++){
					CommunityAttachment attach = attachments.get(i);
			%>
				<img src="<%= request.getContextPath() %>/images/file.png" width="16px" />
				<%= attach.getOriginalFilename() %>
				<input 
					type="checkbox" name="delFile" 
					id="delFile<%= i %>" value="<%= attach.getNo() %>"/>
				<label for="delFile<%= i %>">삭제</label>>
				
				
				<%
						}
					}
				%>
				
					<input type="file" accept="image/*" style="float:right;" name="editFile">
					
					</div>
					
					<br>

		<div id="btn-sum" style="margin:30px;">
			<span class="btn-add"> <input type="submit" value="수정하기" style="width:150px; background-color:black; color:white;"></span> 
			<span class="btn-sel"> <input type="button" value="취소" onclick="history.go(-1);" style="width:150px; background-color:black; color:white;"></span>
		</div>

	</div>
	</form>

	<script>
/**
* talkEditFrm 유효성 검사
*/
document.talkEditFrm.onsubmit = (e) => {
	const frm = e.target;
	//제목을 작성하지 않은 경우
	if(!/^.+$/.test(frm.title.value)){
		alert("제목을 작성해주세요.");
		frm.title.focus();
		return false;
	}
	
	//내용을 작성하지 않은 경우 
	if(!/^(.|\n)+$/.test(frm.content.value)){
		alert("내용을 작성해주세요.");
		frm.content.focus();	
		return false;
	}

	return true;
}


</script>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>