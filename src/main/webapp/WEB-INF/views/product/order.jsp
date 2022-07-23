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
			<div id="last">
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1" checked>
			  <label class="form-check-label" for="inlineRadio1">Now Order Address</label>
			</div>
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
			  <label class="form-check-label" for="inlineRadio2">New Order Address</label>
			</div>
			<div class="col-md-7 col-lg-8" id="homeadd">
	          	<div class="row g-4">
	            <div class="col-sm-4">
	            <br />
	              <label for="firstName" class="form-label">Order name</label>
	              <input type="text" class="form-control" id="userName" placeholder="press your Name" value="<%= loginUser.getUserName() %>" required>
	              </div>
	            </div>
	
	            <div class="col-7">
	              <label for="email" class="form-label">Email</label>
	              <input type="email" class="form-control" id="orderEmail" placeholder="press your Email" value="<%= loginUser.getUserEmail() %>" required>
	            </div>
	
	            <div class="col-12">
	              <label for="address" class="form-label">Address</label>
	              <input type="text" class="form-control" id="address" placeholder="press your Address" value="<%= loginUser.getUserAddress() %>" required>
	            </div>
			
           <!--  <div class="col-12">
              <label for="address2" class="form-label">Address 2 <span class="text-muted">(Optional)</span></label>
              <input type="text" class="form-control" id="address2" placeholder="Apartment or suite">
            </div> -->
				<br />
	           <label for="request">배송 요청 사항</label>
	           <select class="form-select" aria-label="Default select example" name="orderReq" required >
	               <option selected disabled>배송 시 요청사항을 선택해주세요.</option>
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
	
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>