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
	
	//System.out.println("myCartList = " + myCartList);
	//System.out.println("proInfoList = " + proInfoList);
	//System.out.println("proAttachList = " + proAttachList);
	
	String proNo = "";
%>


<div class="myCart_content">
  	<div class="myCart_content_header">
  		<h2>장바구니</h2>
  	</div>
  	<form action="" name="myCartFrm" method="post">
	    <table class="myCart_list">
		    <thead>
		    	<th><input type="checkbox" id="checkAll" onclick="checkAllorNone(this)"></th>
	            <th class="proNo">상품정보</td>
	            <th class="proPrice">상품금액</td>
	            <th class="cartBuyStock">수량</td>
	            <th class="orderPrice">주문금액</td>
	            <th class="deliverType">배송형태 / 배송비</td>
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
					<td>
						<input type="checkbox"
							class="cartProNo" 
							name="proNo" 
							value="<%= cart.getProNo() %>/<%= cart.getCartSize() %>/<%= cart.getCartBuyStock() %>" />
					</td>
	            	
					<td class="proInfo">
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
							
			            	<button	type="button" class="btn_stock_minus">➖</button>
			            	<input type="number" class="cartBuyStock" min="1" value="<%= cart.getCartBuyStock() %>"/>	
			            	<button type="button" class="btn_stock_plus">➕</button>
							<button type="button" class="btn_edit" value="<%= cart.getProNo() %>">변경</button>
			            </td>
		            <td class="orderPrice">
		            	<span><%= new DecimalFormat("###,###").format(pro.getProPrice() * cart.getCartBuyStock())  %> 원</span>
	            	</td>
		            <td class="deliverType">
		            	<span>택배배송</span>
		            	<br />
		            	<span>배송비 무료</span>
		            </td>
	            
				</tr>
		   	<%   			break;
		   					}
		   				}
		   			  	}
		   			}
		   		 }
			   } %>
		    </tbody>
	           
	   	</table>
		<div id="myCart_btn_del_area">
			<button type="button" id="btn_del" onclick="myCartListDel()">선택삭제</button>  
		</div>
	   	<div class="pagebar">
			<%= request.getAttribute("pagebar") %>
		</div>    
		<div id="myCart_btn_order_area">
			<button type="button" id="btn_order" onclick="myCartOrder()">선택 상품 주문하기</button>           
		</div>
	</form>
	<%-- 장바구니 수량 변경 --%>
	<form action="<%= request.getContextPath() %>/mypage/myCart/editStock " method="post" name="myCartEditFrm">
		<input type="hidden" name="proNo" value="" />
		<input type="hidden" name="cartBuyStock" value=""/>
	</form>
	
	<%-- 장바구니 선택 상품 주문 
	<form action="<%= request.getContextPath() %>/product/order/cartOrder" method="post" name="myCartOrderFrm">
		<input type="hidden" name="proNo" value="" />
		<input type="hidden" name="cartBuyStock" value=""/>
		<input type="hidden" name="cartSize" value="" />
	</form> --%>
</div>
	
<script>
/* 전체선택 체크박스 */
const checkAllorNone = (obj) => {
	
	const checks = document.querySelectorAll("[name=cartNo]");
	
	for(let i in checks){
		checks[i].checked = obj.checked;
	}
};

/* 삭제버튼 처리 */
const myCartListDel = () => {
	
	if(confirm("삭제하시겠습니까?")){
		const frm = document.myCartFrm;
		frm.action = "<%= request.getContextPath() %>/mypage/myCartDel";
		frm.submit();
	}
};

/* 선택 상품 주문 */
const myCartOrder = () => {
	
	if(confirm("선택한 상품을 주문하시겠습니까?")){
		const frm = document.myCartFrm;
		frm.action = "<%= request.getContextPath() %>/mypage/myCart/order";
		frm.submit();
	}	

};

/* 수량 변경 설정 */
document.querySelectorAll(".btn_edit").forEach((btn) => {
	
	btn.addEventListener('click', (e) => {
		const proNo = e.target.value;
		const cartBuyStock = e.target.previousElementSibling.previousElementSibling.value;
		const frm = document.myCartEditFrm;
		frm.proNo.value = proNo;
		frm.cartBuyStock.value = cartBuyStock;
		frm.submit();
		
	});
});
/* 수량 태그 설정 */
document.querySelectorAll(".cartBuyStock").forEach((inp) => {
	
	inp.addEventListener('change', (e) => {
		const stock = e.target;
		const minus = stock.previousElementSibling;
		if(stock.value < 1) {
			stock.value = 1;
			minus.style.opacity = 0.3;
		}
	});
});

/* 마이너스 버튼 설정 */
document.querySelectorAll(".btn_stock_minus").forEach((btn) => {
	
	btn.addEventListener('mousedown', (e) => {
	const stock = e.target.nextElementSibling;
		if(stock.value > 1) {
			stock.value--;
			e.target.style.opacity = 1;
		} else {
			e.target.style.opacity = 0.3;
		}
	});
	btn.addEventListener('mouseup', (e) => {
		const stock = e.target.nextElementSibling;
			if(stock.value == 1) {
				e.target.style.opacity = 0.3;
			}
		});
});

/* 플러스 버튼 설정 */
document.querySelectorAll(".btn_stock_plus").forEach((btn) => {
	
	btn.addEventListener('mouseup', (e) => {
	const stock = e.target.previousElementSibling;
	const minus = stock.previousElementSibling;
	
		if(stock.value >= 1) {
			stock.value++;
			minus.style.opacity = 1;
		}
	});
});


</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>