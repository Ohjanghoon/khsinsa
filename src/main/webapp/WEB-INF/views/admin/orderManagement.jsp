<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin/orderManagement.css" />

        <div align="center" id="body">
            <br>
            <class = "adminpage"><h1>ADMIN PAGE</h1></class>
            <ul class = "ul">
                <adminmenu>
                <li><a href="<%= request.getContextPath() %>/adminpage.jsp">회원 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/requestManagement.jsp">요청 처리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/productManagement.jsp">상품 관리</a></li>
                <li class = :"li"><a>주문 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/StatisticsView.jsp">통계 관리</a></li>
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
                    <tr>
                        <td>honggd</td>
                        <td>100522</td>
                        <td>서울시 강남구 역삼동 11-11 우리집 1층</td>
                        <td>010-1234-1234</td>
                        <td>빨리 주세요.</td>
                        <td>50,000</td>
                        <td>2022.07.15</td>
                        <td><div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                            결제 완료</button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                              <li><a class="dropdown-item" href="#">배송 준비중</a></li>
                              <li><a class="dropdown-item" href="#">배송중</a></li>
                              <li><a class="dropdown-item" href="#">배송 완료</a></li>
                            </ul>
                          </div></td>
                    </tr>
                    </tbody>
            </table>
            <br>
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
                    <tr>
                        <td>honggd</td>
                        <td>100522</td>
                        <td>서울시 강남구 역삼동 11-11 우리집 1층</td>
                        <td>010-1234-1234</td>
                        <td>빨리 주세요.</td>
                        <td>50,000</td>
                        <td>2022.07.15</td>
                        <td>배송 완료</td>
                    </tr>
                    </tbody>
            </table>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>