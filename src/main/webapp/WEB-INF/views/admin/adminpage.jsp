<%@page import="com.kh.sinsa.user.model.dto.Del"%>
<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<User> userlist = (List<User>) request.getAttribute("userlist");
	//System.out.println("list@adminpage = " + list);
	String type = request.getParameter("usersearchType");
	String kw = request.getParameter("usersearchKeyword");
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/adminpage.css">

<script>
window.addEventListener('load', (e) => {
	document.querySelector("select#searchType").onchange = (e) => {
		document.querySelectorAll(".search-type").forEach((div, index) => {
			div.style.display = "none";			
		});
		let id;
		switch(e.target.value){
		case "user_id" : id = "userId"; break;
		case "user_name" : id = "userName"; break;
		}
		document.querySelector(`#search-\${id}`).style.display = "inline-block";
	}
});
</script>

<div align="center" id="body">
            <br>
            <class = "adminpage"><h1>ADMIN PAGE</h1></class>
            <ul class = "ul">
                <adminmenu>
                <li><a>회원 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/requestmanagement">요청 처리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/productManagement">상품 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/ordermanagement">주문 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet">통계 관리</a></li>
            </adminmenu>
            </ul>
            <br><br><br><br><br>
            <a><center>회원 관리</center></a>
            <br>
 <!-- 검색창 -->
	<div id="search-container">
		<label for="searchType">검색타입 :</label> 
        <select id="searchType">
            <option value="user_id" <%= "user_id".equals(type) ? "selected" : "" %>>아이디</option>		
            <option value="user_name" <%= "user_name".equals(type) ? "selected" : "" %>>회원명</option>
        </select>
        <div id="search-userId" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/userFinder">
                <input type="hidden" name="searchType" value="user_id"/>
                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." 
                	value="<%= "user_id".equals(type) ? kw : "" %>"/>
                <button type="submit">검색</button>			
            </form>	
     </div>
        <div id="search-userName" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/userFinder">
                <input type="hidden" name="searchType" value="user_name"/>
                <input type="text" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요."
                	value="<%= "user_name".equals(type) ? kw : "" %>"/>
                	<button type="submit">검색</button>
            </form>	
    </div>
  	<table class="table table-bordered">
      <thead>
          <tr class = tablehead>
             <th><center>ID</center></th>
             <th><center>이름</center></th>
             <th><center>생년월일</center></th>
             <th><center>휴대폰 번호</center></th>
             <th><center>이메일</center></th>
             <th><center>주소</center></th>
             <th><center>권한</center></th>
             <th><center>탈퇴여부</center></th>
          </tr>
        </thead>
        <tbody>
        <%
			if(userlist == null || userlist.isEmpty()){
		%>
			<tr>
				<td colspan="10" align="center"> 검색 결과가 없습니다. </td>
			</tr>
		<%
			} 
			else { for(User user : userlist) { 
        		if(user.getUserDel() == Del.N) {%>
		          <tr>
		            <td><%= user.getUserId() %></td>
		            <td><%= user.getUserName() %></td>
		            <td><%= user.getUserBirthday() %></td>
		            <td><%= user.getUserPhone() %></td>
		            <td><%= user.getUserEmail()!=null ? user.getUserEmail() : "" %></td>
		            <td><%= user.getUserAddress() %></td>
		            <td><%= user.getUserRole() %></td>
		            <td><%= user.getUserDel() %></td>
		            <!-- 탈퇴회원 처리 물어보기 -->
		          </tr>
       <% 		}
       		} %>
        </tbody>  
  </table>
  		<div id="pagebar">
		<%= request.getAttribute("pagebar") %>
		</div>
		
            <a><center>탈퇴 회원</center></a>
            <br>
 <!-- 검색창 -->
	<div id="search-container">
		<label for="searchType">검색타입 :</label> 
        <select id="searchType">
            <option value="user_id" <%= "user_id".equals(type) ? "selected" : "" %>>아이디</option>		
            <option value="user_name" <%= "user_name".equals(type) ? "selected" : "" %>>회원명</option>
        </select>
        <div id="search-userId" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/userFinder">
                <input type="hidden" name="searchType" value="user_id"/>
                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." 
                	value="<%= "user_id".equals(type) ? kw : "" %>"/>
                <button type="submit">검색</button>			
            </form>	
     </div>
        <div id="search-userName" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/userFinder">
                <input type="hidden" name="searchType" value="user_name"/>
                <input type="text" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요."
                	value="<%= "user_name".equals(type) ? kw : "" %>"/>
                	<button type="submit">검색</button>
            </form>	
    </div>
            <table class="table table-bordered">
                <thead>
                    <tr class = tablehead>
                       <th><center>ID</center></th>
                       <th><center>이름</center></th>
                       <th><center>생년월일</center></th>
                       <th><center>휴대폰 번호</center></th>
                       <th><center>이메일</center></th>
                       <th><center>주소</center></th>
                       <th><center>권한</center></th>
                       <th><center>탈퇴여부</center></th>
                    </tr>
                  </thead>
                  <tbody>
                  <% for(User user : userlist) { 
        			if(user.getUserDel() == Del.Y) {%>
		          	<tr>
			            <td><%= user.getUserId() %></td>
			            <td><%= user.getUserName() %></td>
			            <td><%= user.getUserBirthday() %></td>
			            <td><%= user.getUserPhone() %></td>
			            <td><%= user.getUserEmail()!=null ? user.getUserEmail() : "" %></td>
			            <td><%= user.getUserAddress() %></td>
			            <td><%= user.getUserRole() %></td>
			            <td><%= user.getUserDel() %></td>
			            <!-- 탈퇴회원 처리 물어보기 -->
		          </tr>
       <% 		}}
       		} %>
                    <br>
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>