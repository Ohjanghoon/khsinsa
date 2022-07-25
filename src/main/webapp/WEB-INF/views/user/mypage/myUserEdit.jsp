<%@page import="java.util.ArrayList"%>
<%@page import="javax.swing.text.Document"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/user/mypage/userEdit.css">
<title>회원정보 수정 페이지</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/user/mypage/myPageHeader.jsp"%>
<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String todayDate = sdf.format(new Date());
%>

<%
String emailId = "";
String emailAddr = "";
String roadAddr = "";
String roadDetail = "";
if (loginUser != null) {

	String[] tempEmail = loginUser.getUserEmail().split("\\@");
	emailId = tempEmail[0];
	emailAddr = tempEmail[1];

	String phone = loginUser.getUserPhone();
	String phonefront = phone.substring(0, 3);
	String phoneBack = phone.substring(3);
	
	String address = loginUser.getUserAddress();
	String[] tempAddress = address.split("+");
	roadAddr = tempAddress[0];
	roadDetail = tempAddress[1];
	
}
%>
<div class="edit_container">
	<h2>개인정보 수정</h2>
	<form action="<%=request.getContextPath()%>/mypage/myUserEdit"
		name="editFrm" method="post" onsubmit="javascript:frmSubmitCheck();">

		<%-- 아이디 명시 --%>
		<div class="input_area">
			<label>아이디<span class="essential_mark">*</span></label> 
			<input type="text" name="userId" id="userId" value="<%=loginUser.getUserId()%>" readonly>
		</div>
		<br> <span class="message_box" id="idMsg"></span>

		<%-- 이름  수정 --%>
		<div class="input_area">
			<label>이름 <span class="essential_mark">*</span></label> 
			<input type="text" name="userName" id="userName" value="<%=loginUser.getUserName()%>" autocomplete="off" required>
		</div>
		<br> <span class="message_box" id="nameMsg"></span>

		<%-- 생년월일 수정 --%>
		<div class="input_area">
			<label>생년월일 <span class="essential_mark">*</span></label>
			 <input type="date" name="userBirth" id="userBirth" value="<%=loginUser.getUserBirthday()%>"min="1990-01-01" max="<%=todayDate%>">
		</div>
		<br>


		<%-- 휴대전화 수정 --%>
		<div class="input_area phone_area">
			<label>휴대전화 <span class="essential_mark">*</span></label>
			<input type="text" name="phone1" id="phone1" value="010" readonly>
			<input type="text" name="phone2" id="phone2" value="<%=loginUser.getUserPhone().substring(3, 11)%>" maxlength="8" placeholder="ex)12341234" autocomplete="off" required>
		</div>
		<br> 
		<span class="message_box" id="phoneMsg"></span>

		<%-- 이메일 수정 --%>
		<div class="input_area email_area">
			<label>이메일 <span class="essential_mark">*</span></label> 
			<input type="text" name="emailId" id="emailId" value="<%=emailId%>" title="이메일을 입력해주세요" autocomplete="off" required>
			<span id="email_at">@</span>
			 <input type="text" name="emailAddr" id="emailAddr" value="<%=emailAddr%>" list="emailAddrs" autocomplete="off" required>
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
		<br> <span class="message_box" id="emailMsg">계정 분실시 본인인증 정보로 사용됩니다.</span>


		<%-- 주소  수정 --%>
		<div class="input_area">
			<label>주소 <span class="essential_mark">*</span></label> 
			<input type="text" name="roadAddr" id="roadAddr" value ="<%= roadAddr%>" readonly>
			<button type="button" id="btn_address" onclick="addressPopup();">주소검색</button>
		</div>
		<br> 
		<div class="input_area addr_area">
		<input type="text" name="roadDetail" id="roadDetail" value="<%= roadDetail %>" placeholder="상세주소 입력" value="">
		</div>
		<br> <span class="message_box" id="addressMsg"></span>

		<%-- 수정/취소/탈퇴 버튼 영역 --%>
		<div class="btn_area">
		<button type="submit" class="btn btn-primary btn-lg" id=btn_edit>수정하기</button>
		<a type="reset" class="btn btn-secondary btn-lg" href="<%= request.getContextPath() %>/user/userPasswordEdit">비밀번호 수정</a>
		<br>
		<a href="#" onclick="userDel();">회원 탈퇴</a> 
		</div>
	
	</form>
	<form action="<%= request.getContextPath() %>/user/userDelete" method="post" name="userDelFrm">
		<input type="hidden" name="userId" value="<%=loginUser.getUserId()%>" />
	</form>
	
</div>
<script>
const userDel = () => {
	
	if(confirm("탈퇴하시면 지금까지의 혜택을 누릴수 없습니다.\n정말로 탈퇴하시겠습니까?😭")){
		const frm = document.userDelFrm;
		frm.submit();
	}
};
//유효성 검사 메세지
const showMsg = (obj, msg) => {
    obj.innerHTML = msg;
};
//----------------------------------이름----------------------------------------
//이름 유효성 검사
const checkName = () => {
	const tempUserName = document.querySelector("#userName").value;
	const nameRegexp = /^[가-힣]{2,}$/;
	
	if(tempUserName === ""){
	    showMsg(nameMsg, "필수 정보입니다.");
	    return false;
	}
	if(!nameRegexp.test(tempUserName)){
	    showMsg(nameMsg, "이름을 다시 확인해주세요.");
	    return false;
	}
	showMsg(nameMsg, "✔️");
	return true;
};
//onblur시 이름 유효성 검사 체크
userName.onblur = () => {
	checkName();
};

