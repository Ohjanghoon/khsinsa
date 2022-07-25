<%@page import="com.kh.sinsa.user.model.dto.Del"%>
<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<<<<<<< HEAD
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous">
</script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/adminpage.css" />

=======
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/adminpage.css">
>>>>>>> branch 'master' of https://github.com/Ohjanghoon/khsinsa.git
<%
	List<User> userlist = (List<User>) request.getAttribute("userlist");
	//System.out.println("list@adminpage = " + list);
	String type = request.getParameter("usersearchType");
	String kw = request.getParameter("usersearchKeyword");
%>
<<<<<<< HEAD

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
	<class = "adminpage"><h1>ADMIN PAGE</h1></class>
    	<ul class = "ul">
        	<adminmenu>
            	<li><a>회원 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/requestManagement">요청 처리</li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/productManagement">상품 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/orderManagement">주문 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet">통계 관리</a></li>
            </adminmenu>
		</ul>
<h1 class="mt-4"><center>회원 관리</center></h1>
<div class="adminPage_content">
  	<table class="table" style = "width: 1000px;">
      <thead>
          <tr class = tablehead>
             <th class="th-1"><center>ID</center></th>
             <th class="th-2"><center>이름</center></th>
             <th class="th-3" ><center>주소</center></th>
             <th><center>휴대폰 번호</center></th>
             <th><center>이메일</center></th>
             <th class="th-6"><center>생년월일</center></th>
             <th class="th-7"><center>권한</center></th>
             <th class="th-8"><center>탈퇴여부</center></th>
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
		            <td><%= user.getUserAddress() %></td>
		            <td><%= user.getUserPhone() %></td>
		            <td><%= user.getUserEmail()!=null ? user.getUserEmail() : "" %></td>
		            <td><%= user.getUserBirthday() %></td>
		            <td><%= user.getUserRole() %></td>
		            <td><%= user.getUserDel() %></td>
		          </tr>
       <% 		}
       		} %>
        </tbody>  
  </table>
  <br>
  	<div id="pagebar">
		<%= request.getAttribute("pagebar") %>
	</div>
</div>
<div align = "center" id="body"><h1 class="mt-4"><center>탈퇴 회원</center></h1></div>
<div class="adminPage_content">
 <div class="d-flex flex-wrap justify-content-between">
  	<table class="adminPage_list">
      <thead>
          <tr class = tablehead>
             <th><center>ID</center></th>
             <th><center>이름</center></th>
             <th class="th-3"><center>주소</center></th>
             <th><center>휴대폰 번호</center></th>
             <th><center>이메일</center></th>
             <th><center>생년월일</center></th>
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
			            <td><%= user.getUserAddress() %></td>
			            <td><%= user.getUserPhone() %></td>
			            <td><%= user.getUserEmail()!=null ? user.getUserEmail() : "" %></td>
			            <td><%= user.getUserBirthday() %></td>
			            <td><%= user.getUserRole() %></td>
			            <td><%= user.getUserDel() %></td>
		          </tr>
       <% 		}}
       		} %>
        </tbody>  
  </table>
</div>
  
  	<div id="pagebar">
		<%= request.getAttribute("pagebar") %>
	</div>
</div>
<br>
=======
<main>
        <div class="container">
            <section class="py-5 text-center container">
                <h3>Admin Page</h3>
            </section>
            <nav class="py-2 bg-white border-top border-bottom" id="commnavi">
                <ul class="nav me-auto">
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/adminpage" class="nav-link link-dark px-2">회원관리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/requestmanagement" class="nav-link link-dark px-2">요청처리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/productManagement" class="nav-link link-dark px-2">상품관리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/ordermanagement" class="nav-link link-dark px-2">주문관리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet" class="nav-link link-dark px-2">통계관리</a></li>
                </ul>
            </nav>
            <br><br>
            <section class="py-2 text-center container">
                <h3>회원관리</h3>
                <br /><br />
                <div class="searchcon">
                    <label for="searchType"><h5>검색타입</h5></label> 
                    <br />
                    <select id="searchType" class="form-select" size="2" aria-label="size 2 select example">
						  <option value="user_id" <%= "user_id".equals(type) ? "selected" : "" %> selected>User ID</option>
						  <option value="user_name" <%= "user_name".equals(type) ? "selected" : "" %>>User Name</option>
					</select>
                    <br />
	                <div id="search-userId" class="search-type">
	                    <form action="<%=request.getContextPath()%>/admin/userFinder">
	                        <input type="hidden" name="searchType" value="user_id"/>
	                        <input type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." value="<%= "user_id".equals(type) ? kw : "" %>"/>
	                        <button type="submit" class="btn btn-outline-dark" >🔎</button>			
	                    </form>	
	                </div>
	                <br />
	                <div id="search-userName" class="search-type">
	                    <form action="<%=request.getContextPath()%>/admin/userFinder">
	                        <input type="hidden" name="searchType" value="user_name"/>
	                        <input type="text" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요." value="<%= "user_name".equals(type) ? kw : "" %>"/>
	                            <button type="submit" class="btn btn-outline-dark">🔎</button>
	                    </form>	
	                </div>
                	<br /><br /><br />
                <table class="table caption-top">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">BirthDay</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Email</th>
                        <th scope="col">Address</th>
                        <th scope="col">Role</th>
                        <th scope="col">Withdrawal</th>
                    </tr>
                </thead>
                <tbody>
<%
    if(userlist != null || !userlist.isEmpty()){
        for(User user : userlist) { 
            if(user.getUserDel() == Del.N) {
%>  
                    <tr>
                        <th scope="row"><%= user.getUserId() %></th>
                        <td><%= user.getUserName() %></td>
                        <td><%= user.getUserBirthday() %></td>
                        <td><%= user.getUserPhone() %></td>
                        <td><%= user.getUserEmail() %></td>
                        <td><%= user.getUserAddress() %></td>
                        <td><%= user.getUserRole() %></td>
                        <td><%= user.getUserDel() %></td>
                    </tr>
                    
<% 
                }
            }
        }
%> 
                </tbody>
                </table>
            </section>
            <br><br>
            <section class="py-2 text-center container">
                <h3>탈퇴회원</h3>
                <br /><br />
                <table class="table caption-top">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">BirthDay</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Email</th>
                        <th scope="col">Address</th>
                        <th scope="col">Role</th>
                        <th scope="col">Withdrawal</th>
                    </tr>
                </thead>
                <tbody>
<%
    if(userlist != null || !userlist.isEmpty()){
        for(User user : userlist) { 
            if(user.getUserDel() == Del.Y) {
%>                        
                    <tr>
                        <th scope="row"><%= user.getUserId() %></th>
                        <td><%= user.getUserName() %></td>
                        <td><%= user.getUserBirthday() %></td>
                        <td><%= user.getUserPhone() %></td>
                        <td><%= user.getUserEmail() %></td>
                        <td><%= user.getUserAddress() %></td>
                        <td><%= user.getUserRole() %></td>
                        <td><%= user.getUserDel() %></td>
                    </tr>
<% 
            } } }
%>
                </tbody>
                </table>
            </section>
        </div>
    </main>
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
>>>>>>> branch 'master' of https://github.com/Ohjanghoon/khsinsa.git
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>