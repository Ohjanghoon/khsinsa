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
			<br><br>
		</div>
		<form name="pwdEditfrm" method="POST"
			action="<%=request.getContextPath()%>/user/userPasswordEdit"
			onsubmit="javascript:frmSubmitCheck();">


			
			
				<section class="form-search">
				<div class="input-group mb-3">
					<input type="text" class="form-control" name="userId"
						placeholder="가입된 아이디를 입력하세요." aria-label="Username"
						aria-describedby="basic-addon1" style="width: 300px;">
				</div>
				<div class="input-group mb-3">
					<input type="text" class="form-control" name="tempPwd"
						placeholder="발급된 임시 비밀번호를 입력하세요." aria-label="Username"
						aria-describedby="basic-addon1">
				</div>
				<div class="input-group mb-3">
					<input type="text" class="form-control" name="newPwd"
						placeholder="변경할 비밀번호를 입력하세요." aria-label="Username"
						aria-describedby="basic-addon1">
				</div>
				<br>
			</section>
			
			
	
			<div class="btnSearch">
				<button type="submit" class="btn btn-primary"  >변경</button>
				<button type="button" class="btn btn-secondary"  onClick ="history.back()" >취소</button>
			</div>
			
				 	
				
		</form>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>