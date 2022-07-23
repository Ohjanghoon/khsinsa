<%@page import="com.kh.sinsa.user.model.dto.UserRole"%>
<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/adminpage/adminPageHeader.css" />
<div class="adminPageHeader">
    <h1>ADMIN PAGE</h1>
    <nav>
        <ul class="menu">
            <li><a href="<%= request.getContextPath() %>/admin/adminpage">회원 관리</a></li>
			<li><a href="<%= request.getContextPath() %>/admin/requestManagement">요청 처리</a></li>
            <li><a href="<%= request.getContextPath() %>/admin/productManagement">상품 관리</a></li>
            <li><a href="<%= request.getContextPath() %>/admin/orderManagement">주문 관리</a></li>
            <li><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet">통계 관리</a></li>
		</ul>
	</nav>
</div>