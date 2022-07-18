<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin/reportdetail.css" />

<div align="center" id="body">
            <br>
            <class = "adminpage"><h1>ADMIN PAGE</h1></class>
            <ul class = "ul">
                <adminmenu>
                    <li><a href="<%=request.getContextPath()%>/adminpage.html">회원 관리</a></li>
                    <li class = :"li"><a href="<%=request.getContextPath()%>/requestManagement.html">요청 처리</a></li>
                    <li class = :"li"><a href="<%=request.getContextPath()%>/productManagement.html">상품 관리</a></li>
                    <li class = :"li"><a href="<%=request.getContextPath()%>/orderManagement.html">주문 관리</a></li>
                    <li class = :"li"><a href="<%=request.getContextPath()%>/StatisticsView.html">통계 관리</a></li>
            </adminmenu>
            </ul>
            <h1>신고</h1>
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
                    <table id="datatable-scroller"
                        class="table">
                        <caption></caption>
                        <colgroup>
                            <col width="250px" />
                            <col />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th class="active" style="text-align:center; vertical-align : middle;">게시글 제목</th>
                                <td>
                                사랑의 인사
                                </td>
                            </tr>
                            <!-- textarea 자동 높이 조절 진행 예정 -->
                            <tr>
                                <th class="active" style="text-align:center; vertical-align : middle;">내용</th>
                                <td><textarea name="content" id="" cols="100" rows="10">
                                    비 내리는 거릴 좋아했었죠
                                    우산 없이 나와 함께 걸었죠
                                    다시 내리는 비에 그대 생각나
                                    눈물 날 것 같은데
                                    </textarea>
                                </td>
                            </tr>
                            <tr>
                                <th class="active" style="text-align:center; vertical-align : middle;">답변</th>
                                <td>
                                <textarea name="content" cols="100" rows="10" placeholder="댓글을 입력하세요."></textarea>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    </div>
                    <div style="margin-left:1px;">
                    <button type="submit" id = "inquire-comment-enroll"class="btn btn-secondary">작성 완료</button>
                    <a href="<%=request.getContextPath()%>/requestManagement.html"><button type="button" class="btn btn-dark">목록</button></a>
            </div>
            </main>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>