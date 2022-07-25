<%@page import="com.kh.sinsa.review.model.dto.Review"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductExt"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/product/productDetail.css" />
<%
	int totalFavorite = (int) request.getAttribute("totalFavorite");
	Product product = (Product) request.getAttribute("product");
	List<ProductAttachment> attachList = (List<ProductAttachment>) request.getAttribute("attachList");
	int totalPage = (int) request.getAttribute("totalPage");
	String proNo = (String) request.getAttribute("proNo");
%>
<main>
    <div class="container">
        <section class="py-5 text-center container">
            <h3>Product Detail</h3>
        </section>
        <hr />
  		<div class="valSave">
<% 
	for(ProductAttachment att : attachList) {
%>
		<figure class="figure">
		  <img src="<%= request.getContextPath() %>/upload/product/<%= att.getProRenameFilename() %>" class="figure-img img-fluid rounded" alt="..." width="400" height="500">
		  <figcaption class="figure-caption"><%= product.getProName() %></figcaption>
		</figure>
<% 
	break; } 
%>
			<table class="table caption-top">
			<thead></thead>
			  <tbody>
			    <tr>
			      <th scope="row">
			      	<h5>Product Name</h5>
			      </th>
			      <td>
			      	<p><%= product.getProName() %></p>
			      </td>
			    </tr>
			    <tr>
			      <th scope="row">
			      	<img src="<%= request.getContextPath() %>/images/colorHeart.png" alt="" width="25" height="25">
			      </th>
			      <td>
			      	<span id="like"><%= totalFavorite %></span>
			      </td>
			    </tr>
			    <tr>
			      <th scope="row">
			      	<h5>배송비</h5>
			      </th>
			      <td>
			      	<p>무료</p>
			      </td>
			      <tr>
			       <th scope="row">
			      	<h5>옵션</h5>
			       </th>
			       <td>
			      	<form action="<%= request.getContextPath() %>/product/order" name="productFrm" method="POST">
			       	 <input type="hidden" name="proNo" id="proNo" value="<%= product.getProNo() %>" />
			         <select class="form-select" aria-label="Default select example" id="size" name="size" required>
			           <option value="none" selected disabled>사이즈를 선택해주세요.</option>
			           <option value="L">L</option>
			           <option value="M">M</option>
			           <option value="S">S</option>
			         </select>
			       </td>
			      </tr>
			      <th scope="row">
			      	<h5>수량</h5>
			      </th>
			      <td>
			      	 <button id="minus" type="button" class="btn btn-outline-dark">-</button>
			         <input type="number" min=1 value=1 id="orderAmount" name="orderAmount" readonly>
			         <button id="plus" type="button" class="btn btn-outline-dark">+</button>
			      </td>
			      <tr>
			      <th scope="row">
			      	<h5>상품 금액</h5>
			      </th>
			      <td>
			      	 <p><%= product.getProPrice() %>원</p>
			      </td>
			     </tr>
			  </tbody>
			</table>
			       	<button id="buy" class="btn btn-outline-primary">Buy</button>
			       	<input type="button" id="cart" value="🛒" class="btn btn-outline-secondary"/>
			        <input type="button" id="liveToastBtn" value="❤️" class="btn btn-outline-danger"/>
      		</form>
       	</div>
       	<hr /><br /><br />
  		<div class="product-info">
  		 <p>Product More Images</p>          
<% 
	if(attachList != null && !attachList.isEmpty()){ 
		for(ProductAttachment pa : attachList){
%>
         <img src="<%= request.getContextPath() %>/upload/product/<%= pa.getProRenameFilename() %>" alt="">
<% 
		}
	}
%>
		 <br /><br />
         <p>Product Description<p>
         <h6><%= product.getProContent() %></h6>
         <p>Size Reference Table </p>
         <br />
         <img src="<%= request.getContextPath() %>/images/sizecheck.png" alt="">
         <br /><br />
        </div>
        <hr><br />
        <section class="py-5 text-center container">
	         <p id="review">Review</p>
	         <span id="cPage"></span><input type="hidden" id="totalPage" value="<%= totalPage %>" />
 <% if(totalPage != 0) { %>
	         <button class="btn btn-outline-secondary btn-sm" id="btn-more">More️..</button>
        </section>
        <div class="row row-cols-1 row-cols-md-3 g-4 reviewcon">
 <%
	 } else {
 %>
		 <br />
		 <input type="hidden" id="btn-more"/>
		 <h6>아직 리뷰가 없습니다. 고객님의 소중한 리뷰를 작성해주세요. </h6>
		 <br />
 <%
	 }
 %>
	    </div>
     </div>
        
