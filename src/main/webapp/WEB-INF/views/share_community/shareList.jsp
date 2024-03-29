<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.kh.sinsa.common.KhsinsaUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.sinsa.community.model.dto.CommunityExt"%>
<%@page import="com.kh.sinsa.community.model.dto.Community"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Community> list = (List<Community>) request.getAttribute("list"); 

%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/share/shareList.css" />
        <div class="container">
            
                <div id="header2">COMMUNITY</div>
                <nav class="py-2 bg-white border-top border-bottom" id="commnavi">
	          <ul class="nav me-auto">
	            <li class="nav-item"><a href="<%= request.getContextPath() %>/community/codiList" class="nav-link link-dark px-2">코디북</a></li>
	            <li class="nav-item"><a href="<%= request.getContextPath() %>/share/shareList" class="nav-link link-dark px-2">정보공유</a></li>
	            <li class="nav-item"><a href="<%= request.getContextPath() %>/community/freeList" class="nav-link link-dark px-2">자유게시판</a></li>
	            <li class="nav-item"><a href="<%= request.getContextPath() %>/community/talkList" class="nav-link link-dark px-2">패션토크</a></li>
	          </ul>
	      </nav>
        
			<br><br><br>

            <div id="main">
                <h1>정보공유 게시판<span style="font-size: 20px;"> Share Information</span></h1>
                <hr style="width: 370px;">
                <br>
                <p>국내,외의 다양한 패션 트렌드, 브랜드 소식, 패션쇼 등의 패션 정보를 공유하는 커뮤니티 공간입니다.</p>
                <p style="font-weight:bold;">※ 패션에 관한 '질문'의 경우 패션토크 게시판 이용 부탁드립니다.</p>
                <p style="font-weight:bold; color: red;">※ 부적절한 게시글/댓글의 경우 '삭제', '제한' 될 수 있는점 알려드립니다.</p>
               
                <div id="list">
                <br>
                <div class="align">
	     	  	 <form action="<%= request.getContextPath() %>/share/shareAlign" method="get">
	             <select class="form-select" aria-label="Default select example" id="align" name="align" onchange="this.form.submit()">
				  <option value="#" selected>정렬기준</option>
				  <option value="comm_content">게시글명</option>
				  <option value="comm_readcount">조회순</option>
				  <option value="comm_recommend">추천순</option>
				 </select>
	         	 </form>
	       	</div>
			<div class="search">
				<form class="d-flex" name="searchFrm" action="<%= request.getContextPath() %>/share/shareSearch" method="get">
		          <input type="text" name="search" id="search" class="form-control me-2" placeholder="Search..." aria-label="Search">
		          <button type="submit" class="btn btn-outline-dark">🔎</button>
		        </form>
			</div>

			<br><br>

                  

                    <table id="tbl-board">
                        <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>조회수</th>
                            <th>추천수</th>
                        </tr>
                    </thead>
                    <%
                    	if(list != null && !list.isEmpty()){
                    		for(Community community : list){
                    			//CommunityExt community = (CommunityExt) _community;
                    	
                    %>
                        <tr>
                            <td><%= community.getCommNo() %></td>
                            <td>
                            <a href="<%= request.getContextPath() %>/share/shareView?no=<%= community.getCommNo() %>"id="commTitle">
                            <%= KhsinsaUtils.escapeXml(community.getCommTitle()) %></a>
                            

                            </td>
                            <td><%= community.getUserId() %></td>
                            <td><%= new SimpleDateFormat("yyyy-MM-dd").format(community.getCommDate()) %></td>
                            <td><%= community.getCommReadCount() %></td>
                            <td><%= community.getCommRecommand() %></td>
                        </tr>
        <%
				}	
			} 
			else { 
		%>	
		<tr>
			<td colspan="6">조회된 게시글이 없습니다.</td>
		</tr>
		<% } %>

                    </table>
                    <div id="pagebar">
                    <%= request.getAttribute("pagebar") %>
                    </div>
                <br>
            </div>
                <input  style="float:right;"
						type="button" value="글쓰기" id="write"/>
						<br>
 			 </div>
 			 
            </div>
        
        <script>
        document.querySelector("#write").addEventListener('click', (e) => {
        	if(<%= loginUser == null %>){
        		loginAlert();		
        	}else{
        		location.href = "<%= request.getContextPath() %>/share/shareAdd";
        	}
        	
        	
        	
        	
        });

        const loginAlert = () => {
        	alert("로그인후 이용할 수 있습니다.");
        	document.querySelector("standard").focus();
        };
        </script>
        
<%@ include file="/WEB-INF/views/common/footer.jsp" %>