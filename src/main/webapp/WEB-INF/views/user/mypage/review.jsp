<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/user/mypage/review.css" />

<%
	String proNo = (String) request.getAttribute("proNo");
	String orderNo = (String) request.getAttribute("orderNo");
%>
<div class="review_content">
		<form name="reviewAddFrm"
			action="<%=request.getContextPath()%>/mypage/review/reviewAdd" 
			method="post"
			encType = "multipart/form-data">
			<h2>리뷰 작성</h2>
			<hr>
			<div class="review_container">
				<div class="review_info">
					<input type="hidden" name="orderNo" value="<%= orderNo %>" />
					<p>상품 번호 / <input type="text" name="proNo" id="proNO" value="<%= proNo %>" readonly /></p>
					<p>작성자 / <input type="text" name="reviewWriter" id="reviewWriter" value="<%= loginUser.getUserId() %>" readonly /></p>
				</div>
				
				<textarea name="reviewContent" cols="50" rows="10"></textarea>
				
				<div>
					<input type="file" name="filename" accept="image/*">
				</div>

		<div class="review_btn_area">
			<button type="submit" id="review_btn_add" >작성</button> 
		</div>

	</div>
	</form>
</div>
<script>
/**
* reviewAddFrm 유효성 검사
*/
document.reviewAddFrm.onsubmit = (e) => {
	const frm = e.target;
	
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