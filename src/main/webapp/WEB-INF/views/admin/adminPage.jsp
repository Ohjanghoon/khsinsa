<%@page import="com.kh.sinsa.user.model.dto.Del"%>
<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous">
</script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/adminPage.css" />
<%
	List<User> userList = (List<User>) request.getAttribute("userList");
	System.out.println("userList =" + userList);
	String type = request.getParameter("usersearchType");
	String kw = request.getParameter("usersearchKeyword");
%>
<main>
			<div class="container">
				<section class="py-5 text-center container">
					<h3>Admin Page</h3>
        		</section>
            		<nav class="py-2 bg-white border-top border-bottom" id="commnavi">
                		<ul class="nav me-auto">
                  			<li class="nav-item"><a href="<%= request.getContextPath() %>/admin/adminpage" class="nav-link link-dark px-2">회원관리</a></li>
                  			<li class="nav-item"><a href="<%= request.getContextPath() %>/admin/requestManagement" class="nav-link link-dark px-2">요청처리</a></li>
                  			<li class="nav-item"><a href="<%= request.getContextPath() %>/admin/productManagement" class="nav-link link-dark px-2">상품관리</a></li>
                  			<li class="nav-item"><a href="<%= request.getContextPath() %>/admin/orderManagement" class="nav-link link-dark px-2">주문관리</a></li>
                		</ul>
            		</nav>
            <br><br><br><br>
            	<section class="py-2 text-center container">
                <h3>회원관리</h3>
            	</section>
            <div class="searchcon">
            	<label for="searchType"><h5>검색타입</h5></label>
                	<select id="searchType" class="form-select text-center" size="2" aria-label="size 2 select example">
						<option value="user_id" <%= "user_id".equals(type) ? "selected" : "" %> selected>User ID</option>
						<option value="user_name" <%= "user_name".equals(type) ? "selected" : "" %>>User Name</option>
					</select>
	        <div id="search-userId" class="search-type">
	        	<form action="<%=request.getContextPath()%>/admin/userFinder">
	            	<input type="hidden" name="searchType" value="user_id"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." value="<%= "user_id".equals(type) ? kw : "" %>"/>
	                <button type="submit" class="btn btn-outline-dark" >🔎</button>			
	            </form>	
	        </div>
	        <div id="search-userName" class="search-type">
	        	<form action="<%=request.getContextPath()%>/admin/userFinder">
	            	<input type="hidden" name="searchType" value="user_name"/>
	                <input type="text" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요." value="<%= "user_name".equals(type) ? kw : "" %>"/>
	                <button type="submit" class="btn btn-outline-dark">🔎</button>
	            </form>	
	        </div>
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
    if(userList != null || !userList.isEmpty()){
        for(User user : userList) { 
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
        <section class="py-2 text-center container">
			<h3>탈퇴회원</h3>
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
    if(userList != null || !userList.isEmpty()){
        for(User user : userList) { 
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
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>