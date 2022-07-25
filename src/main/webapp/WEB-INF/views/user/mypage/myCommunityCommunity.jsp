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
            <h2>내 게시글 조회</h2>
            <ul>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityInquire">1:1문의</a></li>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityCommunity" style="color: black;">커뮤니티</a></li>
                <li><a href="<%= request.getContextPath() %>/mypage/myCommunityReview">리뷰</a></li>
            </ul>
        </div>

		<form action="" name="myCommunityListFrm" method="POST">
        <table class="myCommunity_list">
            <thead>
                <th><input type="checkbox" id="checkAll" onclick="checkAllorNone(this)"></th>
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
           			String categoryView = "";
					switch(_category) {
						case "C3" : category = "정보공유 게시판"; categoryView="/share/shareView"; break;
						case "C4" : category = "자유게시판"; categoryView="/share/shareView"; break;
						case "C5" : category = "패션토크 게시판"; categoryView="/share/shareView"; break;
               		}
           	%>
               <tr>
                   	<td><input type="checkbox" id="commNo" name="commNo" value="<%= comm.getCommNo() %>"></td>
                  	<td><%= category %></td>
                   	<td><a href="<%= request.getContextPath() %><%= categoryView %>?no=<%= comm.getCommNo() %>"><%= comm.getCommTitle() %></a></td>
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
        
		<div id="myCommunity_btn_area">
			<button type="submit" id="btn_del" onclick="myCommunityListDel()">선택삭제</button>           
		</div>
		</form>
		<div class="pagebar">
			<%= request.getAttribute("pagebar") %>
		</div>
    </div>
<script>
const checkAllorNone = (obj) => {
	
	const checks = document.querySelectorAll("[name=commNo]");
	
	for(let i in checks){
		checks[i].checked = obj.checked;
	}
};
const myCommunityListDel = () => {
	
	const answer = confirm("삭제하시겠습니까?");
	
	if(answer){
		document.myCommunityListFrm.action = "<%= request.getContextPath() %>/mypage/myCommunityDel";
	}
};
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>