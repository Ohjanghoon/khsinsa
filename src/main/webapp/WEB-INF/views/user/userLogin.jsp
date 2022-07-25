<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
String saveId = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie c : cookies) {
		String name = c.getName();
		String value = c.getValue();
		System.out.println("[cookie] " + name + " = " + value);
		if ("saveId".equals(name)) {
	saveId = value;
		}
	}
}

String tempPwd = (String) session.getAttribute("tempPwd");
if (tempPwd != null)
	session.removeAttribute("tempPwd");
%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/user/userLogin.css">

<div class="container">
	<div class="login_container">
		<h2>로그인</h2>
		<form action="<%=request.getContextPath()%>/user/userLogin"
			method="post" name="Loginfrm">
			<div class="input_area">
				<input type="text" name="userId" id="userId" autocomplete="off"
					value="<%=saveId != null ? saveId : ""%>" required> <label>아이디</label>
				<br> <span class="message_box" id="loginMsg"></span>
				<!-- input 태그 밑에 유효성 검사 메세지 -->
			</div>
			<div class="input_area">
				<input type="password" name="pwd" id="pwd" autocomplete="off"
					required> <label>비밀번호</label>
				<button type="button" id="btn_show_pwd">
					<img
						src="<%=request.getContextPath()%>/images/eye_visible_icon.png"
						alt="버튼">
				</button>
				<br> <span class="message_box" id="pwdMsg"></span>
			</div>
			<div>






				<div class="saveId_wrapper">
					<input type="checkbox" name="saveId" id="saveId"
						<%=saveId != null ? "checked" : ""%>> <label for="saveId">아이디저장</label>
				</div>

				<div class="forgot_wrapper">
					<a href="<%=request.getContextPath()%>/user/userForgotId">아이디
						찾기</a> <span>/</span> <a
						href="<%=request.getContextPath()%>/user/userForgotPwd">비밀번호
						찾기</a>
				</div>
			</div>
			<div>

				<br> <br>
				<div class="d-grid gap-2  mx-auto">
					<button class="btn btn-primary" type="submit" style="width: 300px;">로그인</button>
					<button class="btn btn-primary" type="button"
						onclick="location.href = '<%=request.getContextPath()%>/user/userEnroll'">회원가입</button>
				</div>
			</div>


			<%
			if (tempPwd != null) {
			%>
			<br> 
			<div class="tempColor">
				<p id="tempPwdMSG" class="tempPwdMSG">
					임시비밀번호는 <span id="tempPwd"><%=tempPwd%></span> 입니다.
				</p>
			</div>


			<%
			}
			%>

		</form>
	</div>

</div>
<script>
document.querySelector("#btn_show_pwd").addEventListener('mousedown', () => {
    const ele_pwd = document.querySelector("#pwd");
    btn_show_pwd.classList.add('clicked');

    ele_pwd.type = "text";
});
btn_show_pwd.addEventListener('mouseup', () => {
    const ele_pwd = document.querySelector("#pwd");
    btn_show_pwd.classList.remove('clicked');

    ele_pwd.type = "password";
});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>