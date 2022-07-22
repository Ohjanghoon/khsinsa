<%@page import="com.kh.sinsa.product.controller.ProductTopFindServlet"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductExt"%>
<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/product/productList.css" />
<%
	List<Product> list = (List<Product>) request.getAttribute("list");
	List<ProductAttachment> attachList = (List<ProductAttachment>) request.getAttribute("attachList");
%>
<main>
    <div class="container">
        <section class="py-5 text-center container">
            <h3>BOTTOM</h3>
        </section>
		<hr />
    	<div class="align">
       	 <form action="<%= request.getContextPath() %>/product/productAlign" method="get">
             <select class="form-select" aria-label="Default select example" name="align" onchange="this.form.submit()">
			  <option value="#" selected>정렬기준</option>
			  <option value="pro_name">상품명</option>
			  <option value="pro_price">가격순</option>
			  <option value="#">좋아요순</option>
			 </select>
         </form>
       	</div>
		<div class="search">
			<form class="d-flex" name="searchFrm" action="<%= request.getContextPath() %>/product/productFind" method="get">
	          <input type="text" class="form-control me-2" placeholder="Search..." aria-label="Search">
	          <button type="button" class="btn btn-outline-dark">🔎</button>
	        </form>
		</div>
       	<div class="row row-cols-3 row-cols-lg-3 align-items-stretch g-5 py-5">			    
<% 
	if(list != null && !list.isEmpty()){ 
		for(Product product : list){
%>	
<%
	for(ProductAttachment pa : attachList){
		if(product.getProNo().equals(pa.getProNo())){
%>
			<div class="col">
		        <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('<%= request.getContextPath() %>/upload/product/<%= pa.getProRenameFilename() %>');">
		          <div class="d-flex flex-column h-100 p-5 pb-3 text-black text-shadow-2">
		          <a href="<%= request.getContextPath() %>/product/productDetail?proNo=<%= product.getProNo() %>" id="moveToPage">
		            <h6 class="pt-5 mt-5 mb-5 display-8 lh-10"><%= product.getProName() %></h6>
		          </a>
		            <ul class="d-flex list-unstyled mt-auto">
		              <li class="me-auto">
		                <small>💲&nbsp;<%= product.getProPrice() %></small>
		              </li>
		              <li class="d-flex align-items-center me-3">
		              	<small><%= product.getProType() %></small>
		              </li>
		              <li class="d-flex align-items-center">
		                <img src="<%= request.getContextPath() %>/images/colorHeart.png" alt="" height="32" width="32" />
		                <small>&nbsp;</small>
		              </li>
		            </ul>
		          </div>
		        </div>
		     </div>
<%
			break; }		
			}
		}
	}
%>
		</div>
	</div>
		<p class="pagination justify-content-center"><%= request.getAttribute("pagebar") %></p>
</main>
<script>
	
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>