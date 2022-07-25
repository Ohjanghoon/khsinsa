<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductExt"%>
<%@page import="com.kh.sinsa.admin.model.dto.ProductManagementExt"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.kh.sinsa.common.KhsinsaUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/productManagement.css">
<%
	List<Product> productlist = (List<Product>) request.getAttribute("productlist");
	List<ProductAttachment> productattachList = (List<ProductAttachment>) request.getAttribute("productattachList");
%>
<main>
        <div class="container">
            <section class="py-5 text-center container">
                <h3>Admin Page</h3>
            </section>
            <nav class="py-2 bg-white border-top border-bottom" id="commnavi">
                <ul class="nav me-auto">
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/adminpage" class="nav-link link-dark px-2">회원관리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/requestManagement" class="nav-link link-dark px-2">요청처리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/productManagement" class="nav-link link-dark px-2">상품관리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/orderManagement" class="nav-link link-dark px-2">주문관리</a></li>
                  <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet" class="nav-link link-dark px-2">통계관리</a></li>
                </ul>
            </nav>
            <br><br><br><br>
            <section class="py-2 text-center container">
                <h3>상품관리</h3>
            </section>
            <div class="container px-4 py-5" id="featured-3">
                <button type="button" id="addTopProduct" class="btn btn-outline-secondary btn-sm">상의 상품 등록</button><br /><br />
                <button type="button" id="addBottomProduct" class="btn btn-outline-secondary btn-sm">하의 상품 등록</button><br /><br />
                <h2 class="pb-2 border-bottom">등록된 상품</h2>
                <div class="row g-4 py-5 row-cols-1 row-cols-lg-3">
<%
    if(productlist != null || !productlist.isEmpty()){
        for(Product product : productlist){
        	String top = product.getProType();
%>                   
                  <div class="feature col">
                      <a href="<%= request.getContextPath() %>/product/productDetail?proNo=<%= product.getProNo() %>" class="icon-link">
<%
        for(ProductAttachment pa : productattachList){
            if(product.getProNo().equals(pa.getProNo())){
%>                          
                        <img src="<%= request.getContextPath() %>/upload/product/<%= pa.getProRenameFilename() %>" alt="" width="100%" height="340px">
<%
            break; }		
            }
%>
                      </a>
                    <p><%= product.getProName() %></p>
                      <small>제품 번호 : <%= product.getProNo() %></small><br />
                      <small>제품 설명 : <%= product.getProContent() %></small><br />
                      <small>등록일 : <%= product.getRegDate() %></small><br /><br />
                      <button type="button" value="<%= product.getProNo() %>" class="btn btn-sm btn-outline-secondary editProduct">Edit</button>
                      <button type="button" value="<%= product.getProNo() %>" class="btn btn-sm btn-outline-secondary delProduct">Delete</button>
                  </div>
<% 		
        }
    } 
%>
                  
                </div>
              </div>
		</div>
		<p class="pagination justify-content-center"><%= request.getAttribute("pagebar") %></p>
<form action="<%= request.getContextPath() %>/admin/productManagement/productEdit" name="editProFrm" method="get">
    <input type="hidden" name="proNo" />
</form>
<form action="<%= request.getContextPath() %>/admin/productManagement/productTopAdd" name="addTopProFrm" method="get"></form>
<form action="<%= request.getContextPath() %>/admin/productManagement/productBottomAdd" name="addBottomProFrm" method="get"></form>
<form action="<%= request.getContextPath() %>/admin/productManagement/productDelete" name="delProFrm" method="post">
	<input type="hidden" name="proNo" />
</form>
</main>
<script>
    /* 게시글 등록 하의 */
	document.querySelector("#addTopProduct").addEventListener('click', (e) => {
				const frm = document.addTopProFrm
				frm.submit();
	});

	/* 게시글 등록 상의 */
	document.querySelector("#addBottomProduct").addEventListener('click', (e) => {
				const frm = document.addBottomProFrm;
				frm.submit();
	});
	
	/* 게시글 수정 */
	document.querySelectorAll(".delProduct").forEach((btn) => {
		btn.addEventListener('click', (e) => {
			if(confirm("해당 게시물을 정말 삭제하시겠습니까?")){
				const {value} = e.target;
				const frm = document.delProFrm;
				frm.proNo.value = value;
				frm.submit();
			}	
		});
	});

	/* 게시글 삭제 */
	document.querySelectorAll(".editProduct").forEach((btn) => {
		btn.addEventListener('click', (e) => {
				const {value} = e.target;
				const frm = document.editProFrm;
				frm.proNo.value = value;
				frm.submit();
		});
	});
</script>
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>