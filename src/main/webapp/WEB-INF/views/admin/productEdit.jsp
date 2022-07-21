<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="com.kh.sinsa.admin.model.dto.ProductManagementExt"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Product product = (Product) request.getAttribute("product");
	List<ProductAttachment> productattachList = (List<ProductAttachment>) request.getAttribute("productattachList");
	String proNo = (String) request.getAttribute("proNo");
%>

<!-- // board -> product / attachments -> productattachList -->

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin/productEdit.css" />

<body>
	<div id="container">
		<div id="header1"></div>
		<div id="header2">Admin Page</div>
		<nav>
			<ul class="navi">
				<li><a href="<%= request.getContextPath() %>/admin/adminpage">회원관리</a></li>
				<li><a href="<%= request.getContextPath() %>/admin/requestmanagement">요청처리</a></li>
				<li><a href="<%= request.getContextPath() %>/admin/productManagement">상품관리</a></li>
				<li><a href="<%= request.getContextPath() %>/admin/ordermanagement">주문관리</a></li>
				<li><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet">통계관리</a></li>
			</ul>
		</nav>
		<form name="productEditFrm"
			action="<%=request.getContextPath()%>/admin/productManagement/productEdit" 
			method="post"
			enctype="multipart/form-data">
			<h2 style="font-size: 30px; color: black;">상품 수정</h2>
			<hr style="border-top: 3px solid black;">
			<div id="content" style="margin: 30px;">
				<br>
				<input type="text" name="proName" id="proName" value="<%= product.getProName() %>" required>
				<br>
				<input type="text" name="proPrice" id="proPrice" value="<%= Integer.toString(product.getProPrice())%>" required>
				<br>
				<input type="text" name="proSize" id="proSize" value="<%= product.getProSize().replace("\"", " &quot;") %>" required>
				<br>
				<% 
			if(productattachList != null && !productattachList.isEmpty()){
				for(int i = 0; i < productattachList.size(); i++){
					ProductAttachment productattach = productattachList.get(i);
		%>
				<img src="<%= request.getContextPath() %>/images/file.png" width="16px" />
				<%= productattach.getProOriginalFilename() %>
				<input 
					type="checkbox" name="delFile" 
					id="delFile<%= i %>" value="<%= productattach.getProAttachmentNo() %>"/>
				<label for="delFile<%= i %>">삭제</label>
				<br />
		<%
				}
			}
		%>
			<input type="file" name="upFile1">
			<input type="file" name="upFile2">
				<p>
				<textarea name="proContent" cols="10" rows="10"><%= product.getProContent() %></textarea>
				</p>

		<div id="btn-sum" style="margin:30px;">
			<span class="btn-edit"> <input type="submit" id="btn-edit" value="수정" style="width:150px;"></span> 
			<span class="btn-sel"> <input type="button" value="취소" style="width:150px;" onclick="history.go(-1);"/></span>
		</div>

	</div>
	</form>
