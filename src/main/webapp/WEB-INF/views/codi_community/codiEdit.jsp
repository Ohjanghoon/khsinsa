<%@page import="com.kh.sinsa.community.model.dto.CommunityAttachment"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.sinsa.community.model.dto.Community"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/codi/codiEdit.css" />
<%
	Community codi = (Community) request.getAttribute("codi");
	List<CommunityAttachment> codiAttach = (List<CommunityAttachment>) request.getAttribute("codiAttach");
%>
<main>
<form action="<%= request.getContextPath() %>/community/codiEdit" name="commUpdateFrm" method="post" enctype="multipart/form-data">
<input type="hidden" name="commNo" value="<%= codi.getCommNo() %>" />
 <div class="container">
       <section class="py-5 text-center container">
           <h3>Out Fit Edit</h3>
       </section>
       <div class="mb-3">
           <label for="exampleFormControlInput1" class="form-label">Title</label>
           <input type="text" class="form-control" name="commTitle" id="exampleFormControlInput1" value="<%= codi.getCommTitle() %>">
       </div>
       <div class="mb-3">
       		<label for="exampleFormControlInput1" class="form-label">Existing Files</label>
       		<br />
<% 
	for(CommunityAttachment codiAt : codiAttach){
		if(codi.getCommNo().equals(codiAt.getCommNo())){ 
%>
           	<input type="checkbox" name="delFile" value="<%= codiAt.getNo() %>" checked>
       		<img src="<%= request.getContextPath() %>/upload/codi/<%= codiAt.getRenamedFilename() %>" alt="" width="240" height="320"/>
       	
<%
		}
	}
%>
			<br />
           	<p>* 선택된 파일은 삭제 됩니다.</p>
       </div>
       <div class="mb-3">
           <label for="formFile" class="form-label">Select The File</label>
           <input class="form-control" name="commUpFile" type="file" id="formFile">
       </div>
       <div class="mb-3">
           <label for="exampleFormControlTextarea1" class="form-label">Content</label>
           <textarea class="form-control" name="commContent" id="exampleFormControlTextarea1" rows="10"><%= codi.getCommContent() %></textarea>
       </div>
       <div class="text-center">
           <button type="button" class="btn btn-outline-danger btn-sm" onclick="history.go(-1);">Cancle</button>
           <button type="submit" class="btn btn-outline-primary btn-sm">Edit</button>
       </div>
   </div>
</form>
</main>	
<script>
	document.commUpdateFrm.onsubmit = (e) => {
		const frm = e.target;
		//제목을 작성하지 않은 경우 폼제출할 수 없음.
		const titleVal = frm.commTitle.value.trim(); // 좌우공백
		if(!/^.+$/.test(titleVal)){
			alert("제목을 작성해주세요.");
			frm.commTitle.select();
			return false;
		}		
						   
		//내용을 작성하지 않은 경우 폼제출할 수 없음.
		const contentVal = frm.commContent.value.trim();
		if(!/^(.|\n)+$/.test(contentVal)){
			alert("내용을 작성해주세요.");
			frm.commContent.select();
			return false;
		}
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>