//----------------------------------휴대전화----------------------------------------
/**
 * 휴대전화 유효성 검사 (본인 확인을 위해 필수정보로 설정)
 * - 앞의 3자리를 select로 번호를 받아 발생할 수 있는 케이스를 줄임
 */
const checkPhone = () => {
    const tempPhone2 = document.querySelector("#phone2").value;
    const phoneRegexp = /\d{7,8}/;
    
    if(tempPhone2 === ""){
        showMsg(phoneMsg, "필수 정보입니다.");
        return false;
    }
    if(!phoneRegexp.test(tempPhone2)){
        showMsg(phoneMsg, "전화번호를 다시 확인해주세요.");
        return false;
    }
    showMsg(phoneMsg, "✔️");
    return true;
};
//onblur시 휴대전화 유효성 검사 체크
phone2.onblur = () => {
    checkPhone();
};

//----------------------------------이메일----------------------------------------
//이메일 유효성 검사
const checkEmailId = () => {
	const tempEmailId = document.querySelector("#emailId").value;
	const emailIdRegexp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/;
	
	if(tempEmailId === ""){
	    showMsg(emailMsg, "필수 정보입니다.");
	    return false;
	}
	if(!emailIdRegexp.test(tempEmailId)){
	    showMsg(emailMsg, "이메일 주소를 다시 확인해주세요.");
	    return false;
	}
	
	//이메일아이디를 입력받은 후 이메일 주소 형식 처리
	// const tempEmailAddr = "";
	emailAddr.focus();
	
	// 이메일 주소 체크
	emailAddr.onblur = () => {
	    checkEmailAddr(tempEmailId);
	};
	return true;
};

//이메일 아이디 체크
emailId.onblur = () => {
  checkEmailId();    
};

//이메일 주소 유효성 검사
const checkEmailAddr = (tempEmailId) => {
  const tempEmailAddr = document.querySelector("#emailAddr").value;
  const emailAddrRegexp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
  
  if(emailAddr.value === ""){
      showMsg(emailMsg, "이메일 주소를 다시 확인해주세요.");
      return false;
  }
  if(!emailAddrRegexp.test(tempEmailAddr)){
      showMsg(emailMsg, "이메일 주소를 다시 확인해주세요.");
      return false;
  }
  if(!findByEmail(tempEmailId+"@"+tempEmailAddr)){
	  showMsg(emailMsg, "이미 사용중인 이메일입니다.");
	  return false;
  }
  showMsg(emailMsg, "✔️");
  return true;
};      



//이메일 중복검사
const findByEmail = (tempEmail) => {
	let available;
	$.ajax({
		url : '<%=request.getContextPath()%>/user/userEnroll/findByEmail',
		data: {tempEmail},
		async: false,
	    success(response){
			available = response;
		},
	    error : console.log
		
	});
	return available;
}; 

//----------------------------------주소----------------------------------------
//주소 유효성 검사
const checkAddress = () => {
	const tempAddress = document.querySelector("#roadAddr").value;
	
	if(tempAddress === ""){
	    showMsg(addressMsg, "필수 정보입니다.");
	    return false;
	}
	return true;
};

//주소 입력여부 체크
roadAddr.onblur = () => {
	checkAddress();    
};

//사용자 입력값이 올바르지 않은데 가입하기 버튼을 클릭시 출력 메세지
const re_input = (msg, ele) => {
    alert(msg + " 입력을 다시 확인해주세요!");
    ele.focus();       //잘못 입력된 input focus 처리
    return false;
};
//----------------------------------회원가입 폼 제출 전 체크----------------------------------------
const frmSubmitCheck = () => {
    
    //회원가입 처리하기 이전에 최종 유효성 검사
    if(!checkId()){
        return re_input("아이디", userId);
    }
    if(!checkPwd()){
        return re_input("비밀번호", userPwd);
    }
    if(!checkPwdCheck()){
        return re_input("비밀번호 확인", userPwdCheck);
    }
    if(!checkName()){
        return re_input("이름", userName);
    }
    if(!checkPhone()){
        return re_input("휴대전화", phone2);
    }
    if(!checkEmailId()){
        return re_input("이메일 아이디", emailId);
    }
    if(!checkEmailAddr()){
        return re_input("이메일 주소", emailAddr);
    }
    if(!checkAddress()){
        return re_input("주소", roadAddr);
    }
	
	return true;
};
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
//----------------------------------주소 검색 팝업----------------------------------------
function addressPopup() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
            
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.querySelector("#roadAddr").value = addr;
            showMsg(addressMsg, "✔️");
            // 커서를 상세주소 필드로 이동한다.
            document.querySelector("#roadDetail").focus();
        }
    }).open();
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>