<%@page import="com.kh.sinsa.inquire.model.dto.InquireExt"%>
<%@page import="com.kh.sinsa.inquire.model.dto.Inquire"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/requestManagement.css">

<%
	List<Inquire> inquirelist = (List<Inquire>) request.getAttribute("inquirelist");
	System.out.println("list@requestmanagement = " + inquirelist);
	String type = request.getParameter("searchType");
	String kw = request.getParameter("searchKeyword");
%>

 <div align="center" id="body">
            <br>
            <class = "adminpage"><h1>ADMIN PAGE</h1></class>
            <ul class = "ul">
                <adminmenu>
                    <li><a href="<%= request.getContextPath() %>/adminpage.jsp">회원 관리</a></li>
                    <li class = :"li">요청 처리</li>
                    <li class = :"li"><a href="<%= request.getContextPath() %>/productManagement.jsp">상품 관리</a></li>
                    <li class = :"li"><a href="<%= request.getContextPath() %>/orderManagement.jsp">주문 관리</a></li>
                    <li class = :"li"><a href="<%= request.getContextPath() %>/StatisticsView.jsp">통계 관리</a></li>
            </adminmenu>
            </ul>
            <br><br><br><br><br>
            <a><center>1:1 문의 [답변 대기중] </center></a>
            	<table class="table table-hover table-striped">
                	<thead>
                    	<tr class = tablehead>
                        	<th>문의 유형</th>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>게시일</th>
                        </tr>
                        	</thead>
                            	<tbody>
                            	<%
								if(inquirelist == null || inquirelist.isEmpty()){
								%>
									<tr>
										<td colspan="10" align="center"> 검색 결과가 없습니다. </td>
									</tr>
								<%
								} 
								else { for(Inquire inquire : inquirelist) {%>
                                        <tr>
                                            <td>1 : 1 문의</td>
                                            <td><%=inquire.getInquireNo()%></td>
                                            <td><a href="<%=request.getContextPath()%>/inquire/inquireView?inquireNo=<%= inquire.getInquireNo()%>"><%=inquire.getInquireTitle()%></a></td>
                                            <td><%=inquire.getUserId()%></td>
                                            <td><%=inquire.getInquireDate()%></td>
                                        </tr>
                                        <% 		}}
       		 %>
                                </tbody>
                            </table>
                        </div>
                        <div id="pagebar">
						<%= request.getAttribute("pagebar") %>
						</div>
                        <br><br><br><br><br>
                            <h1 class="mt-4"><center>신고</center></h1>
                        </div>
                        <div class="card-body">
                            <table class="table table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>문의 유형</th>
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>게시일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${boards}" var="board">
                                        <tr>
                                            <td>1 : 1 문의</td>
                                            <td>1</td>
                                            <td></a></td><!-- get.jsp -->
                                            <td>홍길동</td>
                                            <td>2022.07.14</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <br>
                        </div>
                    </div>
                </div>
                </main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>