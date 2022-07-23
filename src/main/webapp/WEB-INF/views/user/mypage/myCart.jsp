<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
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
	List<Product> _proInfoList = (List<Product>) request.getAttribute("proInfoList");
	List<ProductAttachment> _proAttachList = (List<ProductAttachment>) request.getAttribute("proAttachList");
	
	HashSet<Product> proInfoList = new HashSet<>(_proInfoList);
	HashSet<ProductAttachment> proAttachList = new HashSet<>(_proAttachList);
	
	System.out.println("myCartList = " + myCartList);
	System.out.println("proInfoList = " + proInfoList);
	System.out.println("proAttachList = " + proAttachList);
	
	String proNo = "";
%>


<div class="myCart_content">
  	<div class="myCart_content_header">
  		<h2>장바구니</h2>
  	</div>
  	
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
						if(cart.getProNo().equals(pro.getProNo())){
						for(ProductAttachment proAttach : proAttachList){
							if(cart.getProNo().equals(proAttach.getProNo())){
													
						
							
				%>
				<tr>
	            	<form action="<%= request.getContextPath() %>/mypage/myCart/editStock " method="post" name="myCartEditFrm">
					<td>
						<input type="checkbox" name="cartNo" >
						<input type="hidden" name="proNo" value="<%= cart.getProNo() %>">
					</td>
					<td class="proNo">
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
				        		<li>사이즈 : <%= cart.getCartSize() %></li>
				        	</ul>
						</div>
					</td>
	            	<td class="proPrice"><%= new DecimalFormat("###,###").format(pro.getProPrice()) %>원</td>
			            <td class="cartBuyStock">
			            	<button	type="button" class="btn_stock_minus" onclick="stockMinus();">➖</button>
			            	<input type="number" name="cartBuyStock" min="1" value="<%= cart.getCartBuyStock() %>"/>	
			            	<button type="button" class="btn_stock_plus">➕</button>
							<button type="submit" class="btn_edit" >변경</button>
			            </td>
		            <td class="orderPrice">
		            	<span><%= new DecimalFormat("###,###").format(pro.getProPrice() * cart.getCartBuyStock()) %> 원</span>
	            	</td>
		            <td class="deliverType">
		            	<span>택배배송</span>
		            	<br />
		            	<span>배송비 무료</span>
		            </td>
		            </form>
	            
				</tr>
		   	<%   			}
		   				}
		   			  }
		   			}
		   		 }
			   }%>
		    </tbody>
	           
	   	</table>
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
document.querySelectorAll("[name=cartBuyStock]").forEach((inp) => {
	inp.addEventListener('blur', (e) => {
		const stock = e.target;
		if(stock.value < 1) {
			alert("1 이상의 숫자만 입력가능합니다.");
			stock.value = 1;
			return false;
		}
	});
});
const checkAllorNone = (obj) => {
	
	const checks = document.querySelectorAll("[name=cartNo]");
	
	for(let i in checks){
		checks[i].checked = obj.checked;
	}
};
const stockMinus = () => {
	
};

const stockPlus = () => {

};

const stockInput = () => {
	console.log(document.querySelector("[name=cartBuyStock").value);
};
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>