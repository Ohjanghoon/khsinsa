<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.kh.sinsa.review.model.dto.Review"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/user/mypage/myPageHeader.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/user/mypage/myCommunity.css" />
<%
	List<Review> myReviewList = (List<Review>) request.getAttribute("list");
	
%>
    <div class="myCommunity_content">
        <div class="myCommunity_content_header">
            <h1>내 게시글 조회</h1>
            <ul>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityInquire">1:1문의</a></li>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityCommunity">커뮤니티</a></li>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityReview" style="color: black">리뷰</a></li>
            </ul>
        </div>

		<form action="" name="myInquireListFrm" method="POST">
        <table class="myCommunity_list">
            <thead>
                <th><input type="checkbox"></th>
                <th>상품번호</th>
                <th>내용</th>
                <th>작성일</th>
                <th>추천수</th>
            </thead>
            <tbody>
            	<% if(myReviewList != null && !myReviewList.isEmpty()) {
            		for(Review rev : myReviewList) { %>
                <tr>
                    <td><input type="checkbox" id="reviewNo" name="reviewNo" value="<%= rev.getReviewNo() %>"></td>
                    <td><%= rev.getProNo() %></td>
                    <td><%= rev.getReviewContent() %></td>
                    <td><%= new SimpleDateFormat("yyyy-MM-dd").format(rev.getReviewDate()) %></td>
                    <td><%= rev.getReviewRecommend() %></td>
                </tr>
                <%  }
            	   } else { %>
            	   <tr>
            	   	<td colspan="5">작성된 리뷰글이 없습니다.</td>
            	   </tr>
           	    <% } %>
            </tbody>
        </table>
        
		<div id="btn_area">
			<button type="submit" id="btn_myInquireList_del" onclick="myInquireListDel()">삭제하기</button>           
		</div>
		</form>
		<div class="pagebar">
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