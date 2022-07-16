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
%>

<main>
    <div class="container-fluid">
        <section class="py-5 text-center container">
            <p>TOP</p><p>(상의)</p>
        </section>
        <div class="album py-5 bg-light">
                <div class="container">
                    <nav class="navbar navbar-light bg-light">
                        <div class="container-fluid">
                          <form class="d-flex">
                            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                            <button class="btn btn-outline-success" type="submit">Search</button>
                          </form>

                          <div class="dropdown">
                            <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                              Dropdown link
                            </a>
                          
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                              <li><a class="dropdown-item" href="#">Action</a></li>
                              <li><a class="dropdown-item" href="#">Another action</a></li>
                              <li><a class="dropdown-item" href="#">Something else here</a></li>
                            </ul>
                          </div>
                        </div>
                      </nav>
                      
                 <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
<% 
	if(list != null && !list.isEmpty()){ 
		for(Product product : list){
%>
					<div class="col">
                    <div class="card shadow-sm">
                        <img src="./img/bgsample.PNG" alt="" class="img-product">
        
                        <div class="card-body">
                        <p class="card-text"><%= product.getProName() %></p>
                        <p class="card-text"><%= product.getProPrice() %></p>
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
	document.querySelector(".card").addEventListener('click', (e) =>{
		location.href="<%= request.getContextPath() %>/product/productDetail";
	});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>