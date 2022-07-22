<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/user/userLogin.css">
</head>
<body>

 <div class="container">
    <div class="login_container">
        <h2>로그인</h2>
        <form action="<%= request.getContextPath() %>/user/userLogin" method="post"  name="Loginfrm">
                <div class="input_area">
                    <input type="text" name="userId" id="userId" autocomplete="off" value= "" required>
                    <label>아이디</label>
                    <br>
                    <span class="message_box" id="loginMsg"></span>   <!-- input 태그 밑에 유효성 검사 메세지 -->
                </div>
                <div class="input_area">
                    <input type="password" name="pwd" id="pwd" autocomplete="off" required>
                    <label>비밀번호</label>
                    <button type="button" id="btn_show_pwd"><img src="<%=request.getContextPath() %>/images/eye_visible_icon.png" alt="버튼"></button>
                    <br>
                    <span class="message_box" id="pwdMsg"></span>
                </div>
                <div>
                    <div class="saveId_wrapper">
                        <input type="checkbox" name="saveId" id="saveId" value = "">
                        <label for="saveId">아이디저장</label>
                    </div>
                    <div class="forgot_wrapper">
                        <a href="<%= request.getContextPath() %>/user/userForgotId">아이디 찾기</a> <span>/</span>

                        <a href="<%= request.getContextPath() %>/user/userForgotPwd">비밀번호 찾기</a>
                    </div>
                </div>
                <div>
                    <button type="submit" id="btn_login">로그인</button>
                    <button type="button" id="btn_signup" onclick="location.href = '<%= request.getContextPath() %>/user/userEnroll'">회원가입</button>
                </div>
        </form>
    </div>

</div>

</body>
</html>