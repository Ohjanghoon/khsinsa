<%@page import="com.kh.sinsa.user.model.dto.UserRole"%>
<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/user/mypage/myPageHeader.css" />
<div class="myPageHeader">
    <h1>MY PAGE</h1>
    <nav>
        <ul class="menu">
            <li><a href="<%= request.getContextPath()%>/mypage/transaction">주문내역 조회</a></li>
            <li><a href="<%= request.getContextPath()%>/mypage/cart">장바구니</a></li>
            <li><a href="<%= request.getContextPath()%>/mypage/myFavorite">관심상품</a></li>
            <li><a href="<%= request.getContextPath()%>/mypage/myCommunityInquire">게시글 확인</a></li>
            <li><a href="<%= request.getContextPath()%>/mypage/userEdit">개인정보 수정</a></li>
            </ul>
    </nav>
</div>
