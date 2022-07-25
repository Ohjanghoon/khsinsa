<%@page import="com.kh.sinsa.notice.model.dto.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/share/shareAdd.css" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	Notice notice = (Notice) request.getAttribute("notice");

%>

<body>
	<div id="container">

		<div id="header2"></div>
		
		<form name="noticeEditFrm"
			action="<%=request.getContextPath()%>/notice/noticeEdit" 
			method="post">
			<h2 style="font-size: 30px; color: red; font-weight:bold;">공지사항 수정</h2>
			<hr style="border-top: 3px solid red;">
			<div id="content" style="margin: 30px;">
 
				<br> 
				<input type="hidden" name="no" value="<%= notice.getNoticeNo() %>">
				<input type="text" name="title" id="title" value="<%= notice.getNoticeTitle().replace("\"", " &quot;") %>" placeholder="제목 입력"> 
					
				<br> 
				<div id="writer">
					<span style="margin-left:130px;">작성자 : </span>
				<input type="text" name="writer" id="writer" value="<%= notice.getNoticeWriter()%>" style="border:0px;" readonly />
				</div>
				<p>
					<textarea name="content" cols="100" rows="50"><%= notice.getNoticeContent()%></textarea>
				</p>

		<div id="btn-sum" style="margin:30px;">
			<span class="btn-add"> <input type="submit" value="수정하기" style="width:150px; background-color:black; color:white"></span> 
			<span class="btn-sel"> <input type="button" value="취소" onclick="history.go(-1);" style="width:150px; background-color:black; color:white"></span>
		</div>

	</div>
	</form>

	<script>
/**
* shareEditFrm 유효성 검사
*/
document.noticeEditFrm.onsubmit = (e) => {
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