</main>
<script>
	/* 옵션값 검사 */
	document.productFrm.addEventListener('submit', (e) => {
		if(document.querySelector('#size').value == 'none'){
			e.preventDefault();
			alert("사이즈를 선택해주세요.");
		} 
	});

	 /* 로그인 메시지 */
	const loginAlert = () => {
		alert("로그인후 이용할 수 있습니다.");
	};
<% if(loginUser != null) { %>

	 /*  장바구니 */
	document.querySelector('#cart').addEventListener('click', (e) => {
		const cartSize = document.querySelector('#size').value;
		const cartBuyStock = document.querySelector('#orderAmount').value;
		
		$.ajax({
			url : '<%= request.getContextPath() %>/cart/cartAdd',
			method : 'POST',
			data : {proNo : "<%= proNo %>", userId : "<%= loginUser.getUserId() %>", cartSize, cartBuyStock},
			success(response){
				alert("상품을 장바구니에 추가했습니다");
			},
			error : alert("사이즈를 선택해주세요.")
		})
	});

	 /* 상품 좋아요.. */
	document.querySelector('#liveToastBtn').addEventListener('click', (e) => {
		const pl = Number(document.querySelector('#like').textContent) + 1;
		$.ajax({
			url : '<%= request.getContextPath() %>/favorite/favoriteAdd',
			method : 'POST',
			data : {proNo : "<%= proNo %>", userId : "<%= loginUser.getUserId() %>"},
			success(response){
				alert("관심상품 등록되었습니다.");
				
				 <%-- const body = document.querySelector("body"); -%>
				
				 <%-- const html = `
					<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
					  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
					    <div class="toast-header">
					      <img src='<%= request.getContextPath() %>/images/realheart.png' class="rounded me-2" alt="...">
					      <strong class="me-auto">주신사</strong>
					      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
					    </div>
					    <div class="toast-body">
					      관심 상품에 등록되었습니다. 🥰
					    </div>
					  </div>
					</div>
				`;
				
				body.insertAdjacentHTML('beforeend', html);
				
				var toastTrigger = document.getElementById('liveToastBtn')
				var toastLiveExample = document.getElementById('liveToast')
				if (toastTrigger) {
				  toastTrigger.addEventListener('click', function () {
				    var toast = new bootstrap.Toast(toastLiveExample)
				
				    toast.show()
				  })
				}  --%>
			},
			error : console.log,
			complete(){
				document.querySelector('#like').innerHTML = pl;
			}
		})
	});
<% } %>
	
	/* 벨류값 증가 */
	document.querySelector('#plus').addEventListener('click', (e) => {
		document.querySelector('#orderAmount').value++;
	});
	document.querySelector('#minus').addEventListener('click', (e) => {
		if(document.querySelector('#orderAmount').value < 2){
			document.querySelector('#minus') = disabled;
		} else{
			document.querySelector('#orderAmount').value--;
		}
	});
	
	
	 /* 리뷰 비동기 처리 */
	const getPage = (cPage,proNo) => {
			$.ajax({
				url : '<%= request.getContextPath() %>/review/reviewList',
				data : {cPage, proNo: "<%= proNo %>"},
				success(response){
					console.log(response);
					const reviewcon = document.querySelector(".reviewcon");
					
					response.forEach((review) => {
						const {reviewNo, proNo, orderNo, reviewWriter, reviewContent, reviewOriginalFilename, reviewRenamedFilename, reviewDate, reviewRecommend} = review;
						
						const html = `
						<div class="col">
			              <div class="card h-100">
			                <img src="<%= request.getContextPath() %>/upload/review/\${reviewRenamedFilename}" class="card-img-top" alt="...">
			                <div class="card-body">
			                  <h5 class="card-title">\${reviewWriter}</h5>
			                  <p class="card-text">\${reviewContent}</p>
			                </div>
			                <div class="card-footer">
			                  <small class="text-muted">\${reviewDate}</small>
			                </div>
			              </div>
			            </div>
			         	`;
						reviewcon.insertAdjacentHTML('beforeend', html);
						
					});
				},
				error : console.log,
				complete(){
					document.querySelector('#cPage').innerHTML = cPage;
					
					// 마지막페이지 처리
					if(cPage == <%= totalPage %>){
						document.querySelector("#btn-more").disabled = true;
					}
				}
			});
		};
		
	document.querySelector("#btn-more").addEventListener('click', (e) => {
		const cPage = Number(document.querySelector("#cPage").textContent)+1;
		getPage(cPage);
	});	
		
	
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>