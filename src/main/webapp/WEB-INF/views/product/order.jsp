<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/product/order.css" />
<%
	Product product = (Product) request.getAttribute("product");
	User user = (User) request.getAttribute("user");
	List<ProductAttachment> attachList = (List<ProductAttachment>) request.getAttribute("attachList");
	int orderAmount = (int) request.getAttribute("orderAmount");
	String size = (String) request.getAttribute("size");
	int totalPrice = orderAmount * product.getProPrice();
%>
<main>
    <div class="container">
        <section class="py-5 text-center container">
            <h3>Order Page</h3>
        </section>
        <hr>
  
       <form action="<%= request.getContextPath() %>/order/khOrder" name="orderFrm" method='post'>
       	<input type="hidden" name="proNo" value="<%= product.getProNo() %>" />
       	<input type="hidden" name="orderPrice" value="<%= totalPrice %>" />
       	<input type="hidden" name="orderAmount" value="<%= orderAmount %>" />
       	<input type="hidden" name="userId" value="<%= loginUser.getUserId() %>" />
       	<input type="hidden" name="orderEmail" value="<%= loginUser.getUserEmail() %>"/>
       	<input type="hidden" name="orderPhone" value="<%= loginUser.getUserPhone() %>"/>
			<div id="last">
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="radio" name="address" id="nowAddress" value="option1" checked>
			  <label class="form-check-label" for="inlineRadio1">Now Order Address</label>
			</div>
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="radio" name="address" id="newAddress" value="option2">
			  <label class="form-check-label" for="inlineRadio2">New Order Address</label>
			</div>
			<div class="col-md-7 col-lg-8" id="homeadd">
	          	<div class="row g-4">
	            <div class="col-sm-4">
	            <br />
	              <label for="firstName" class="form-label">Order name</label>
	              <input type="text" class="form-control" name="userName" id="userName" placeholder="press your Name" value="<%= loginUser.getUserName() %>">
	              </div>
	            </div>
	
	            <div class="col-7">
	              <label for="email" class="form-label">Email</label>
	              <input type="email" class="form-control" name="orderEmail" id="orderEmail" placeholder="press your Email" value="<%= loginUser.getUserEmail() %>">
	            </div>
	
	            <div class="col-12">
	              <label for="address" class="form-label">Address</label>
	              <button type="button" class="btn btn-primary addbtn" id="btn_address" onclick="addressPopup();">주소검색</button>
	              <input type="text" class="form-control" name="orderAddress1" id="orderAddress1" placeholder="press your Address" value="<%= loginUser.getUserAddress() %>" readonly>
	            </div>
			
           	  	<div class="col-12">
	              <label for="address2" class="form-label">Detail Address</label>
	              <input type="text" class="form-control" name="orderAddress2" id="orderAddress2" placeholder="press your Detail Address">
            	</div>
				<br />
	           <label for="request">배송 요청 사항</label>
	           <select class="form-select" aria-label="Default select example" id="orderReq" name="orderReq" required >
	               <option value="none" selected disabled>배송 시 요청사항을 선택해주세요.</option>
	               <option value="빠른 배송 부탁드립니다.">빠른 배송 부탁드립니다.</option>
	               <option value="부재시 경비실에 보관해주세요.">부재시 경비실에 보관해주세요.</option>
	               <option value="부재시 현관앞에 보관해주세요.">부재시 현관앞에 보관해주세요.</option>
	           </select>
           </div>
           </div>
       	  <div class="product-info">
           <h4>Product Info</h4>
           <table class="table">
               <thead>
                 <tr>
                   <th scope="col">상품정보</th>
                   <th scope="col">상품명</th>
                   <th scope="col">사이즈</th>
                   <th scope="col">수량</th>
                   <th scope="col">배송비</th>
                   <th scope="col">상품 금액</th>
                 </tr>
               </thead>
               <tbody>
                 <tr>
                   <th scope="row">
<% 
for(ProductAttachment att : attachList) {
%>
       <img src="<%= request.getContextPath() %>/upload/product/<%= att.getProRenameFilename() %>" alt="">
<% 
 break; } 
%>
                   </th>
					<td>
                       <p><%= product.getProName() %></p>
					</td>
					<td>
                       <p><%= size %></p>
					</td>
                   <td>
                       <p><%= orderAmount %></p>
                   </td>
                   <td>
                       <p>무료</p>
                   </td>
                   <td>
                       <p><%= totalPrice %>원</p>
                   </td>
                 </tr>
               </tbody>
             </table>
             <br /><br />
           <div class="product-price">
            <h4>결제 금액</h4>
            <p><%= totalPrice %>원</p>
            <hr />
            <h4>할인 금액</h4>
            <p>0원</p>
            <hr />
            <h4>최종 결제 금액</h4>
            <p><%= totalPrice %>원</p>
			</div>
			<br /><br />
          <button class="w-100 btn btn-primary btn-lg" type="submit">Payment</button>
      	 </div>
      	</form>
   </div>
</main>
<script>

	/*  new 배송지 선택시 val 초기화 */
	document.querySelector('#newAddress').addEventListener('click',(e) => {
		document.querySelector('#userName').value = ""
		document.querySelector('#orderEmail').value = ""
		document.querySelector('#orderAddress1').value = ""
		document.querySelector('#orderAddress2').value = ""
	});

	
	document.orderFrm.onsubmit = (e) => {
		// 이름
		if(document.querySelector('#userName').value == ""){
			e.preventDefault();
			alert("이름을 작성해주세요.");
			return false;
		}
		
		// 이메일
		if(document.querySelector('#orderEmail').value == ""){
			e.preventDefault();
			alert("이메일을 작성해주세요.");
			return false;
		}
		
		// 배송지검사
		if(document.querySelector('#orderAddress1').value == ""){
			e.preventDefault();
			alert("배송지를 작성해주세요.");
			return false;
		}
		if(document.querySelector('#orderAddress2').value == ""){
			e.preventDefault();
			alert("상세주소를 작성해주세요.");
			return false;
		}
		// 요청사항
		if(document.querySelector('#orderReq').value == 'none'){
			e.preventDefault();
			alert("요청사항을 선택해주세요.");
			return false;
		}
		
	}
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
            document.querySelector("#orderAddress1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.querySelector("#orderAddress2").focus();
        }
    }).open();
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>