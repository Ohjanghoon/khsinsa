<%@page import="com.kh.sinsa.product.model.dto.ProductExt"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/productManagementDetail.css" />
<%
	Product product = (Product) request.getAttribute("product");
	List<ProductAttachment> productattachList = (List<ProductAttachment>) request.getAttribute("productattachList");
	System.out.println("productattachList = " + productattachList);
%>
<main>
    <div class="container">
        <section class="py-5 text-center container">
            <p>상품상세보기</p>
        </section>

        <div class="container-md">
            <h3><%= product.getProName() %></h3>
            <div class="product-img">
<% 
for(ProductAttachment att : productattachList) {
%>
				<img src="<%= request.getContextPath() %>/upload/product/<%= att.getProOriginalFilename() %>" alt="">
<% 
 break; } 
%>
            </div>
          	 <form action="<%= request.getContextPath() %>/product/order" name="productFrm" method="POST">
	            <div class="product-text">
          	 	<input type="hidden" name="proNo" id="proNo" value="<%= product.getProNo() %>" />
	                <h4>Product Info</h4>
	                <h5>상품</h5>
	                <p><%= product.getProName() %></p>
	                <h5>❤️</h5>
	                <p>5개</p>
	                <h5>배송비</h5>
	                <p>무료</p>
	               	<h5>옵션</h5>
	                <select class="form-select" aria-label="Default select example" id="size" name="size">
	                    <option selected>사이즈를 선택해주세요.</option>
	                    <option value="L">L</option>
	                    <option value="M">M</option>
	                    <option value="S">S</option>
	                </select>
                   	<h5>수량</h5>
                    <button>-</button>
                    <input type="text" value=1 id="orderAmount" name="orderAmount" disabled>
                    <button>+</button>
                    <h5>총 결제 금액</h5>
                    <p><%= product.getProPrice() %>원</p>
                    <button id="buy">구매하기</button>
                    <button>찜하기</button>
                    <button>장바구니 담기</button>
	            </div>
             </form>
            <hr>
<% 
	if(productattachList != null && !productattachList.isEmpty()){ 
		for(ProductAttachment pa : productattachList){
%>
            <div class="product-info">
                <img src="<%= request.getContextPath() %>/upload/product/<%= pa.getProOriginalFilename() %>" alt="">
<% 
		}
	}
%>
                <p>상품설명</p>
                <span><%= product.getProContent() %></span>
                <p>사이즈 기준표</p>
                <img src="<%= request.getContextPath() %>/images/sizecheck.png" alt="">
            </div>
            <hr>
            <section>
                <form action="">
                    <p>리뷰</p>
                    <div class="review">
                    <p>아이디</p>
                    <p>L</p>
                    <p>후기</p>
                    <img src="./img/tiger.jpg" alt="">
                    <button>👍 추천</button>
                    <button>🚨 신고</button>
                </form>
                <section class="py-5 text-center container">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <a class="page-link" href="#">이전</a>
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#">다음</a>
                            </li>
                        </ul>
                    </nav>
                </section>
            </section>
            </div>
        </div>
    </div>
</main>
<script>
	document.productFrm.onsubmit = (e) => {
		
	};
<%-- 	document.querySelector("#buy").addEventListener('submit', (e) => {
		productFrm.action = "<%= request.getContextPath() %>/product/order";
	}); --%>
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>