<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
			String userId = (String) session.getAttribute("userId"); 
			if(userId != null) session.removeAttribute("userId");
			
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
					<input type="text" name="username" class="btn-name" placeholder="가입된 이름을 입력하세요."> <br>
				</div>

				<div class="input_area">
					 <input type="text" onKeyup="addHypen(this);" name="userEmail" class="btn-email" placeholder="가입된 이메일을 입력하세요.">
				</div>
				<br>

			</section>
			<div class="btnSearch">
				<button type="submit" class="btn btn-primary btn-sm" >찾기</button>
				<button type="button" class="btn btn-secondary btn-sm"  onClick ="history.back()" >취소</button>
			</div>
				<br>
				<br> 
				 <%-- <p id="findIdMSG">회원님의 아이디는 <%= user %> 입니다.</p> --%> 
				 	
				  <div class ="findIdColor">
				  <%if(userId != null) { %> 
				   <p>회원님의 아이디는 <span id="findIdMSG"><%=userId%></span> 입니다.</p>    
				  <%} %>
				  </div>
		</form>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>