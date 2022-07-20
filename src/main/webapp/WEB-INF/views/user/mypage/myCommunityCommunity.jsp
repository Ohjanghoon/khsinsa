<%@page import="com.kh.sinsa.community.model.dto.Community"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/user/mypage/myPageHeader.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/user/mypage/myCommunity.css" />
<%
	List<Community> myCommunityList= (List<Community>) request.getAttribute("list");
	
%>
    <div class="myCommunity_content">
        <div class="myCommunity_content_header">
            <h1>내 게시글 조회</h1>
            <ul>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityInquire">1:1문의</a></li>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityCommunity" style="color: black;">커뮤니티</a></li>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityReview">리뷰</a></li>
            </ul>
        </div>

		<form action="" name="myInquireListFrm" method="POST">
        <table class="myCommunity_list">
            <thead>
                <th><input type="checkbox"></th>
                <th>게시글 유형</th>
                <th>제목</th>
                <th>작성일</th>
                <th>조회수</th>
                <th>추천수</th>
            </thead>
            <tbody>
           	<% if(myCommunityList != null && !myCommunityList.isEmpty()) {
				for(Community comm : myCommunityList) { 
           			String _category = comm.getCommNo().substring(0, 2);
           			
           			String category = "";
					switch(_category) {
						case "C1" : category = "ootd 게시판"; break;
						case "C3" : category = "정보공유 게시판"; break;
						case "C4" : category = "자유게시판"; break;
						case "C5" : category = "패션토크 게시판"; break;
               		}
           	%>
               <tr>
                   <td><input type="checkbox" id="commNo" name="commNo" value="<%= comm.getCommNo() %>"></td>
                  	<td><%= category %></td>
                   <td><%= comm.getCommTitle() %></td>
                   <td><%= comm.getCommDate() %></td>
                 	<td><%= comm.getCommReadCount() %></td>
                 	<td><%= comm.getCommRecommand() %></td>
               </tr>
               <%
               	 }
          		} else { %>
          		<tr>
          			<td colspan="5">작성된 게시글이 없습니다.</td>
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