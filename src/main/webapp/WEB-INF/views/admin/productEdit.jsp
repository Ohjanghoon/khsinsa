<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="com.kh.sinsa.admin.model.dto.ProductManagementExt"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Product product = (Product) request.getAttribute("product");
	List<ProductAttachment> productattachmentList = (List<ProductAttachment>) request.getAttribute("productattachmentList");
	String proNo = (String) request.getAttribute("proNo");
	System.out.println(productattachmentList);
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
<h2>상품등록</h2>
<form 
	name="productEditFrm" 
	action="<%=request.getContextPath() %>/admin/productManagement/productEdit"
	enctype="multipart/form-data" 
	method="post">
	<table>
	<tr>
		<th>상품 이름</th>
		<td><input type="text" name="proName" value="<%= product.getProName().replace("\"", " &quot;") %>" required></td>
	</tr>
	<tr>
		<th>상품 가격</th>
		<td>
			<input type="text" name="proPrice" value="<%= product.getProPrice() %>" required/>
		</td>
	</tr>
	<tr>
		<th>상품 사이즈</th>
		<td>
			<input type="text" name="proSize" value="<%= product.getProPrice() %>" required/>
		</td>
	</tr>
	<tr>
		<th>상품 내용</th>
		<td>
			<textarea rows="5" cols="40" name="content"><%= product.getProContent() %></textarea>
		</td>
	</tr>
	<tr>
		<th>상품 사진</th>
		<td>
		<% 
			if(productattachmentList != null && !productattachmentList.isEmpty()){
				for(int i = 0; i < productattachmentList.size(); i++){
					ProductAttachment productattach = productattachmentList.get(i);
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
			<input type="file" name="imgproduct1">
			<input type="file" name="imgproduct2">
			<input type="file" name="imgproduct3">
			<input type="file" name="imgproduct4">
			<input type="file" name="imgproduct5">
			<input type="file" name="imgproduct6">
		</td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="수정하기"/>
			<input type="button" value="취소" onclick="history.go(-1);"/>
		</th>
	</tr>
</table>
</form>
</section>
<script>
document.productEditFrm.onsubmit = (e) => {
	const frm = e.target;
	//상품 이름을 작성하지 않은 경우 폼제출할 수 없음.
	const proNameVal = frm.proName.value.trim(); // 좌우공백
	if(!/^.+$/.test(proNameVal)){
		alert("상품 이름을 작성해주세요.");
		frm.proName.select();
		return false;
	}		
					   
	//상품 가격을 작성하지 않은 경우 폼제출할 수 없음.
	const proPriceVal = frm.proPrice.value.trim();
	if(!/^(.|\n)+$/.test(proPriceVal)){
		alert("상품 가격을 작성해주세요.");
		frm.proPrice.select();
		return false;
	}
	
	//상품 사이즈를 작성하지 않은 경우 폼제출할 수 없음.
	const proSizeVal = frm.proSize.value.trim();
	if(!/^(.|\n)+$/.test(proSizeVal)){
		alert("상품 사이즈를 작성해주세요.");
		frm.proSize.select();
		return false;
	}
	
	//상품 내용을 작성하지 않은 경우 폼제출할 수 없음.
	const proContentVal = frm.proContent.value.trim();
	if(!/^(.|\n)+$/.test(proContentVal)){
		alert("상품 내용을 작성해주세요.");
		frm.proContent.select();
		return false;
	}
	
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>