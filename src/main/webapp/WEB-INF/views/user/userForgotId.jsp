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
<title>아이디 찾기 </title>
</head>
<body>
	<form name="idfindfrm" method = "POST" action="<%=request.getContextPath()%>/user/userForgotId" onsubmit ="javascript:frmSubmitCheck();">
			<div class = "search-title">
				<h3>아이디 찾기 </h3>
			</div>
		<section class = "form-search">
		
			<div class = "input_area">
				<label>이름</label>
				<input type="text" name="username" class = "btn-name" placeholder = "등록된 이름을 입력하세요. ">
			<br>
			</div>
			
			<div class = "input_area">
				<label>이메일 </label>
				<input type="text" onKeyup = "addHypen(this);" name="userEmail" class = "btn-email" placeholder = "등록된 이메일을 입력하세요. " value=qkralstj08@naver.com>
			</div>
			<br>
			
	</section>
	<div class ="btnSearch">
		<input type="submit" name="enter" value="찾기" class="btn_open" onClick="id_search()">
		<input type="button" name="cancle" value="취소" onClick="history.back()">
 	</div>
 </form>
 

</body>
</html>