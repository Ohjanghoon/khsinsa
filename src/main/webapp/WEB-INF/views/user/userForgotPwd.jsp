<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<%
	User user = (User) request.getAttribute("user");
%>
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/css/user/userForgotPwd.css">
<div class="container">
	<div class="forgotPwd_container">
		<div class="search-title">
			<h3>비밀번호 찾기</h3>
		</div>
		<form name="pwdfindfrm" method="POST" action="<%=request.getContextPath()%>/user/userForgotPwd" >

			<section class="form-search">

				<div class="input_area">
					<label>아이디</label> 
					<input type="text" name="userId" class="btn-name"> <br>
				</div>
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
				<input type="submit" name="enter"  id="btn_find" value="찾기" class="btn_open"> 
				<input type="button" name="cancle" value="취소" id="btn_cancel" onClick="history.back()">
				
			</div>
			
			
			

		</form>
		
		
		
			<% if(user != null) { %>
      		<p>임시비밀번호는 <%= request.getAttribute("tempPwd")  %>입니다.</p>
			<% } %> 
			
			
			
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>