<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.kh.sinsa.common.KhsinsaUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.sinsa.notice.model.dto.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Notice> list = (List<Notice>) request.getAttribute("list"); 

%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/share/shareList.css" />
        <div class="container">
         	<div id="header2"></div>
                
                
            <div id="main">
                <h1>공지사항<span style="font-size: 20px;"> Notice</span></h1>
                <hr style="width: 370px;">
                <br>
                <p>국내,외의 다양한 패션 트렌드, 브랜드 소식, 패션쇼 등의 패션 정보를 공유하는 주신사에 오신걸 환영합니다.</p>
                <br>
                <p style="font-weight:bold;">※ 여러분에게 좋은 소식을 가져다 드릴 공지사항입니다.</p>
                <br>
                <p style="font-weight:bold; color: red;">※ 공지사항에는 댓글을 남길 수 없습니다. 궁금하신 사항은 1대 1 문의에 남겨주세요.</p>
                <br>
               
                <div id="list">
                
                    <br>
                    
                    <%
						boolean canAdd = (loginUser != null && 
						 		 loginUser.getUserRole() == UserRole.A);
						if(canAdd){ 
					%>	 
                    <div>
                    	<button id="write" type="submit">글쓰기</button>
					</div>
					<% } %>
                    <table id="tbl-board">
                        <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>조회수</th>
                        </tr>
                    </thead>
                    <%
                    	if(list != null && !list.isEmpty()){
                    		for(Notice notice : list){                	
                    %>
                        <tr>
                            <td><%= notice.getNoticeNo() %></td>
                            <td>
                            <a href="<%= request.getContextPath() %>/notice/noticeView?no=<%= notice.getNoticeNo() %>"id="noticeTitle">
                            <%= KhsinsaUtils.escapeXml(notice.getNoticeTitle()) %></a>
                            

                            </td>
                            <td><%= notice.getNoticeWriter() %></td>
                            <td><%= new SimpleDateFormat("yyyy-MM-dd").format(notice.getNoticeDate()) %></td>
							<td><%= notice.getNoticeReadCount() %></td>
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
        		location.href = "<%= request.getContextPath() %>/notice/noticeAdd";
        	}
        	
        	
        	
        	
        });

        const loginAlert = () => {
        	alert("로그인후 이용할 수 있습니다.");
        	document.querySelector("standard").focus();
        };
        </script>
        
<%@ include file="/WEB-INF/views/common/footer.jsp" %>