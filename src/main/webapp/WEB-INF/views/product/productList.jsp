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
            <p>TOP</p><p>(상의)</p>
        </section>
        <div class="album py-5 bg-light">
                <div class="container">
                    <nav class="navbar navbar-light bg-light">
                        <div class="container">
                          <form class="d-flex" name="searchFrm" action="<%= request.getContextPath() %>/product/productFind" method="get">
                            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="search">
                            <button class="btn btn-outline-success" type="submit">🔎</button>
                          </form>

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
                        </div>
                      </nav>
                      
                 <div class="row row-cols-1 row-cols-sm-5 row-cols-md-3 g-3" id="productList">
<% 
	if(list != null && !list.isEmpty()){ 
		for(Product product : list){
%>
					<div class="col">
                    <div class="card shadow-sm">
                        <a id="moveToOreder" href="<%= request.getContextPath() %>/product/productDetail?proNo=<%= product.getProNo() %>">
<%
	for(ProductAttachment pa : attachList){
		if(product.getProNo().equals(pa.getProNo())){
%>
                        <img src="<%= request.getContextPath() %>/upload/product/<%= pa.getProOriginalFilename() %>" alt="" class="img-product">
<%
		break; }		
	}
%>
                        </a>
                        <div class="card-body">
                        <p class="card-text"><%= product.getProName() %></p>
                        <p class="card-text"><%= product.getProPrice() %>원</p>
                        <div class="d-flex justify-content-between align-items-center">                            
                            <small class="text-muted">❤️ 1</small>
                        </div>
                        </div>
                    </div>
                    </div>
<%
		}
	}
%>
			</div>
		</div>
        </div>
			<p class="pagination justify-content-center"><%= request.getAttribute("pagebar") %></p>
    </div>
</main>
<script>
	
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>