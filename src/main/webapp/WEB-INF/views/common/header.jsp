<%@page import="com.kh.sinsa.user.model.dto.UserRole"%>
<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String msg = (String) session.getAttribute("msg");
		if(msg != null){
		session.removeAttribute("msg");   //한번만 사용후 제거
	}

	User loginUser = (User) session.getAttribute("loginUser");
	//System.out.println("loginUser@header.jsp = " + loginUser);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/index.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <title>KH sinsa</title>
    <style>
    * {
    	font-famaily: 'Noto Sans', sans-serif !important;
    }
    </style>
    <script>
	window.onload = () => {
		<%	if(msg != null) { %>
				alert("<%= msg %>");
		<% } %>
	};
	</script>
</head>
<body>
    <div class="container">
    <header>
        <nav>
            <li><a href="<%= request.getContextPath() %>/product/productList">SHOP</a></li>
            <li><a href="#">COMMUNITY</a></li>
            <li><a href="#">고객센터</a></li>
        </nav>
            <li id="logo"><img src="<%= request.getContextPath() %>/images/logo.png" onclick="location.href='<%= request.getContextPath() %>'"></li>
        <nav>
            <li><a href="#">NOTICE</a></li>
            <% if(loginUser != null) {
            		if(loginUser.getUserRole() == UserRole.U){ 
            %>
		            	<li><a href="<%=request.getContextPath()%>/user/mypage">MY PAGE</a></li>
            <%		} else { %>
		            	<li><a href="#">ADMIN PAGE</a></li>
            <%  	} %>
            		<span>[<%= loginUser.getUserId() %>]님, 반갑습니다.</span>
	            	<li><a href=" <%= request.getContextPath() %>/user/logout">LOGOUT</a></li>
			<% }
               else { %>            
            	<li><a href=" <%= request.getContextPath() %>/user/login">LOGIN</a></li>
            <% } %>
        </nav>
    </header>
 