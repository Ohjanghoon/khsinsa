<%@page import="com.kh.sinsa.community.model.dto.Community"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/share/shareAdd.css" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	Community community = (Community) request.getAttribute("community");

%>

<body>
	<div id="container">
		<div id="header1"></div>
		<div id="header2">COMMUNITY</div>
		<nav class="navi">
			<ul>
				<li><a href="#">OOTD</a></li>
				<li><a href="<%= request.getContextPath() %>/community/codiList">코디북</a></li>
				<li><a href="<%= request.getContextPath() %>/share/shareList">정보공유</a></li>
				<li><a href="<%= request.getContextPath() %>/community/freeList">자유게시판</a></li>
				<li><a href="#">패션토크</a></li>
			</ul>
		</nav>
		<form name="shareEditFrm"
			action="<%=request.getContextPath()%>/share/shareEdit" 
			method="post">
			<h2 style="font-size: 30px; color: black;">정보공유 게시글 수정</h2>
			<hr style="border-top: 3px solid black;">
			<div id="content" style="margin: 30px;">
				<span class="dropdown"> 
				<select onchange="if(this.value) location.href=(this.value);" name="one" class="dropdown-select">
						<option value="0">게시판 선택</option>
						<option value="1">OOTD</option>
						<option value="<%= request.getContextPath() %>/community/codiList">코디북</option>
						<option value="<%=request.getContextPath()%>/share/shareEdit" selected />정보공유</option>
						<option value="<%= request.getContextPath() %>/community/freeList" >자유게시판</option>
						<option value="5">패션토크</option>
				</select>
				</span> 
				<br> 
				<input type="hidden" name="no" value="<%= community.getCommNo() %>">
				<input type="text" name="title" id="title" value="<%= community.getCommTitle().replace("\"", " &quot;") %>" placeholder="제목 입력"> 
					
				<br> 
				<div id="writer">
					<span style="margin-left:130px;">작성자 : </span>
				<input type="text" name="writer" id="writer" value="<%= community.getUserId()%>" style="border:0px;" readonly />
				</div>
				<p>
					<textarea name="content" cols="100" rows="50"><%= community.getCommContent()%></textarea>
				</p>

		<div id="btn-sum" style="margin:30px;">
			<span class="btn-add"> <input type="submit" value="수정하기" style="width:150px;"></span> 
			<span class="btn-sel"> <input type="button" value="취소" onclick="history.go(-1);" style="width:150px;"></span>
		</div>

	</div>
	</form>

	<script>
/**
* shareEditFrm 유효성 검사
*/
document.shareEditFrm.onsubmit = (e) => {
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