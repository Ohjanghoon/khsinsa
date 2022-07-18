<%@page import="com.kh.sinsa.user.model.dto.UserRole"%>
<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <nav>
        <ul class="menu">
            <li><a href="01.orderlist.html">주문내역조회</a></li>
            <li><a href="<%=request.getContextPath()%>/mypage/cart">장바구니</a></li>
            <li><a href="03interest.html">관심상품</a></li>
            <li><a href="04.postCheck.html">게시글확인</a></li>
            <li><a href="<%=request.getContextPath()%>/mypage/userEdit">회원정보변경</a></li>
        </ul>
    </nav>

