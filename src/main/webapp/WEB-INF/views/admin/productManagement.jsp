<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/adminpage/productManagement.css">

<div align="center" id="body">
            <br>
            <class = "adminpage"><h1>ADMIN PAGE</h1></class>
            <ul class = "ul">
                <adminmenu>
                <li><a href="<%= request.getContextPath() %>/adminpage.jsp">회원 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/requestManagement.jsp">요청 처리</a></li>
                <li class = :"li"><a>상품 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/orderManagement.jsp">주문 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/StatisticsView.jsp">통계 관리</a></li>
            </adminmenu>
            </ul>
            <br>
            <a><center>상품 관리</center></a>
            <br>
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button type="button" class="btn btn-secondary float-right">상품 등록</button></div>
            <table style="margin-left: auto; margin-right: auto;"> 
                <thead>
                    <tr>
                        <th style = "width: 8%">NO</th>
                        <th style = "width: 8%">분류</th>
                        <th style = "width: 11.5%">이름</th>
                        <th style = "width: 22.5%" colspan="2">내용</th>
                        <th style = "width: 12.5%">가격</th>
                        <th style = "width: 12.5%">사이즈</th>
                        <th style = "width: 12.5%" colspan="2">등록일</th>
                    </tr>
                </thead>
                    <tbody>
                        <td>50</td>
                        <td>상의</td>
                        <td>검은색 반팔</td>
                        <td><a href="<%= request.getContextPath() %>/productdetail.jsp"><img src="<%= request.getContextPath() %>../img/image.webp"></a></td>
                        <td><a href="<%= request.getContextPath() %>/productdetail.jsp">검은색 티</a></td>
                        <td>50,000</td>
                        <td>S / M / L</td>
                        <td>2022.07.15</td>
                        <td>
                            <button type="button" class="btn_edit">수정</button>
                            <button type="button" class="btn_delete">삭제</button>
                        </td>
                    </tbody>
            </table>
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>