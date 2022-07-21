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
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/requestManagement">요청 처리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/productManagement">상품 관리</a></li>
                <li class = :"li"><a>주문 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet">통계 관리</a></li>
            </adminmenu>
            </ul>
            <br>
            <a><center>주문 관리</center></a>
            <br>
            <table class="table table-bordered" style="margin-left: auto; margin-right: auto;"> 
                <thead>
                    <tr>
                        <th style = "width: 8%">회원ID</th>
                        <th style = "width: 8%">상품NO</th>
                        <th style = "width: 21.5%">배송지</th>
                        <th style = "width: 12.5%">전화번호</th>
                        <th style = "width: 12.5%">요청사항</th>
                        <th style = "width: 12.5%">결제금액</th>
                        <th style = "width: 12.5%">결제일</th>
                        <th style = "width: 12.5%">현황</th>
                    </tr>
                </thead>
                    <tbody>
                    <%
						if(orderlist == null || orderlist.isEmpty()){
					%>
					<tr>
						<td colspan="10" align="center"> 검색 결과가 없습니다. </td>
					</tr>
					<%
						} 
						else { for(Order order : orderlist) { %>
	                    <tr>
	                        <td><%= order.getOrderNo() %></td>
	                        <td><%= order.getProNo() %></td>
	                        <td><%= order.getOrderAddress() %></td>
	                        <td><%= order.getOrderPhone() %></td>
	                        <td><%= order.getOrderReq() %></td>
	                        <td><%= order.getOrderPrice() %></td>
	                        <td><%= order.getOrderDate() %></td>
	                        <td><%= order.getOrderStatus() %></td>
	                    </tr>
	                    <% 	}	%>
	
	        </tbody>  
	            </table>
	            <br><br>
            <a><center>배송 완료</center></a>
            <br>
	            <table class="table table-bordered" style="margin-left: auto; margin-right: auto;"> 
	                <thead>
	                    <tr>
	                        <th style = "width: 8%">회원ID</th>
	                        <th style = "width: 8%">상품NO</th>
	                        <th style = "width: 21.5%">배송지</th>
	                        <th style = "width: 12.5%">전화번호</th>
	                        <th style = "width: 12.5%">요청사항</th>
	                        <th style = "width: 12.5%">결제금액</th>
	                        <th style = "width: 12.5%">결제일</th>
	                        <th style = "width: 12.5%">현황</th>
	                    </tr>
	                </thead>
	                    <tbody>
	                    <% for(Order order : orderlist) { %>
	                    <tr>
	                        <td><%= order.getOrderNo()%></td>
	                        <td><%= order.getProNo()%></td>
	                        <td><%= order.getOrderAddress()%></td>
	                        <td><%= order.getOrderPhone()%></td>
	                        <td><%= order.getOrderReq()%></td>
	                        <td><%= order.getOrderPrice()%></td>
	                        <td><%= order.getOrderDate()%></td>
	                        <td><%= order.getOrderStatus()%></td>
	                    </tr>
	                    <% 		}}
	       		 %>
	                    </tbody>
	            </table>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>