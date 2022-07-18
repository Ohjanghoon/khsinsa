<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file ="/WEB-INF/views/common/myPageHeader.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/user/mypage/userEdit.css">
<%
	String[] tempEmail = loginUser.getUserEmail().split("\\@");
	String emailId = tempEmail[0];
	String emailAddr = tempEmail[1];

%>


 <div class="container">
        <div class="enroll_container">
            <h2>개인정보 수정</h2>
            <form action="" name="enrollFrm">
                    <div class="input_area">
                        <label>아이디</label>
                        <input type="text" name="userId" id="userId" value="<%=loginUser.getUserId() %>" autocomplete="off" readonly required>
                    </div>
                    <br>
                    <span class="message_box" id="idMsg"></span>
        
                
                    <span class="message_box" id="pwdCheckMsg"></span>
                    <div class="input_area">
                        <label>이름</label>
                        <input type="text" name="userName" id="userName" value="<%=loginUser.getUserName() %>" autocomplete="off" required>
                    </div>
                    <br>
                    <span class="message_box" id="nameMsg"></span>
                    <div class="input_area">
                        <label>생년월일</label>
                        <input type="date" name="birth" id="birth" value="<%=loginUser.getUserBirthday() %>" min="1990-01-01" max="">
                    </div>
                    <br>
                    <div class="input_area phone_area">
                        <label>휴대전화</label>
                        <select name="phone1" id="phone1">
                            <option value="010">010</option>
                            <option value="011">011</option>
                            <option value="016">016</option>
                            <option value="017">017</option>
                            <option value="018">018</option>
                            <option value="019">019</option>
                        </select>
                        <input type="text" name="phone2" id="phone2" value = "<%=loginUser.getUserPhone() %>" maxlength="8" placeholder="ex)12341234" autocomplete="off" required>
                    </div>
                    <br>
                    <span class="message_box" id="phoneMsg"></span>
                    <div class="input_area email_area">
                        <label>이메일</label>
                        <input type="text" name="emailId" id="emailId" value="<%= emailId %>" title="이메일을 입력해주세요" autocomplete="off" required>
                        <span id="email_at">@</span>
                        <input type="text" name="emailAddr" id="emailAddr"  value="<%= emailAddr %>" list="emailAddrs" autocomplete="off" required>
                        <datalist id="emailAddrs">
                            <option value="naver.com">
                            <option value="hanmail.net">
                            <option value="gmail.com">
                            <option value="yahoo.com">
                            <option value="hotmail.com">
                            <option value="korea.com">
                            <option value="nate.com">
                        </datalist> 
                    </div>
                    <br>
                    <span class="message_box" id="emailMsg"></span>
                    <div class="input_area">
                        <label>주소</label>
                        <input type="text" name="roadAddr" id="roadAddr" value="<%=loginUser.getUserAddress() %>" readonly>
                        <button type="button" id="btn_address">주소검색</button>
                    </div>
                    <br>
                    <div class="input_area addr_area">
                        <input type="text" name="roadDetail" id="roadDetail" required>
                    </div>
                    <div class="btn_area">
                        <button type="submit" id="btn_enroll">수정하기 </button>
                        <button type="reset" id="btn_cancel">취소하기</button>
                    </div>
                </form>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>