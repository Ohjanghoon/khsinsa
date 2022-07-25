<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin/inquiredetail.css" />

<main>
        <div class="container">
            <section class="py-5 text-center container">
                <h3>Admin Page</h3>
            </section>
            <nav class="py-2 bg-white border-top border-bottom" id="commnavi">
                <ul class="nav me-auto">
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/adminPage" class="nav-link link-dark px-2">회원관리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/requestManagement" class="nav-link link-dark px-2">요청처리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/productManagement" class="nav-link link-dark px-2">상품관리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/orderManagement" class="nav-link link-dark px-2">주문관리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet" class="nav-link link-dark px-2">통계관리</a></li>
                </ul>
            </nav>
            <br><br>
            <main class="mt-5 pt-5">
                    <div class="row" style="margin-bottom:20px; margin-left:1px;">
                        <div class="col-lg-12">
                        </div>
                        </div>
                        <div class="panel" style="margin-left:1px;">
                        <div id="contAreaBox">
                        <div class="panel">
                        <div class="panel-body">
                        <form role="form" action="#" method="post">
                        <div class="table-responsive">
                        <table id="datatable-scroller" class="table">
                            <caption></caption>
                            <colgroup>
                                <col width="250px" />
                                <col />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th class="active" style="text-align:center; vertical-align : middle;">문의 유형</th>
                                    <td>
                                    1:1 문의
                                    </td>
                                </tr>
                                <tr>
                                    <th class="active" style="text-align:center; vertical-align : middle;">제목</th>
                                    <td>
                                    상품이 이상해요.
                                    </td>
                                </tr>
                                <tr>
                                    <th class="active" style="text-align:center; vertical-align : middle;">작성자</th>
                                    <td>
                                    홍길동
                                    </td>
                                </tr>
                                <tr>
                                    <th class="active" style="text-align:center; vertical-align : middle;">내용</th>
                                    <td><textarea name="content" id="" cols="100" rows="10">
                                    반팔티가 작네요. L로 교환해주세요.
                                    반팔티가 작네요. 교환해주세요.
                                    반팔티가 작네요. 교환해주세요.
                                    반팔티가 작네요. 교환해주세요.
                                    반팔티가 작네요. 교환해주세요.
                                    반팔티가 작네요. 교환해주세요.
                                    </textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="active" style="text-align:center; vertical-align : middle;">답변</th>
                                    <td>
                                    <textarea name="content" cols="60" rows="3" placeholder="댓글을 입력하세요."></textarea>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        </div>
                        <div style="margin-left:1px;">
                        <button type="submit" id = "inquire-comment-enroll"class="btn btn-secondary">작성 완료</button>
                        <a href="<%=request.getContextPath()%>/requestManagement.jsp"><button type="button" class="btn btn-dark">목록</button></a>
                </div>
                </main>

 <%@ include file="/WEB-INF/views/common/footer.jsp" %>