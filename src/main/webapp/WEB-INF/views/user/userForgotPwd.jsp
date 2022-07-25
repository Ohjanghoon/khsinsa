<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>


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
					<input type="text" name="userId" class="btn-name" placeholder="가입된 아이디를 입력하세요."> <br>
				</div>
				<div class="input_area">
					<input type="text" name="username" class="btn-name" placeholder="가입된 이름을 입력하세요. "> <br>
				</div>
				<div class="input_area">
					 <input type="text" onKeyup="addHypen(this);" name="userEmail" class="btn-email" placeholder="가입된 이메일을 입력하세요." >
				</div>
				<br>

			</section>
			<div class="btnSearch">
			<button type="submit" class="btn btn-primary btn-sm" >찾기</button>
			<button type="button" class="btn btn-secondary btn-sm"  onClick ="history.back()" >취소</button>
				
			</div>
			
			
			

		</form>
			
			<br>
			<br>
	

      	
			<!-- <button type="button" class="btn btn-outline-primary">비밀번호 변경하기</button>  -->
      		
			
			
			
			
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>