<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>    
<%
	User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="idfindscreen" method = "POST" action="<%=request.getContextPath()%>/user/userForgotId" onsubmit ="javascript:frmSubmitCheck();">
			<div class = "search-title">
				<h3>휴대폰 본인확인</h3>
			</div>
		<section class = "form-search">
			<div class = "find-name">
				<label>이름</label>
				<input type="text" name="username" class = "btn-name" placeholder = "등록한 이름">
			<br>
			</div>
			<div class = "find-email">
				<label>이메일 </label>
				<input type="text" onKeyup = "addHypen(this);" name="userEmail" class = "btn-email" placeholder = "이메일을  '@'없이 입력" value=qkralstj08@gmail.com>
			</div>
			<br>
	</section>
	<div class ="btnSearch">
		<input type="submit" name="enter" value="찾기" class="btn_open" onClick="id_search()">
		<input type="button" name="cancle" value="취소" onClick="history.back()">
 	</div>
 </form>
 
 
 <script>
 
 
 
 //------------------------ 프로필 수정시 비밀번호 입력 후 -------------------------

  
</script>
</body>
</html>