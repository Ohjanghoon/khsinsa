<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/StatisticsView.css">

<class = "adminpage"><h1>ADMIN PAGE</h1></class>
        <div id="body">
            <br>
            <ul class = "ul">
                <adminmenu>
                    <li><a href="<%= request.getContextPath() %>/adminpage.html">회원 관리</a></li>
                    <li class = :"li"><a href="<%= request.getContextPath() %>/requestManagement.html">요청 처리</a></li>
                    <li class = :"li"><a href="<%= request.getContextPath() %>/productManagement.html">상품 관리</a></li>
                    <li class = :"li"><a href="<%= request.getContextPath() %>/orderManagement.html">주문 관리</a></li>
                    <li class = :"li"><a>통계 관리</a></li>
            </adminmenu>
            </ul>
            <a><center>접속 통계</center></a>
            <table class="searchtable"><th>검색 날짜 
                <div class="search">
                <input type="text" placeholder="0000 / 00 / 00" style="border:0 padding-top=2; text-align:center;">
                <img class = "searchimage" src="<%= request.getContextPath() %>/images/search.png" width="50">
                <!-- datepicker 템플릿으로 날짜 검색 구현 -->
                </div></th>
            </table>
            <br>
            <table class="connecttable" id="vertical-1">
                <tr>
                    <th>일별 접속 통계</th>
                    <td>93,210명 (전일 대비 )</td>
                </tr>
                <tr>
                    <th>월별 접속 통계</th>
                    <td>21,392,123명 (전일 대비 )</td>
                </tr>
            </table>
            <br><br><br>
                <a><center>매출 통계</center></a><br><br><br>
                <a><center>일별매출</center></a>
                <table class="table table-bordered"> 
                    <table class="table">
                        <thead>
                          <tr>
                             <th>회원ID</th>
                             <th>결제 금액</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                             <td>Honggd</td>
                             <td>83,500</td>
                          </tr>
                        </tbody> 
                    </table>
                </table><br><br><br>
                <a><center>월별매출</center></a>
                <table class="table table-bordered"> 
                    <table class="table">
                        <thead>
                          <tr>
                             <th>회원ID</th>
                             <th>결제 금액</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                             <td>Honggd</td>
                             <td>183,500</td>
                          </tr>
                        </tbody> 
                    </table>
                </table>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>