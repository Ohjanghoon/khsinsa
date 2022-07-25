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
					<label>아이디</label> 
					<input type="text" name="userId" class="btn-name" value ="qkralstj0808"> <br>
				</div>
				<div class="input_area">
					<label>이름</label> 
					<input type="text" name="username" class="btn-name" value="박민서"> <br>
				</div>

				<div class="input_area">
					<label>이메일 </label>
					 <input type="text" onKeyup="addHypen(this);" name="userEmail" class="btn-email" value="qkralstj08@naver.com">
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