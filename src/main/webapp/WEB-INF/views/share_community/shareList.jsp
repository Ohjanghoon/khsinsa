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
            <div id="headlist">
                <div id="header2">COMMUNITY</div>
                <nav class="navi">
                  <ul>
                      <li><a href="#">OOTD</a></li>
                      <li><a href="<%= request.getContextPath() %>/community/codiList">코디북</a></li>
                      <li><a href="<%=request.getContextPath()%>/share/shareList">정보공유</a></li>
                      <li><a href="<%= request.getContextPath() %>/community/freeist">자유게시판</a></li>
                      <li><a href="#">패션토크</a></li>
                  </ul>
              </nav>
        
        

            </div>


            <div id="main">
                <h1>정보공유 게시판<span style="font-size: 20px;"> Share Information</span></h1>
                <hr style="width: 370px;">
                <br>
                <p>국내,외의 다양한 패션 트렌드, 브랜드 소식, 패션쇼 등의 패션 정보를 공유하는 커뮤니티 공간입니다.</p>
                <br>
                <p style="font-weight:bold;">※ 패션에 관한 '질문'의 경우 패션토크 게시판 이용 부탁드립니다.</p>
                <br>
                <p style="font-weight:bold; color: red;">※ 부적절한 게시글/댓글의 경우 '삭제', '제한' 될 수 있는점 알려드립니다.</p>
                <br>
               
                <div id="list">
                    <br>
                    <div id="option">
                    <select name="standard" id="standard" size="1">
                    <option value="" selected>정렬기준</option>
                    <option value="1">인기게시글</option>
                    <option value="2">높은조회수</option>
                    <option value="3">최신게시글</option>
                    </select>

                    <div>
                    <select name="finder" id="finder" size="1" style="height: 30px;">
                        <option value="" selected>검색조건</option>
                        <option value="1">제목</option>
                        <option value="2">작성자</option>
                        <option value="3">본문내용</option>
                    </select>
                    
                    <input type="text" name="" id="" placeholder="검색어를 입력하세요" style="height: 26px;">
                    <button style="height: 30px;">검색</button>
                </div>
                    <button id="write" type="submit">글쓰기</button>


                    </div>

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
                

            </div>
        </div>
        
        <div>
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