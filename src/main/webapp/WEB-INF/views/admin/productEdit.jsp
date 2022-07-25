<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="com.kh.sinsa.admin.model.dto.ProductManagementExt"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin/productEdit.css" />
<%
	Product product = (Product) request.getAttribute("product");
	List<ProductAttachment> productattachmentList = (List<ProductAttachment>) request.getAttribute("productattachmentList");
	String proNo = (String) request.getAttribute("proNo");
	//System.out.println(productattachmentList);
%>

<!-- // board -> product / attachments -> productattachList -->

<body>
	<div id="container">
		<div id="header1"></div>
		<div id="header2">Admin Page</div>
		<nav>
			<ul class="navi">
				<li><a href="<%= request.getContextPath() %>/admin/adminpage">회원 관리</a></li>
				<li><a href="<%= request.getContextPath() %>/admin/requestManagement">요청 처리</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/productManagement">상품 관리</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/orderManagement">주문 관리</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet">통계 관리</a></li>
			</ul>
		</nav>
<main>
<form action="<%= request.getContextPath() %>/admin/productManagement/productEdit" name="productUpdateFrm" method="post" enctype="multipart/form-data">
	<div class="container">
       <section class="py-5 text-center container">
           <h3>상품 수정</h3>
       </section>
       <div class="mb-3">
           <label for="exampleFormControlInput1" class="form-label">상품 이름</label>
           <input type="text" class="form-control" name="proName" id="exampleFormControlInput1" value="<%= product.getProName() %>">
       </div>
       <div class="mb-3">
           <label for="exampleFormControlInput1" class="form-label">상품 가격</label>
           <input type="text" class="form-control" name="proPrice" id="exampleFormControlInput1" value="<%= product.getProPrice() %>">
       </div>
       <div class="mb-3">
           <label for="exampleFormControlInput1" class="form-label">상품 사이즈</label>
           <input type="text" class="form-control" name="proSize" id="exampleFormControlInput1" value="<%= product.getProSize() %>">
       </div>
       <div class="mb-3">
           <label for="exampleFormControlTextarea1" class="form-label">상품 내용</label>
           <textarea class="form-control" name="proContent" id="exampleFormControlTextarea1" rows="10"><%= product.getProContent() %></textarea>
       </div>
       <div class="mb-3">
       		<label for="exampleFormControlInput1" class="form-label">상품 사진</label>
       		<br />
<% 
	for(ProductAttachment pa : productattachmentList){
		if(product.getProNo().equals(pa.getProNo())){ 
%>
           	<input type="checkbox" name="delFile" value="<%= pa.getProAttachmentNo() %>" checked>
       		<img src="<%= request.getContextPath() %>/upload/product/<%= pa.getProRenameFilename() %>" alt="" width="240" height="320"/>
       	
<%
		}
	}
%>
			<br />
           	<p>* 선택된 파일은 삭제 됩니다.</p>
       </div>
       <div class="mb-3">
           <label for="formFile" class="form-label">Select The File</label>
           <input class="form-control" name="imgproduct" type="file" id="formFile">
       </div>
       <div class="text-center">
           <button type="button" class="btn btn-outline-danger btn-sm" onclick="history.go(-1);">취소</button>
           <button type="submit" class="btn btn-outline-primary btn-sm">수정</button>
       </div>
   </div>
</form>
</main>	
<script>
	document.productUpdateFrm.onsubmit = (e) => {
		const frm = e.target;
		//상품 이름을 작성하지 않은 경우 폼제출할 수 없음.
		const nameVal = frm.proName.value.trim(); // 좌우공백
		if(!/^(.|\n)+$/.test(nameVal)){
			alert("상품 이름을 작성해주세요.");
			frm.proName.select();
			return false;
		}
		
		//상품 가격을 작성하지 않은 경우 폼제출할 수 없음.
		const priceVal = frm.proPrice.value.trim(); // 좌우공백
		if(!/^(.|\n)+$/.test(priceVal)){
			alert("상품 가격을 작성해주세요.");
			frm.proPrice.select();
			return false;
		}
		
		//상품 사이즈을 작성하지 않은 경우 폼제출할 수 없음.
		const sizeVal = frm.proSize.value.trim(); // 좌우공백
		if(!/^(.|\n)+$/.test(sizeVal)){
			alert("상품 사이즈를 작성해주세요.");
			frm.proSize.select();
			return false;
		}
		
		//상품 내용을 작성하지 않은 경우 폼제출할 수 없음.
		const contentVal = frm.proContent.value.trim(); // 좌우공백
		if(!/^(.|\n)+$/.test(contentVal)){
			alert("상품 내용을 작성해주세요.");
			frm.proContent.select();
			return false;
		}
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>