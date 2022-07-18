<%@page import="com.kh.sinsa.user.model.dto.Del"%>
<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/adminpage/adminpage.css">

<%
	List<User> list = (List<User>) request.getAttribute("list");
	//System.out.println("list@adminpage = " + list);
	String type = request.getParameter("searchType");
	String kw = request.getParameter("searchKeyword");
	
	
%>

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
      <li><a href="#">회원 관리</a></li>
      <li class = :"li"><a href="<%= request.getContextPath() %>/requestManagement.jsp">요청 처리</a></li>
      <li class = :"li"><a href="<%= request.getContextPath() %>/productManagement.jsp">상품 관리</a></li>
      <li class = :"li"><a href="<%= request.getContextPath() %>/orderManagement.jsp">주문 관리</a></li>
      <li class = :"li"><a href="<%= request.getContextPath() %>/StatisticsView.jsp">통계 관리</a></li>
  </adminmenu>
  </ul>
  <br>
  <a><center>회원 관리</center></a>
  <br>
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
        <% for(User user : list) { 
        		if(user.getUserDel() == Del.N) {%>
		          <tr>
		            <td><%= user.getUserId() %></td>
		            <td><%= user.getUserName() %></td>
		            <td><%= user.getUserBirthday() %></td>
		            <td><%= user.getUserPhone() %></td>
		            <td><%= user.getUserEmail()!=null ? user.getUserEmail() : "" %></td>
		            <td><%= user.getUserAddress() %></td>
		            <td>
		              <select class="member-role" data-member-id="<%= user.getUserId() %>">
		                <option value="A" <%= UserRole.A == user.getUserRole() ? "selected" : "" %>>관리자</option>
		                <option value="U" <%= UserRole.U == user.getUserRole() ? "selected" : "" %>>일반</option>
		              </select>	 --%>
		            </td>
		            <td>탈퇴여부</td>
		            <!-- 탈퇴회원 처리 물어보기 -->
		          </tr>
       <% 		}
       		} %>
        </tbody>  
  </table>
            <a><center>탈퇴 회원</center></a>
            <br>
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
                    <% for(User user : list) { 
        		if(user.getUserDel() == Del.Y) {%>
		          <tr>
		            <td><%= user.getUserId() %></td>
		            <td><%= user.getUserName() %></td>
		            <td><%= user.getUserBirthday() %></td>
		            <td><%= user.getUserPhone() %></td>
		            <td><%= user.getUserEmail()!=null ? user.getUserEmail() : "" %></td>
		            <td><%= user.getUserAddress() %></td>
		            <td>
		              <select class="member-role" data-member-id="<%= user.getUserId() %>">
		                <option value="A" <%= UserRole.A == user.getUserRole() ? "selected" : "" %>>관리자</option>
		                <option value="U" <%= UserRole.U == user.getUserRole() ? "selected" : "" %>>일반</option>
		              </select>	 --%>
		            </td>
		            <td>탈퇴여부</td>
		            <!-- 탈퇴회원 처리 물어보기 -->
		          </tr>
       <% 		}
       		} %>
                    <br>
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>