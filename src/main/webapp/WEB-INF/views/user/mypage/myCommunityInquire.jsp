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
            <h1>내 게시글 조회</h1>
            <ul>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityInquire" style="color: black;">1:1문의</a></li>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityCommunity">커뮤니티</a></li>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityReview">리뷰</a></li>
            </ul>
        </div>

		<form action="" name="myInquireListFrm" method="POST">
        <table class="myCommunity_list">
            <thead>
                <th><input type="checkbox"></th>
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
                    <td><%= inq.getInquireTitle() %></td>
                    <td><%= inq.getInquireDate() %></td>
                    <% if(inq.getAnswerStatus() > 0) { %>
	                    <td style="color: lightgreen">답변완료</td>
                    <% } else {%>
                    	<td style="color: red">답변대기</td>
                    <% } %>
                </tr>
           		<%	}
            	} %>
            </tbody>
        </table>
        
		<div id="btn_area">
			<button type="submit" id="btn_myInquireList_del" onclick="myInquireListDel()">삭제하기</button>           
		</div>
		</form>
		<div id="pagebar">
			<%= request.getAttribute("pagebar") %>
		</div>
    </div>
<script>
const myInquireListDel = () => {
	
	const answer = confirm("삭제하시겠습니까?");
	
	if(answer){
		document.myInquireListFrm.action = "<%= request.getContextPath() %>/mypage/myInquireDel";
	}
};
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>