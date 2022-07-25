<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
			String userId = (String) session.getAttribute("userId"); 
			if(userId != null) session.removeAttribute("userId");
			
%>
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/css/user/mypage/userEditPwd.css">
<div class="container">
	<div class="pwdEdit_container">
		<div class="search-title">
			<h3>비밀번호 변경</h3>
		</div>
		<form name="pwdEditfrm" method="POST"
			action="<%=request.getContextPath()%>/user/userPasswordEdit"
			onsubmit="javascript:frmSubmitCheck();">

			<section class="form-search">

				<div class="input_area">
					<label>아이디</label> 
					<input type="text" name="userId" class="btn-Id"> <br>
				</div>
				<div class="input_area">
					<label>임시 비밀번호</label> 
					<input type="text" name="tempPwd" class="btn-tempPwd"> <br>
				</div>

				<div class="input_area">
					<label>신규 비밀번호 </label>
					 <input type="text" onKeyup="addHypen(this);" name="newPwd" class="btn-newPwd">
				</div>
				<br>

			</section>
			<div class="btnSearch">
				<button type="submit" class="btn btn-primary btn-sm" >변경</button>
				<button type="button" class="btn btn-secondary btn-sm"  onClick ="history.back()" >취소</button>
			</div>
			
				 	
				
		</form>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>