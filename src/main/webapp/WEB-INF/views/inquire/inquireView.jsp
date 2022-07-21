<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.kh.sinsa.inquire.model.dto.Inquire"%>
<%@page import="com.kh.sinsa.inquire.model.dto.InquireExt"%>
<%@ page import="java.util.List"%>



<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">


<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/inquire/inquireView.css" />

<%
InquireExt inquire = (InquireExt) request.getAttribute("inquire");
%>

<div id="title">
	<span><%=inquire.getInquireTitle()%></span>
</div>

<ul class="meta">
	<li>
		<dt>문의번호</dt>
		<dd><%=inquire.getInquireNo()%></dd>
	</li>
	<li>
		<dt>작성자</dt>
		<dd><%=inquire.getUserId()%></dd>
	</li>
	<li>
		<dt>작성일</dt>
		<dd><%=inquire.getInquireDate()%></dd>
	</li>

</ul>

<div class="content">


	<div class="qna question">
		<i class="que">Q</i>
		<p class="title">질문</p>
	</div>
	<div class="text">
		<p><%=inquire.getInquireContent()%></p>

	</div>
	<div class="qna answer">
		<i class="ans">A</i>
		<p class="title">답변</p>

		<div class="text">
			<p>관리자 답변은 어디로 ... -태준-</p>

		</div>
	</div>

	<div class="ctrl">
		<input type="button" value="삭제하기" onclick="deleteInquire()">
	</div>


	<form action="<%=request.getContextPath()%>/inquire/inquireDelete"
		method="post" name="inquireDel">
		<input type="hidden" name="no" value="<%=inquire.getInquireNo()%>" />
	</form>
	<script>
		const deleteInquire = () => {
			if(confirm("게시글을 삭제하시습니까?"))
				document.inquireDel.submit();
		};
	</script>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>