<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/share/shareAdd.css" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<body>
	<div id="container">
		<div id="header1"></div>
		<div id="header2">COMMUNITY</div>
		<nav class="navi">
			<ul>
				<li><a href="#">OOTD</a></li>
				<li><a href="<%= request.getContextPath() %>/community/codiList">코디북</a></li>
				<li><a href="<%=request.getContextPath()%>/share/shareList">정보공유</a></li>
				<li><a href="<%= request.getContextPath() %>/community/freeList">자유게시판</a></li>
				<li><a href="#">패션토크</a></li>
			</ul>
		</nav>
		<form name="shareAddFrm"
			action="<%=request.getContextPath()%>/share/shareAdd" 
			method="post"
			encType = "multipart/form-data">
			<h2 style="font-size: 30px; color: black;">정보공유 게시글 작성</h2>
			<hr style="border-top: 3px solid black;">
			<div id="content" style="margin: 30px;">
				<span class="drop"> 
				<select name="one" id="drop-select" onchange="if(this.value) location.href=(this.value)">
						<option class="option" value="">게시판 선택</option>
						<option class="option" value="#">OOTD</option>
						<option class="option" value="#">코디북</option>
						<option class="option" value="<%=request.getContextPath()%>/share/shareAdd" selected />정보공유</option>
						<option class="option" value="<%= request.getContextPath() %>/community/freeAdd">자유게시판</option>
						<option class="option" value="#">패션토크</option>
				</select>
				</span> 
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
				
				<div>
					<input type="file" name="filename" accept="image/*">
				</div>

		<div id="btn-sum" style="margin:30px;">
			<span class="btn-add"> <input type="submit" id="btn-add" value="작성" style="width:150px;"></span> 
			<span class="btn-sel"> <input type="button" value="취소" style="width:150px;"></span>
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