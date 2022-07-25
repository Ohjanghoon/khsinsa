<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/share/shareAdd.css" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<body>
	<div id="container">
	
		<div id="header2"></div>

		<form name="noticeAddFrm"
			action="<%=request.getContextPath()%>/notice/noticeAdd" 
			method="post">
			<h2 style="font-size: 30px; color: black;">정보공유 게시글 작성</h2>
			<hr style="border-top: 3px solid black;">
			<div id="content" style="margin: 30px;">

				<br> 
				
				<input type="text" name="title" id="title" placeholder="제목 입력"> 
					
				<br> 
				<div id="writer">
					<span style="margin-left:130px;">작성자 : </span>
				<input type="text" name="writer" id="writer" value="<%= loginUser.getUserId()%>" style="border:0px;" readonly />
				</div>
				<p>
					<textarea name="content" cols="100" rows="50"></textarea>
				</p>

		<div id="btn-sum" style="margin:30px;">
			<span class="btn-add"> <input type="submit" id="btn-add" value="작성" style="width:150px; background-color:black; color:white"></span> 
			<span class="btn-sel"> <input type="button" value="취소" style="width:150px; background-color:black; color:white"></span>
		</div>

	</div>
	</form>

	<script>
/**
* shareAddFrm 유효성 검사
*/
document.shareAddFrm.onsubmit = (e) => {
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