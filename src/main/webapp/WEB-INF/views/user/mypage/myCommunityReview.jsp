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
            <h2>내 게시글 조회</h2>
            <ul>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityInquire">1:1문의</a></li>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityCommunity">커뮤니티</a></li>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityReview" style="color: black">리뷰</a></li>
            </ul>
        </div>

		<form action="" name="myReviewListFrm" method="POST">
        <table class="myCommunity_list">
            <thead>
                <th><input type="checkbox" id="checkAll" onclick="checkAllorNone(this)"></th>
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
                    <td><a href=""><%= rev.getReviewContent() %></a></td>
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
        
		<div id="myCommunity_btn_area">
			<button type="submit" id="btn_del" onclick="myReviewListDel()">선택삭제</button>           
		</div>
		</form>
		<div class="pagebar">
			<%= request.getAttribute("pagebar") %>
		</div>
    </div>
<script>
const checkAllorNone = (obj) => {
	
	const checks = document.querySelectorAll("[name=reviewNo]");
	
	for(let i in checks){
		checks[i].checked = obj.checked;
	}
};

const myReviewListDel = () => {
	
	const answer = confirm("삭제하시겠습니까?");
	
	if(answer){
		document.myReviewListFrm.action = "<%= request.getContextPath() %>/mypage/myReviewDel";
	}
};
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>