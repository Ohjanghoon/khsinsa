<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>


<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/user/userForgotPwd.css">
<div class="container">
	<div class="forgotPwd_container">
		<div class="search-title">
			<h3>비밀번호 찾기</h3>
			<br><br><br>
		</div>
		<form name="pwdfindfrm" method="POST"
			action="<%=request.getContextPath()%>/user/userForgotPwd">
			<section class="form-search">
				<div class="input-group mb-3">
					<input type="text" class="form-control" name="userId"
						placeholder="가입된 아이디를 입력하세요." aria-label="Username"
						aria-describedby="basic-addon1" style="width: 300px;">
				</div>
				<div class="input-group mb-3">
					<input type="text" class="form-control" name="username"
						placeholder="가입된 이름을 입력하세요." aria-label="Username"
						aria-describedby="basic-addon1">
				</div>
				<div class="input-group mb-3">
					<input type="text" class="form-control" name="userEmail"
						placeholder="가입된 이메일을 입력하세요." aria-label="Username"
						aria-describedby="basic-addon1">
				</div>
				<br>
			</section>
			
			
			
			<div class="d-grid gap-2 d-md-block" id="wrapper">
  			<button type="submit" class="btn btn-primary" id="btnSearch">찾기</button>
  			<button class="btn btn-primary" type="button" onClick="history.back()">취소</button>
			</div>
		</form>

		<br> <br>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>