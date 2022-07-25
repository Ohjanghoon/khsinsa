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

        <div align="center" id="body">
            <br>
            <class = "adminpage"><h1>ADMIN PAGE</h1></class>
            <ul class = "ul">
                <adminmenu>
                <li><a href="<%= request.getContextPath() %>/admin/adminpage">회원 관리</a></li>
				<li><a href="<%= request.getContextPath() %>/admin/requestManagement">요청 처리</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/productManagement">상품 관리</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/orderManagement">주문 관리</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet">통계 관리</a></li>
            	</adminmenu>
            </ul>
            <br>
            <a><center>주문 관리</center></a>
            <br>
            <table class="table table-bordered" style = "width: 1024px;"> 
                <thead>
                    <tr>
                        <th>회원ID</th>
                        <th>상품NO</th>
                        <th>배송지</th>
                        <th>전화번호</th>
                        <th>요청사항</th>
                        <th>결제금액</th>
                        <th>결제일</th>
                        <th colspan="2">현황</th>
                    </tr>
                </thead>
                    <tbody>
                    <% if(orderlist == null || orderlist.isEmpty()){
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
	                    <% 		}}}
	       		 %>
	                    </tbody>
	            </table>
	            <br><br>
            <a><center>배송 완료</center></a>
            <br>
	            <table class="table table-bordered" style = "width: 1024px;"> 
	                <thead>
	                    <tr>
	                        <th style = "width: 8%">회원ID</th>
	                        <th style = "width: 8%">상품NO</th>
	                        <th style = "width: 21.5%">배송지</th>
	                        <th style = "width: 12.5%">전화번호</th>
	                        <th style = "width: 12.5%">요청사항</th>
	                        <th style = "width: 12.5%">결제금액</th>
	                        <th style = "width: 12.5%">결제일</th>
	                        <th style = "width: 12.5%" colspan="2">현황</th>
	                    </tr>
	                </thead>
	                    <tbody>
	                    <% if(orderlist == null || orderlist.isEmpty()){
                    		for(Order order : orderlist) {
                    			if("배송완료".equals(order.getOrderStatus())) {
					%>
	                    <tr>
	                        <td><%= order.getUserId()%></td>
	                        <td><%= order.getProNo()%></td>
	                        <td><%= order.getOrderAddress()%></td>
	                        <td><%= order.getOrderPhone()%></td>
	                        <td><%= order.getOrderReq()%></td>
	                        <td><%= order.getOrderPrice()%></td>
	                        <td><%= order.getOrderDate()%></td>
	                        <td>
	                        <form action="<%= request.getContextPath() %>/admin/orderManagement/orderStatusEdit" name="productFrm" method="POST">
	                        	<input type="hidden" name="orderNo" id="orderNo" value="<%= order.getOrderNo() %>" />
	                        		<select class="form-select" aria-label="Default select example" id="orderStatus" name="orderStatus">
			           					<option value="none" selected disabled><%= order.getOrderStatus() %></option>
			           					<option value="주문 대기">주문 대기</option>
			           					<option value="배송중">배송중</option>
			           					<option value="배송완료">배송완료</option>
			         				</select>
			       			</td>
			       			<td><button id="orderStatusEdit" class="btn btn-outline-primary">변경</button></td>
			       			</form>
	                    </tr>
	                    <% 		}}}
	       		 %>
	                    </tbody>
	            </table>
<div class="deliveryChange">
	<form role="form" method="post" class="deliveryForm">
	</form></div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>