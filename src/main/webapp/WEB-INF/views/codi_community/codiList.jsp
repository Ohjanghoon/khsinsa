<%@page import="com.kh.sinsa.community.model.dto.CommunityAttachment"%>
<%@page import="com.kh.sinsa.community.model.dto.Community"%>
<%@page import="java.util.List"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/codi/codiList.css" />
<%
	List<Community> codiList = (List<Community>) request.getAttribute("codiList");
	List<CommunityAttachment> codiAttachList = (List<CommunityAttachment>) request.getAttribute("codiAttachList");
%>
<main>
	<div class="container">
	    <section class="py-5 text-center container">
	        <h3>Codi Book</h3>
	    </section>
	    <nav class="py-2 bg-white border-top border-bottom" id="commnavi">
	          <ul class="nav me-auto">
	            <li class="nav-item"><a href="<%= request.getContextPath() %>/community/codiList" class="nav-link link-dark px-2">코디북</a></li>
	            <li class="nav-item"><a href="<%= request.getContextPath() %>/share/shareList" class="nav-link link-dark px-2">정보공유</a></li>
	            <li class="nav-item"><a href="<%= request.getContextPath() %>/community/freeList" class="nav-link link-dark px-2">자유게시판</a></li>
	            <li class="nav-item"><a href="<%= request.getContextPath() %>/community/talkList" class="nav-link link-dark px-2">패션토크</a></li>
	          </ul>
	      </nav>
	      
	    <br><br><br />
	    <div class="justtext">
        <h3>코디북</h3>
        <br />
        <p>전문 스타일리스트가 제안하는 다양한 코디로 매일 반복되는 코디 고민을 덜어보세요.</p>
        <p>최신 트렌드부터 누구나 입기 쉬운 룩까지 다양한 코디법을 담았습니다.</p>
        <p id="warn">※ 부적절한 게시글/댓글의 경우 '삭제', '제한' 될 수 있는점 알려드립니다.</p>
<% if(loginUser != null && loginUser.getUserRole() == UserRole.A) { %>        
        <br />
        <button type="button" id="addComm" class="btn btn-outline-dark">글쓰기</button>
<% } %>
	    </div>
	    <br />
	    <div class="d-flex flex-wrap justify-content-between">
	    	<div class="align">
	       	 <form action="<%= request.getContextPath() %>/community/codiAlign" method="get">
	             <select class="form-select" aria-label="Default select example" id="align" name="align" onchange="this.form.submit()">
				  <option value="#" selected>정렬기준</option>
				  <option value="comm_content">게시글명</option>
				  <option value="comm_readcount">조회순</option>
				  <option value="comm_recommend">추천순</option>
				 </select>
	         </form>
	       	</div>
			<div class="search">
				<form class="d-flex" name="searchFrm" action="<%= request.getContextPath() %>/community/codiSearch" method="get">
		          <input type="text" name="search" id="search" class="form-control me-2" placeholder="Search..." aria-label="Search">
		          <button type="submit" class="btn btn-outline-dark">🔎</button>
		        </form>
			</div>
		</div>
        <br />
	    <div class="album py-6 bg-white">
            <div class="row row-cols-6 row-cols-md-3 g-5">
<% 
	if(codiList != null && !codiList.isEmpty()){  
		for(Community codi : codiList){
			for(CommunityAttachment codiAt : codiAttachList){
				if(codi.getCommNo().equals(codiAt.getCommNo())){
%>
                <div class="col">
                    <div class="card shadow-sm">
                       	<a href="<%= request.getContextPath() %>/community/codiView?commNo=<%= codi.getCommNo() %>">
                        <img src="<%= request.getContextPath() %>/upload/codi/<%= codiAt.getRenamedFilename() %>" alt="" width="100%" height="50%"/>
                        </a>
                        <div class="card-body">
                            <p class="card-text">[ <%= codi.getCommTitle() %> ]</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
<% if(loginUser != null && loginUser.getUserRole() == UserRole.A) { %>
                                    <button type="button" value="<%= codi.getCommNo() %>" class="btn btn-sm btn-outline-secondary editComm">Edit</button>
                                    <button type="button" value="<%= codi.getCommNo() %>" class="btn btn-sm btn-outline-secondary delComm">Delete</button>
                                    
<% } else { %>
									<middeum class="text-muted">조회수 : <%= codi.getCommReadCount() %></middeum>
									
<% } %>
                                </div>
                                <small class="text-muted"><%= codi.getCommDate() %></small>
                            </div>
                        </div>
                    </div>
                </div>
<%
				}
			}
		}
	}
%>
	        </div>
	    </div>
	</div>
	<br />
	<p class="pagination justify-content-center"><%= request.getAttribute("pagebar") %></p>
</main>
<form action="<%= request.getContextPath() %>/share/shareDelete" name="delCommFrm" method="post">
	<input type="hidden" name="no" />
</form>
<form action="<%= request.getContextPath() %>/community/codiEdit" name="editCommFrm" method="get">
	<input type="hidden" name="commNo" />
</form>
<form action="<%= request.getContextPath() %>/community/codiAdd" name="addCommFrm" method="get"></form>
<script>
	/* 게시글 등록 */
	document.querySelector("#addComm").addEventListener('click', (e) => {
				const frm = document.addCommFrm;
				frm.submit();
	});

	/* 게시글 수정 */
	document.querySelectorAll(".delComm").forEach((btn) => {
		btn.addEventListener('click', (e) => {
			if(confirm("해당 게시물을 정말 삭제하시겠습니까?")){
				const {value} = e.target;
				const frm = document.delCommFrm;
				frm.no.value = value;
				frm.submit();
			}	
		});
	});

	/* 게시글 삭제 */
	document.querySelectorAll(".editComm").forEach((btn) => {
		btn.addEventListener('click', (e) => {
				const {value} = e.target;
				const frm = document.editCommFrm;
				frm.commNo.value = value;
				frm.submit();
		});
	});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>