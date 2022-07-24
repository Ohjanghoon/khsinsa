<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<main>
<form action="<%= request.getContextPath() %>/community/codiAdd" name="commAddFrm" method="post" enctype="multipart/form-data" >
<input type="hidden" name="userId" value="<%= loginUser.getUserId() %>"/>
 <div class="container">
       <section class="py-5 text-center container">
           <h3>Out Fit Add</h3>
       </section>
       <div class="mb-3">
           <label for="exampleFormControlInput1" class="form-label">Title</label>
           <input type="text" name="commTitle" class="form-control" id="exampleFormControlInput1" placeholder="">
       </div>
       <div class="mb-3">
           <label for="formFile" class="form-label">Select The File</label>
           <input class="form-control" name="commUpFile" type="file" id="formFile">
       </div>
       <div class="mb-3">
           <label for="exampleFormControlTextarea1" class="form-label">Content</label>
           <textarea class="form-control" name="commContent" id="exampleFormControlTextarea1" rows="10"></textarea>
       </div>
       <div class="text-center">
           <button type="button" class="btn btn-outline-danger" onclick="history.go(-1);">Cancle</button>
           <button type="submit" class="btn btn-outline-secondary">Add</button>
       </div>
   </div>
</form>   
</main>	
<script>
	document.commAddFrm.onsubmit = (e) => {
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