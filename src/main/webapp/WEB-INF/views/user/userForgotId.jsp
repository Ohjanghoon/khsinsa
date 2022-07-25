<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
String userId = (String) session.getAttribute("userId");
if (userId != null)
	session.removeAttribute("userId");
%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/user/userForgotId.css">
<div class="container">
	<div class="forgotid_container">
		<div class="search-title">
			<h3>아이디 찾기</h3>
			<br>
			<br>
		</div>
		<form name="idfindfrm" method="POST"
			action="<%=request.getContextPath()%>/user/userForgotId"
			onsubmit="javascript:frmSubmitCheck();">

			<section class="form-search">
				<br>
				<div class="input-group mb-3">
					<input type="text" name="username" class="form-control"
						placeholder="가입된 이름을 입력하세요" aria-label="Username"
						aria-describedby="basic-addon1" style="width: 300px;">
				</div>

				<div class="input-group mb-3">
					<input type="text" name="userEmail" class="form-control"
						placeholder="가입된 이메일을 입력하세요" aria-label="Username"
						aria-describedby="basic-addon1">
				</div>
				<br>

			</section>
	
			<div class="d-grid gap-2 d-md-block" id="wrapper">
  			<button class="btn btn-primary" type="button" >찾기</button>
  			<button class="btn btn-primary" type="button" onClick="history.back()">취소</button>
			</div>


			<div class="findIdColor">
				<%
				if (userId != null) {
				%>
				<p>
					회원님의 아이디는 <span id="findIdMSG"><%=userId%></span> 입니다.
				</p>
				<%
				}
				%>
			</div>




		</form>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>