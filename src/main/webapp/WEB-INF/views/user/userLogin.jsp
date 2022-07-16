<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/user/mypage/login.css">
 <div class="container">
        <div class="login_container">
            <h2>로그인</h2>
            <form action="<%= request.getContextPath() %>/user/login" method="post">
                    <div class="input_area">
                        <input type="text" name="userId" id="userId" autocomplete="off" required>
                        <label>아이디</label>
                        <br>
                        <span class="message_box" id="loginMsg"></span>   <!-- input 태그 밑에 유효성 검사 메세지 -->
                    </div>
                    <div class="input_area">
                        <input type="password" name="pwd" id="pwd" autocomplete="off" required>
                        <label>비밀번호</label>
                        <button type="button" id="btn_show_pwd"><img src="./images/eye_visible_icon.png" alt="버튼"></button>
                        <br>
                        <span class="message_box" id="pwdMsg"></span>
                    </div>
                    <div>
                        <div class="saveId_wrapper">
                            <input type="checkbox" name="saveId" id="saveId">
                            <label for="saveId">아이디저장</label>
                        </div>
                        <div class="forgot_wrapper">
                            <a href="">아이디 찾기</a> <span>/</span>

                            <a href="">비밀번호 찾기</a>
                        </div>
                    </div>
                    <div>
                        <button type="submit" id="btn_login">로그인</button>
                        <button type="submit" id="btn_signup">회원가입</button>
                    </div>
            </form>
        </div>

    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>