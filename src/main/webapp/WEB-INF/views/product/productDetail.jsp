<%@page import="com.kh.sinsa.review.model.dto.Review"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductExt"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/product/productDetail.css" />
<%
	Product product = (Product) request.getAttribute("product");
	List<ProductAttachment> attachList = (List<ProductAttachment>) request.getAttribute("attachList");
	int totalPage = (int) request.getAttribute("totalPage");
	String proNo = (String) request.getAttribute("proNo");
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
	for(ProductAttachment att : attachList) {
%>
				<img src="<%= request.getContextPath() %>/upload/product/<%= att.getProOriginalFilename() %>" alt="">
<% 
	break; } 
%>
            </div>
	            <div class="product-text">
	                <h4>Product Info</h4>
	                <h5>상품</h5>
	                <p><%= product.getProName() %></p>
	                <h5>❤️</h5>
	                <p>5개</p>
	                <h5>배송비</h5>
	                <p>무료</p>
	               	<h5>옵션</h5>
          	 <form action="<%= request.getContextPath() %>/product/order" name="productFrm" method="POST">
          	 	<input type="hidden" name="proNo" id="proNo" value="<%= product.getProNo() %>" />
	                <select class="form-select" aria-label="Default select example" id="size" name="size" required>
	                    <option selected disabled>사이즈를 선택해주세요.</option>
	                    <option value="L">L</option>
	                    <option value="M">M</option>
	                    <option value="S">S</option>
	                </select>
                   	<h5>수량</h5>
                    <button id="minus" type="button">-</button>
                    <input type="number" min=1 value=1 id="orderAmount" name="orderAmount" readonly>
                    <button id="plus" type="button">+</button>
                    <h5>상품 금액</h5>
                    <p><%= product.getProPrice() %>원</p>
                    <button>구매하기</button>
             </form>
             <input type="button" id="liveToastBtn" value="❤️"/>
             <form action="">
             	<button>🛒 장바구니에 담기</button>
             </form>
	         </div>
            <hr>            
<% 
	if(attachList != null && !attachList.isEmpty()){ 
		for(ProductAttachment pa : attachList){
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
             <button>👍 추천</button>
           	 <button>🚨 신고</button>
            <section>
            		<br />
                    <h3>리뷰</h3>
                    <div class="btn-more-container" id="photo-container">
 <% if(totalPage != 0) { %>
                    <button id="btn-more">리뷰 보기 ✒️</button>
                    <span id="cPage"></span>/<span id="totalPage"><%= totalPage %></span>
 <%
	 } else {
 %>
 					<br />
 					<input type="hidden" id="btn-more"/>
 					<h5>아직 리뷰가 없습니다. 고객님의 소중한 리뷰를 작성해주세요. </h5>
 					<br />
 <%
	 }
 %>
				    </div>
            </section>
            </div>
        </div>
</main>
<script>
	 /* 상품 좋아요.. */
	document.querySelector('#liveToastBtn').addEventListener('click', (e) => {
		
		$.ajax({
			url : '<%= request.getContextPath() %>/favorite/favoriteAdd',
			method : 'POST',
			data : {proNo : "<%= proNo %>", userId : "<%= loginUser.getUserId() %>"},
			success(response){
				alert("관심상품 등록되었씁니다.");
				
				<%-- const body = document.querySelector("body");
				
				 const html = `
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
				} --%>
			},
			error : console.log,
		})
	});

	
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
				}
			});
		};
		
		document.querySelector("#btn-more").addEventListener('click', (e) => {
			const cPage = Number(document.querySelector("#cPage").textContent) + 1;
			getPage(cPage);
		});	
	
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>