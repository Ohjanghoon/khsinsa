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
	List<ProductAttachment> attachList = (List<ProductAttachment>) request.getAttribute("attachList");
	int totalPage = (int) request.getAttribute("totalPage");
	String proNo = (String) request.getAttribute("proNo");
%>
<div align="center" id="body">
            <br>
            <class = "adminpage"><h1>Admin page</h1></class>
            <ul class = "ul">
                <adminmenu>
                <li><a href="<%= request.getContextPath() %>/admin/adminpage">회원 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/requestmanagement">요청 처리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/productmanagement">상품 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/ordermanagement">주문 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet">통계 관리</a></li>
            </adminmenu>
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
			      	0
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
			           <option selected disabled>사이즈를 선택해주세요.</option>
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
			      	 <button id="minus" type="button">-</button>
			         <input type="number" min=1 value=1 id="orderAmount" name="orderAmount" readonly>
			         <button id="plus" type="button">+</button>
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
			       	<button id="buy">Buy</button>
			       	<input type="button" id="cart" value="🛒"/>
			        <input type="button" id="liveToastBtn" value="❤️"/>
      		</form>
       	</div>
       	<hr /><br /><br />
  		<div class="product-info">
  		 <p>Product More Images</p>          
<% 
	if(attachList != null && !attachList.isEmpty()){ 
		for(ProductAttachment pa : attachList){
%>
         <img src="<%= request.getContextPath() %>/upload/product/<%= pa.getProOriginalFilename() %>" alt="">
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
         
        <div class="btn-more-container" id="photo-container">
        <p id="review">Review</p>
 <% if(totalPage != 0) { %>
         <button id="btn-more">Review️</button>
         <span id="cPage"></span>/<span id="totalPage"><%= totalPage %></span>
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
			error : console.log,
		})
	});
	
	 /* 상품 좋아요.. */
	document.querySelector('#liveToastBtn').addEventListener('click', (e) => {
		
		$.ajax({
			url : '<%= request.getContextPath() %>/favorite/favoriteAdd',
			method : 'POST',
			data : {proNo : "<%= proNo %>", userId : "<%= loginUser.getUserId() %>"},
			success(response){
				alert("관심상품 등록되었씁니다.");
				
				 const body = document.querySelector("body");
				
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
		})
	});
<% } %>
	
	/* 벨류값 증가 */
	document.querySelector('#plus').addEventListener('click', (e) => {
		document.querySelector('#orderAmount').value++;
	});
	document.querySelector('#minus').addEventListener('click', (e) => {
		document.querySelector('#orderAmount').value--;
	});
	
	
	 /* 리뷰 비동기 처리 */
	const getPage = (cPage,proNo) => {
			$.ajax({
				url : '<%= request.getContextPath() %>/review/reviewList',
				data : {cPage, proNo: "<%= proNo %>"},
				success(response){
					console.log(response);
					const container = document.querySelector("#photo-container");
					
					response.forEach((review) => {
						const {reviewNo, proNo, orderNo, reviewWriter, reviewContent, reviewOriginalFilename, reviewRenamedFilename, reviewDate, reviewRecommend} = review;
						
						const html = `
						<div class="polaroid">
							<img src="<%= request.getContextPath() %>/upload/review/\${reviewOriginalFilename}" alt="" />
							<p class="info">
								<span class="writer">\${reviewWriter}</span>
								<span class="photoDate">\${reviewDate}</span>
							</p>
							<p class="caption">\${reviewContent}</p>
							<input type="button" id="reviewRecommend" value="👍"/>
							<input type="button" id="reprot" value="🚨"/>
							<br /><br />
						</div>
						`;
						container.insertAdjacentHTML('beforeend', html);
						
					});
				},
				error : console.log,
				complete(){
					document.querySelector('#cPage').innerHTML = cPage;
					
					// 마지막페이지 처리
					if(cPage == <%= totalPage %>){
						document.querySelector("#btn-more").disabled = true;
					}
					
					// 리뷰 추천
					document.querySelector("#reviewRecommend").addEventListener('click', (e) => {
						$.ajax({
							url : '<%= request.getContextPath() %>/review/reviewRecommendUp',
							method : 'POST',
							data : {${reviewNo}},
							success(response){
								alert("해당 리뷰를 추천하였습니다.");
							},
							error : console.log
						})
					});
					
					
					
				}
			});
		};
		
		document.querySelector("#btn-more").addEventListener('click', (e) => {
			const cPage = Number(document.querySelector("#cPage").textContent) + 1;
			getPage(cPage);
		});	
		
	
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>