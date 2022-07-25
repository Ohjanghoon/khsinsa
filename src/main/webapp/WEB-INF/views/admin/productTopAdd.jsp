<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="com.kh.sinsa.admin.model.dto.ProductManagementExt"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin/productEdit.css" />
<main>
<form action="<%= request.getContextPath() %>/admin/productManagement/productTopAdd" name="productAddFrm" method="post" enctype="multipart/form-data">
	<div class="container">
       <section class="py-5 text-center container">
           <h3>상의 상품 등록</h3>
       </section>
       <div class="mb-3">
           <label for="exampleFormControlInput1" class="form-label">상품 이름</label>
           <input type="text" class="form-control" name="proName" id="exampleFormControlInput1" value="">
       </div>
       <div class="mb-3">
	       <label for="exampleFormControlInput1" size="2" class="form-label">상품 타입</label>
	       <select class="form-select" name="proType" size="2" aria-label="size 2 select example">
			  <option value="상의" selected>상의</option>
			  <option value="하의">하의</option>
			</select>
		</div>
       <div class="mb-3">
           <label for="exampleFormControlInput1" class="form-label">상품 가격</label>
           <input type="number" class="form-control" name="proPrice" id="exampleFormControlInput1" value="">
       </div>
        <div class="mb-3">
	       <label for="exampleFormControlInput1" size="2" class="form-label">상품 타입</label>
	       <select class="form-select" name="proSize" size="5" aria-label="size 5 select example">
			  <option value="XL">XL</option>
			  <option value="L">L</option>
			  <option value="M" selected>M</option>
			  <option value="S">S</option>
			  <option value="XS">XS</option>
			</select>
		</div>
       <div class="mb-3">
           <label for="formFile" class="form-label">Select The File</label>
           <small>* 마지막 등록 사진이 대표사진으로 등록됩니다. *</small>
           	<input class="form-control" name="upFile1" type="file" id="formFile">
           	<input class="form-control" name="upFile2" type="file" id="formFile">
           	<input class="form-control" name="upFile3" type="file" id="formFile">
           	<input class="form-control" name="upFile4" type="file" id="formFile">
           	<input class="form-control" name="upFile5" type="file" id="formFile">
       </div>
       <div class="mb-3">
           <label for="exampleFormControlTextarea1" class="form-label">상품 내용</label>
           <textarea class="form-control" name="proContent" id="exampleFormControlTextarea1" rows="10"></textarea>
       </div>
       <div class="text-center">
           <button type="button" class="btn btn-outline-danger btn-sm" onclick="history.go(-1);">취소</button>
           <button type="submit" class="btn btn-outline-primary btn-sm">등록</button>
       </div>
   </div>
</form>
</main>	
<script>
	document.productAddFrm.onsubmit = (e) => {
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