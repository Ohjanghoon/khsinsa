<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	User user = (User) request.getAttribute("user");
%>
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/css/user/userForgotId.css">
<div class="container">
	<div class="forgotid_container">
		<div class="search-title">
			<h3>아이디 찾기</h3>
		</div>
		<form name="idfindfrm" method="POST"
			action="<%=request.getContextPath()%>/user/userForgotId"
			onsubmit="javascript:frmSubmitCheck();">

			<section class="form-search">

				<div class="input_area">
					<label>이름</label> 
					<input type="text" name="username" class="btn-name"> <br>
				</div>

				<div class="input_area">
					<label>이메일 </label>
					 <input type="text" onKeyup="addHypen(this);" name="userEmail" class="btn-email">
				</div>
				<br>

			</section>
			<div class="btnSearch">
				<button type="submit" class="btn btn-primary btn-sm" >찾기</button>
				<button type="button" class="btn btn-secondary btn-sm"  onClick ="history.back()" >취소</button>
			</div>
			
			

		</form>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>