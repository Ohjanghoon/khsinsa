<%@page import="com.kh.sinsa.inquire.model.dto.InquireExt"%>
<%@page import="com.kh.sinsa.inquire.model.dto.Inquire"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/user/mypage/myPageHeader.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/user/mypage/myCommunity.css" />
<%
	List<InquireExt> myInquireList = (List<InquireExt>) request.getAttribute("list");
	
%>
    <div class="myCommunity_content">
        <div class="myCommunity_content_header">
            <h2>내 게시글 조회</h2>
            <ul>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityInquire" style="color: black;">1:1문의</a></li>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityCommunity">커뮤니티</a></li>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityReview">리뷰</a></li>
            </ul>
        </div>

		<form action="" name="myInquireListFrm" method="POST">
        <table class="myCommunity_list">
            <thead>
                <th><input type="checkbox" id="checkAll" onclick="checkAllorNone(this)"></th>
                <th>문의 유형</th>
                <th>제목</th>
                <th>작성일</th>
                <th>처리상태</th>
            </thead>
            <tbody>
            	<% 
           		if(myInquireList != null && !myInquireList.isEmpty()) {
            		for(InquireExt inq : myInquireList) { %>
            			
                <tr>
                    <td><input type="checkbox" id="inquireNo" name="inquireNo" value="<%= inq.getInquireNo() %>"></td>
                    <td><%= inq.getInquireCategory() %></td>
                    <td><a href=""><%= inq.getInquireTitle() %></a></td>
                    <td><%= inq.getInquireDate() %></td>
                    <% if(inq.getAnswerStatus() > 0) { %>
	                    <td style="color: rgb(0, 185, 28); font-weight: bold;">답변 완료</td>
                    <% } else {%>
                    	<td style="color: rgb(80, 80, 80); font-weight: bold;">답변 대기</td>
                    <% } %>
                </tr>
           		<%	}
            	} 
           		else { %>
           			<tr>
           				<td colspan="5">작성된 문의글이 없습니다.</td>
           			</tr>
           		<% } %>
            </tbody>
        </table>
        
		<div id="myCommunity_btn_area">
			<button type="submit" id="btn_del" onclick="myInquireListDel()">선택삭제</button>           
		</div>
		</form>
		<div class="pagebar">
			<%= request.getAttribute("pagebar") %>
		</div>
    </div>
<script>
const checkAllorNone = (obj) => {
	
	const checks = document.querySelectorAll("[name=inquireNo]");
	
	for(let i in checks){
		checks[i].checked = obj.checked;
	}
};
const myInquireListDel = () => {
	
	const answer = confirm("삭제하시겠습니까?");
	
	if(answer){
		document.myInquireListFrm.action = "<%= request.getContextPath() %>/mypage/myInquireDel";
	}
};
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>