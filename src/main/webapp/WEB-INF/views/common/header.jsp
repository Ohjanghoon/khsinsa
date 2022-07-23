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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <title>KH sinsa</title>
    <script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
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
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-white">
            <div class="container-md">
              <a class="navbar-brand" href="<%= request.getContextPath() %>"><img src="<%= request.getContextPath() %>/images/logo.png" alt="150" width="130" height="45" class="d-inline-block align-text-top"></a>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarScroll">
                <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarScrollingDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      SHOP
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">
                      <li><a class="dropdown-item" href="<%= request.getContextPath() %>/product/productTopFind">TOP(상의)</a></li>
                      <li><hr class="dropdown-divider"></li>
                      <li><a class="dropdown-item" href="<%= request.getContextPath() %>/product/productBottomFindServlet">BOTTOM(하의)</a></li>
                    </ul>
                  </li>
                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarScrollingDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      COMMUNITY
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">
                      <li><a class="dropdown-item" href="#">Outfit Of The Day</a></li>
                      <li><hr class="dropdown-divider"></li>
                      <li><a class="dropdown-item" href="<%= request.getContextPath() %>/community/codiList">Style Book</a></li>
                      <li><hr class="dropdown-divider"></li>
                      <li><a class="dropdown-item" href="<%=request.getContextPath()%>/share/shareList">Info Sharing</a></li>
                      <li><hr class="dropdown-divider"></li>
                      <li><a class="dropdown-item" href="#">Free Board</a></li>
                      <li><hr class="dropdown-divider"></li>
                      <li><a class="dropdown-item" href="#">Fashion Talk</a></li>
                    </ul>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/notice/noticeView">공지사항</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/inquire/inquireList">1:1문의</a>
                  </li>
                </ul>
                <form class="d-flex">
                <% if(loginUser != null) {
            		if(loginUser.getUserRole() == UserRole.U){ 
                %>
                        <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/mypage/myOrderList" id="my">MY PAGE</a>
                        </li>
                <%		} else { %>
                        <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/admin/adminpage" id="admin">ADMIN PAGE</a>
                        </li>
                <%  	} %>
	            	<a class="btn btn-sm btn-outline-secondary" href="<%= request.getContextPath() %>/user/userLogout">LogOut</a>
			    <% } else { %> 
                    <a class="btn btn-sm btn-outline-secondary btn-longin" href="<%= request.getContextPath() %>/user/userLogin">LogIn</a>
                    <% } %>
                </form>
              </div>
            </div>
          </nav>
    </header>
 