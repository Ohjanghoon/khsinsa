<%@page import="java.text.DecimalFormat"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.kh.sinsa.order.model.dto.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file ="/WEB-INF/views/user/mypage/myPageHeader.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/user/mypage/myOrderList.css">
<%
	List<Order> myOrderList= (List<Order>) request.getAttribute("myOrderList");
	List<Product> proInfoList = (List<Product>) request.getAttribute("proInfoList");
	List<ProductAttachment> proAttachList = (List<ProductAttachment>) request.getAttribute("proAttachList");
%>	

<div class="myOrderList_content">
  	<div class="myOrderList_content_header">
  		<h2>주문내역 조회</h2>
  	</div>
  	
	<form action="" name="myOrderListFrm">
	    <table class="myOrderList_list">
		    <thead>
	            <th name="proNo">상품정보</td>
	            <th name="orderNo">주문번호</td>
	            <th name="orderDate">주문일자</td>
	            <th name="orderPrice">주문금액(수량)</td>
	            <th colspan="2" name="orderStatus">주문상태</td>
		    </thead>
		    <tbody>
		    <% if(myOrderList != null && !myOrderList.isEmpty()) {
				for(Order ord : myOrderList) { 
					for(Product pro : proInfoList){
						for(ProductAttachment proAttach : proAttachList){
							if(ord.getProNo().equals(pro.getProNo()) && ord.getProNo().equals(proAttach.getProNo())){
							
				%>
				<tr>
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
            	<td name="orderNo"><%= ord.getOrderNo() %></td>
	            <td name="orderDate"><%= new SimpleDateFormat("yyyy-MM-dd").format(ord.getOrderDate()) %></td>
	            <td name="orderPrice">
	            	<span><%= new DecimalFormat("###,###").format(ord.getOrderPrice()) %> 원</span>
	            	<br>
	            	<span name="orderAmount"><%= ord.getOrderAmount() %>개</span>
            	</td>
	            <td name="orderStatus"><%= ord.getOrderStatus() %></td>
	            	<%
		            if("배송완료".equals(ord.getOrderStatus())) { 
		            %>
	            	<td name="reviewAdd"><button type="button" id="btn_review_add">후기 작성</button></td>
		            <%
		            } else { 
		            %>
		            <td name="reviewAdd"><span id="review_wrong">후기작성불가</span></td>	
					<% } %>
	            
				</tr>
		   	<%   		}
		   			  }
		   			}
		   		 }
			   }%>
		    </tbody>
	           
	   	</table>
          
	</form>
    <div class="pagebar">
			<%= request.getAttribute("pagebar") %>
	</div>    
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>


