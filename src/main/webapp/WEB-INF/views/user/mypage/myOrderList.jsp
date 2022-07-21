<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.kh.sinsa.order.model.dto.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file ="/WEB-INF/views/user/mypage/myPageHeader.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/user/mypage/myOrderList.css">
<%
	List<Order> myOrderList= (List<Order>) request.getAttribute("myOrderlist");
	
%>	
<script>
window.addEventListener('load', () => {
	proInfo(proNo);
});

const proInfo = (proNo) => {
	$.ajax({
		url: "<%= request.getContextPath() %>/mypage/myOrderList/proInfo",
		data: {proNo},
		sucess(proList){
			console.log(proList);
			<a href=""><img src="" alt="" /></a>
        	<ul>
        		<li></li>
        		<li></li>
        		<li></li>
        	</ul>
		},
		error: console.log
		
	});
};
</script>	
	<div class="myOrderList_content">
  	<div class="myOrderList_content_header">
  		<h1>주문내역 조회</h1>
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
		    	%>
			        <tr>
			            <td name="proNo">
			            	
			            </td>
			            <td name="orderNo"><%= ord.getOrderNo() %></td>
			            <td name="orderDate"><%= new SimpleDateFormat("yyyy-MM-dd").format(ord.getOrderDate()) %></td>
			            <td name="orderPrice">
			            	<%= ord.getOrderPrice() %>
			            	<br>
			            	<span name="orderAmount"><%= ord.getOrderAmount() %>개</span>
		            	</td>
			            <td name="orderStatus"><%= ord.getOrderStatus() %></td>
		            	<td name="reviewAdd"><button type="button" id="btn_review_add">후기 작성</button></td>
			            <%
			            if("배송완료".equals(ord.getOrderStatus())) { 
			            		
			            }
			            else { 
			            	
		            	} %>
			            <td></td>
			        </tr>
		        <%  }
		           } %>
		    </tbody>
	           
	   	</table>
          
	</form>
        

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>


