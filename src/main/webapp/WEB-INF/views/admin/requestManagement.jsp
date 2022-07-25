<%@page import="com.kh.sinsa.inquire.model.dto.InquireExt"%>
<%@page import="com.kh.sinsa.inquire.model.dto.Inquire"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous">
</script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/requestManagement.css">
<%
	List<Inquire> inquireList = (List<Inquire>) request.getAttribute("inquireList");
	List<InquireExt> iq = (List<InquireExt>) request.getAttribute("inquireExtList");
%>
<main>
        <div class="container">
            <section class="py-5 text-center container">
                <h3>Admin Page</h3>
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
				<h3>1:1 문의</h3>
    				<table class="table caption-top">
        				<thead>
            				<tr class = tablehead>
                				<th scope="col">문의 유형</th>
                    			<th scope="col">번호</th>
                    			<th scope="col">제목</th>
                    			<th scope="col">작성자</th>
                    			<th scope="col">게시일</th>
							</tr>
						</thead>
            			<tbody>
<%
	if(inquireList != null || !inquireList.isEmpty()){
		for(Inquire inquire : inquireList){%>
		
        					<tr>
                    			<td class="nav-item"><a class="nav-link link-dark px-2">1 : 1 문의</a></td>
                        		<td class="nav-item"><a class="nav-link link-dark px-2"><%=inquire.getInquireNo()%></a></td>
                        		<td class="nav-item"><a href="<%=request.getContextPath()%>/inquire/inquireView?inquireNo=<%= inquire.getInquireNo()%>" class="nav-link link-dark px-2"><%=inquire.getInquireTitle()%></a></td>
                        		<td class="nav-item"><a class="nav-link link-dark px-2"><%=inquire.getUserId()%></a></td>
                        		<td class="nav-item"><a class="nav-link link-dark px-2"><%=inquire.getInquireDate()%></a></td>
                    		</tr>
<% 	}
		}
				
%>
						</tbody>
					</table>
				</section>
		</div>
		<p class="pagination justify-content-center"><%= request.getAttribute("pagebar") %></p>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>