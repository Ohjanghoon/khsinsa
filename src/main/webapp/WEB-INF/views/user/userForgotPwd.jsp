<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

</head>
<body>

 <div class="container">
    <div class="login_container">
        <h2>로그인</h2>
        <form  name="pwdfindscreen" method="post" action="<%= request.getContextPath() %>/user/userForgotPwd"  onsubmit ="javascript:frmSubmitCheck();">
              <div class = "search-title">
				<h3>비밀번호 찾기</h3>
			</div>
		<section class = "form-search">
			<div class = "find-id">
				<label>아이디 </label>
				<input type="text" name="userid" class = "btn-name" placeholder = "등록된 아이디를 입력하세요. ">
			<br>
			</div>
			<div class = "find-name">
				<label>이름</label>
				<input type="text" name="username" class = "btn-name" placeholder = "등록된 이름을 입력하세요. ">
			<br>
			</div>
			<div class = "find-email">
				<label>이메일 </label>
				<input type="text" onKeyup = "addHypen(this);" name="userEmail" class = "btn-email" placeholder = "등록된 이메일을 입력하세요. " value=qkralstj08@naver.com>
			</div>
			<br>
	</section>
	<div class ="btnSearch">
		<input type="submit" name="enter" value="찾기" class="btn_open" onClick="pwd_search()">
		<input type="button" name="cancle" value="취소" onClick="history.back()">
 	</div>
        </form>
    </div>

</div>

</body>
</html>