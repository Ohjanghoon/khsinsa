<%@page import="java.text.DecimalFormat"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="com.kh.sinsa.cart.model.dto.Cart"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/user/mypage/myPageHeader.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/user/mypage/myCart.css">
<%
	List<Cart> myCartList = (List<Cart>) request.getAttribute("myCartList");
	List<Product> proInfoList = (List<Product>) request.getAttribute("proInfoList");
	List<ProductAttachment> proAttachList = (List<ProductAttachment>) request.getAttribute("proAttachList");
%>


<div class="myCart_content">
  	<div class="myCart_content_header">
  		<h2>장바구니</h2>
  	</div>
  	
	<form action="" name="myCartFrm">
	    <table class="myCart_list">
		    <thead>
		    	<th><input type="checkbox" id="checkAll" onclick="checkAllorNone(this)"></th>
	            <th name="proNo">상품정보</td>
	            <th name="proPrice">상품금액</td>
	            <th name="cartBuyStock">수량</td>
	            <th name="orderPrice">주문금액</td>
	            <th name="deliverType">배송형태 / 배송비</td>
		    </thead>
		    <tbody>
		    <% if(myCartList != null && !myCartList.isEmpty()) {
				for(Cart cart : myCartList) { 
					for(Product pro : proInfoList){
						for(ProductAttachment proAttach : proAttachList){
							if(cart.getProNo().equals(pro.getProNo()) && cart.getProNo().equals(proAttach.getProNo())){
							
				%>
				<tr>
					<td>
						<input type="checkbox" name="cartNo" value="<%= cart.getUserId() %>">
						<input type="hidden" name="cartNo" value="<%= cart.getProNo() %>">
					</td>
					<td name="proNo">
						<div class="proInfo">
				            <a href="<%= request.getContextPath() %>/product/productDetail?proNo=<%= pro.getProNo()%>">
				            	<img src="<%= request.getContextPath() %>/upload/product/<%= proAttach.getProOriginalFilename() %>">
			            	</a>
			            	<ul>
				        		<li><%= pro.getProNo() %> / <%= pro.getProType() %></li>
				        		<li>
					        		<a href="<%= request.getContextPath() %>/product/productDetail?proNo=<%= pro.getProNo()%>">
					        			<%= pro.getProName() %>
					        		</a>
				        		</li>
				        		<li>사이즈 : <%= pro.getProSize() %></li>
				        	</ul>
						</div>
					</td>
	            	<td name="proPrice"><%= new DecimalFormat("###,###").format(pro.getProPrice()) %>원</td>
		            <td name="cartBuyStock">
		            	<button	type="button" id="btn_stock_minus" onclick="stockMinus();">➖</button>
		            	<input type="number" name="cartBuyStock" min="1" value="<%= cart.getCartBuyStock() %>" />	
		            	<button type="button" id="btn_stock_plus" onclick="stockPlus();">➕</button>
		            </td>
		            <td name="orderPrice">
		            	<span><%= new DecimalFormat("###,###").format(pro.getProPrice() * cart.getCartBuyStock()) %> 원</span>
	            	</td>
		            <td name="deliverType">
		            	<span>택배배송</span>
		            	<br />
		            	<span>배송비 무료</span>
		            </td>
	            
				</tr>
		   	<%   		}
		   			  }
		   			}
		   		 }
			   }%>
		    </tbody>
	           
	   	</table>
          
	</form>
	<div id="myCart_btn_del_area">
		<button type="submit" id="btn_del" onclick="myCartListDel()">선택삭제</button>           
	</div>
   	<div class="pagebar">
		<%= request.getAttribute("pagebar") %>
	</div>    
	<div id="myCart_btn_order_area">
		<button type="submit" id="btn_order" onclick="">선택 상품 주문하기</button>           
	</div>
</div>
	
<script>
document.cartBuyStock
const stockMinus = () => {
	let cartBuyStock = document.querySelector("#btn_stock_minus").nextElementSibling.value;
	console.log(cartBuyStock);
};

const stockPlus = () => {

};

const stockInput = () => {
	console.log(document.querySelector("[name=cartBuyStock").value);
};
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>