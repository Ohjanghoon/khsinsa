<%@page import="com.kh.sinsa.inquire.model.dto.InquireExt"%>
<%@page import="com.kh.sinsa.inquire.model.dto.Inquire"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
List<InquireExt> list = (List<InquireExt>) request.getAttribute("list");
String type = request.getParameter("searchType");
String kw = request.getParameter("searchKeyword");
%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/inquire/inquireList.css" />
<style>
div#search-inquireTitle {
	display: <%=type == null || "inquire_title".equals(type) ? "inline-block" : "none"%>;
}

div#search-inquireNo {
	display: <%="inquire_no".equals(type) ? "inline-block" : "none"%>;
}

div#search-userId {
	display: <%="user_id".equals(type) ? "inline-block" : "none"%>;
}
</style>
<script>
window.addEventListener('load', (e) => {
	document.querySelector("select#searchType").onchange = (e) => {
		document.querySelectorAll(".search-type").forEach((div, index) => {
			div.style.display = "none";			
		});
		let id;
		switch(e.target.value){
		case "inquire_no" : id = "inquireNo"; break;
		case "inquire_title" : id = "inquireTitle"; break;
		case "user_id" : id = "userId"; break;
		}
		document.querySelector(`#search-\${id}`).style.display = "inline-block";
	}
});
</script>


<div class="header">1:1문의</div>

<div class="container">
	<div class="th">
		<div class="row">
			<div class="col-lg-4">

				<input type="button" value="문의하기"
					onclick="location.href='<%=request.getContextPath()%>/inquire/inquireAdd';" />

			</div>

			<div class="col-lg-4">
				<span class="dropdown"> <select name="one" id="searchType"
					class="dropdown-select">


						<option value="inquire_title"
							<%="inquire_title".equals(type) ? "selectd" : ""%>>제목</option>
						<option value="inquire_no"
							<%="inquire_no".equals(type) ? "selectd" : ""%>>문의번호</option>
						<option value="user_id"
							<%="user_id".equals(type) ? "selectd" : ""%>>작성자</option>
				</select>
				</span>
			</div>

			<div class="col-lg-4">
				<div id="search-inquireTitle" class="search-type">
					<form action="<%=request.getContextPath()%>/inquire/inquireViewSh">
						<input type="hidden" name="searchType" value="inquire_title" /> <input
							type="text" name="searchKeyword"
							value="<%="inquire_title".equals(type) ? kw : ""%>" />
						<button type="submit">검색</button>
					</form>
				</div>

				<div id="search-inquireNo" class="search-type">
					<form action="<%=request.getContextPath()%>/inquire/inquireViewSh">
						<input type="hidden" name="searchType" value="inquire_no" /> <input
							type="text" name="searchKeyword"
							value="<%="inquire_no".equals(type) ? kw : ""%>" />
						<button type="submit">검색</button>

					</form>
				</div>

				<div id="search-userId" class="search-type">
					<form action="<%=request.getContextPath()%>/inquire/inquireViewSh">
						<input type="hidden" name="searchType" value="user_id" /> <input
							type="text" name="searchKeyword"
							value="<%="user_id".equals(type) ? kw : ""%>" />
						<button type="submit">검색</button>

					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="content">
	<div class="container">
		<div class="tr">
			<div class="row">
				<div class="col-lg-2">문의번호</div>
				<div class="col-lg-4">제목</div>
				<div class="col-lg-2">작성자</div>
				<div class="col-lg-2">작성일</div>
				<div class="col-lg-2">답변상태</div>
			</div>
		</div>
	</div>

	<%
	if(list != null && !list.isEmpty()){
	for (InquireExt iq : list) {
	%>
	<div class="container">
		<div class="td">
			<div class="row">
				<div class="col-lg-2">
					<span><%=iq.getInquireNo()%></span>
				</div>
				<div class="col-lg-4">
					<a href="<%=request.getContextPath()%>/inquire/inquireView?inquireNo=<%= iq.getInquireNo()%>"><%=iq.getInquireTitle()%></a>
				</div>
				<div class="col-lg-2">
					<span><%=iq.getUserId()%></span>
				</div>
				<div class="col-lg-2">
					<span><%=iq.getInquireDate()%></span>
				</div>
				<div class="col-lg-2">
					<span>          
					<% if(iq.getAnswerStatus() > 0) { %>
	                    <span>답변완료</span>
                    <% } else {%>
                    	<span>답변대기</span>
                    <% } %>
					</span>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	}
	%>
	<div class="container">
		<div class="td">
			<div class="row justify-content-md-center">
				<div class="col col-lg-2">
					<%=request.getAttribute("pagebar")%>
				</div>

			</div>
		</div>
	</div>

</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>