<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.sinsa.order.model.dto.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin/orderManagement.css" />

<%
	List<Order> orderlist = (List<Order>) request.getAttribute("orderlist");
	//System.out.println("list@adminpage = " + list);
	String type = request.getParameter("ordersearchType");
	String kw = request.getParameter("ordersearchKeyword");
%>

<main>
	<div class="container">
		<section class="py-5 text-center container">
			<h3>Admin Page</h3>
        	<nav class="py-2 bg-white border-top border-bottom" id="commnavi">
                <ul class="nav me-auto">
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/adminPage" class="nav-link link-dark px-2">회원관리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/requestManagement" class="nav-link link-dark px-2">요청처리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/productManagement" class="nav-link link-dark px-2">상품관리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/orderManagement" class="nav-link link-dark px-2">주문관리</a></li>
                </ul>
            </nav>
            <br><br>
            <h3>배송현황[주문 대기]</h3>
            <br>
            	<table table class="table caption-top"> 
	                <thead>
	                    <tr>
	                        <th scope="col">회원ID</th>
	                        <th scope="col">상품NO</th>
	                        <th scope="col">배송지</th>
	                        <th scope="col">전화번호</th>
	                        <th scope="col">요청사항</th>
	                        <th scope="col">결제<br>금액</th>
	                        <th scope="col">결제일</th>
	                        <th scope="col" colspan="2">현황</th>
	                    </tr>
	                </thead>
	                    <tbody>
	                    <% if(orderlist != null || orderlist.isEmpty()){
	                    	for(Order order : orderlist) {
	                    		if("주문 대기".equals(order.getOrderStatus())) {
						%>
		                	<tr>
		                        <td><%= order.getUserId() %></td>
		                        <td><%= order.getProNo() %></td>
		                        <td><%= order.getOrderAddress() %></td>
		                        <td><%= order.getOrderPhone() %></td>
		                        <td><%= order.getOrderReq() %></td>
		                        <td><%= order.getOrderPrice() %></td>
		                        <td><%= order.getOrderDate() %></td>
		                        <td><%= order.getOrderStatus() %></td>
		                        <td>
		                        <form action="<%= request.getContextPath() %>/admin/orderManagement/orderStatusEdit" name="productFrm" method="POST">
		                        	<input type="hidden" name="orderNo" id="orderNo" value="<%= order.getOrderNo() %>" />
		                        		<select class="form-select" aria-label="Default select example" id="orderStatus" name="orderStatus">
				           					<option value="none" selected disabled>변경 주문 현황 선택</option>
				           					<option value="주문 대기">주문 대기</option>
				           					<option value="배송중">배송중</option>
				           					<option value="배송완료">배송완료</option>
				         				</select>
				       			</td>
				       			<td><button id="orderStatusEdit" class="btn btn-outline-primary">변경</button></td>
				       			</form>
		                    </tr>
<% 						}
                    }
                   }
%>
	            	</tbody>
	            </table>
<p class="pagination justify-content-center"><%= request.getAttribute("pagebar") %></p>
            <h3>배송현황[배송중]</h3>
            <br>
            	<table table class="table caption-top"> 
	                <thead>
	                    <tr>
	                        <th scope="col">회원ID</th>
	                        <th scope="col">상품NO</th>
	                        <th scope="col">배송지</th>
	                        <th scope="col">전화번호</th>
	                        <th scope="col">요청사항</th>
	                        <th scope="col">결제<br>금액</th>
	                        <th scope="col">결제일</th>
	                        <th scope="col" colspan="2">현황</th>
	                    </tr>
	                </thead>
	                    <tbody>
	                    <% if(orderlist != null || orderlist.isEmpty()){
	                    	for(Order order : orderlist) {
	                    		if("배송중".equals(order.getOrderStatus())) {
						%>
		                    <tr>
		                        <td><%= order.getUserId() %></td>
		                        <td><%= order.getProNo() %></td>
		                        <td><%= order.getOrderAddress() %></td>
		                        <td><%= order.getOrderPhone() %></td>
		                        <td><%= order.getOrderReq() %></td>
		                        <td><%= order.getOrderPrice() %></td>
		                        <td><%= order.getOrderDate() %></td>
		                        <td><%= order.getOrderStatus() %></td>
		                        <td>
		                        <form action="<%= request.getContextPath() %>/admin/orderManagement/orderStatusEdit" name="productFrm" method="POST">
		                        	<input type="hidden" name="orderNo" id="orderNo" value="<%= order.getOrderNo() %>" />
		                        		<select class="form-select" aria-label="Default select example" id="orderStatus" name="orderStatus">
				           					<option value="none" selected disabled>변경 주문 현황 선택</option>
				           					<option value="주문 대기">주문 대기</option>
				           					<option value="배송중">배송중</option>
				           					<option value="배송완료">배송완료</option>
				         				</select>
				       			</td>
				       			<td><button id="orderStatusEdit" class="btn btn-outline-primary">변경</button></td>
				       			</form>
		                    </tr>
	<% 							}
	                    	 }
	                   		}
	%>
		                    </tbody>
		            </table>
<p class="pagination justify-content-center"><%= request.getAttribute("pagebar") %></p>
	            <h3>배송현황[배송완료]</h3>
            <br>
            	<table table class="table caption-top"> 
	                <thead>
	                    <tr>
	                        <th scope="col">회원ID</th>
	                        <th scope="col">상품NO</th>
	                        <th scope="col">배송지</th>
	                        <th scope="col">전화번호</th>
	                        <th scope="col">요청사항</th>
	                        <th scope="col">결제<br>금액</th>
	                        <th scope="col">결제일</th>
	                        <th scope="col" colspan="2">현황</th>
	                    </tr>
	                </thead>
	                    <tbody>
	                    <% if(orderlist != null || orderlist.isEmpty()){
	                    	for(Order order : orderlist) {
	                    		if("배송완료".equals(order.getOrderStatus())) {
						%>
		                    <tr>
		                        <td><%= order.getUserId() %></td>
		                        <td><%= order.getProNo() %></td>
		                        <td><%= order.getOrderAddress() %></td>
		                        <td><%= order.getOrderPhone() %></td>
		                        <td><%= order.getOrderReq() %></td>
		                        <td><%= order.getOrderPrice() %></td>
		                        <td><%= order.getOrderDate() %></td>
		                        <td><%= order.getOrderStatus() %></td>
		                        <td>
		                        <form action="<%= request.getContextPath() %>/admin/orderManagement/orderStatusEdit" name="productFrm" method="POST">
		                        	<input type="hidden" name="orderNo" id="orderNo" value="<%= order.getOrderNo() %>" />
		                        		<select class="form-select" aria-label="Default select example" id="orderStatus" name="orderStatus">
				           					<option value="none" selected disabled>변경 주문 현황 선택</option>
				           					<option value="주문 대기">주문 대기</option>
				           					<option value="배송중">배송중</option>
				           					<option value="배송완료">배송완료</option>
				         				</select>
				       			</td>
				       			<td><button id="orderStatusEdit" class="btn btn-outline-primary">변경</button></td>
				       			</form>
		                    </tr>
	<% 							}
	                    	 }
	                   		}
	%>
		                    </tbody>
		            </table>
<p class="pagination justify-content-center"><%= request.getAttribute("pagebar") %></p>
	<div class="deliveryChange">
								<form role="form" method="post" class="deliveryForm">
								</form>
	</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>