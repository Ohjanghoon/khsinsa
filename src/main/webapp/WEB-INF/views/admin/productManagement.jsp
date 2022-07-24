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
<link 
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
<link
	rel="stylesheet"
	href="<%= request.getContextPath() %>/css/admin/productManagement.css">
<%
	List<Product> productlist = (List<Product>) request.getAttribute("productlist");
	List<ProductAttachment> productattachList = (List<ProductAttachment>) request.getAttribute("productattachList");
	//System.out.println(productlist);
	//System.out.println(productattachList);
	//System.out.println(productlist);
%>

<div align="center" id="body">
            <br>
            <class = "adminpage"><h1>ADMIN PAGE</h1></class>
            <ul class = "ul">
                <adminmenu>
                <li><a href="<%= request.getContextPath() %>/admin/adminpage">회원 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/requestmanagement">요청 처리</a></li>
                <li class = :"li"><a>상품 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/ordermanagement">주문 관리</a></li>
                <li class = :"li"><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet">통계 관리</a></li>
            </adminmenu>
            </ul>
            <br>
            <a><center>상품 관리</center></a>
            <br>
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button id="productadd" type="submit">상품 등록</button></div>
            <table class="table table-bordered">
<%
			if(productlist == null || productlist.isEmpty()){
		%>
			<tr>
				<td colspan="10" align="center"> 검색 결과가 없습니다. </td>
			</tr>
		<%
			} 
			else { for(Product product : productlist){
%>
                <thead>
                    <tr class = tablehead>
                        <th>NO</th>
                        <th>분류</th>
                        <th>이름</th>
                        <th>사진</th>
                        <th>가격</th>
                        <th>내용</th>
                        <th>사이즈</th>
                        <th>등록일</th>
                        <th>수정/삭제</th>
                    </tr>
                </thead>
                    <tbody>
                        <td><%= product.getProNo() %></td>
                        <td><%= product.getProType() %></td>
                        <td>
                        	<a href="<%= request.getContextPath() %>/admin/productManagementDetail?proNo=<%= product.getProNo() %>">
                        	<%= product.getProName() %>
                        </td>
<%
	for(ProductAttachment pa : productattachList){
		if(product.getProNo().equals(pa.getProNo())){
%>
						<td>
							<div class = 'img-container'>
								<img src="<%= request.getContextPath() %>/upload/product/<%= pa.getProRenameFilename() %>" width = "100px" height = "100px" colspan = "2" alt="" class="img-product">
							</div>
						</td>
<%
		break; }		
	}
%>
						<td><%= product.getProPrice() %></td>
						<td><%= product.getProContent() %></td>
                        <td><%= product.getProSize() %></td>
                        <td><%= product.getRegDate() %></td>
                        <td><button type="button" value="<%= product.getProNo() %>" class="btn btn-sm btn-outline-secondary editProduct">Edit</button>
                            <button type="button" value="<%= product.getProNo() %>" class="btn btn-sm btn-outline-secondary delProduct">Delete</button>
                        </td>
                        <% 		}
       		} %>
                    </tbody>
            </table>
<form action="<%= request.getContextPath() %>/admin/productManagement/productEdit" name="editProductFrm" method="get">
	<input type="hidden" name="proNo" />
</form>
<script>
/* 상품 등록 */
document.querySelector("#productadd").addEventListener('click', (e) => {
	if(<%= loginUser == null %>){
		loginAlert();		
	}else{
		location.href = "<%= request.getContextPath() %>/admin/productManagement/topProductAdd";
	}	
});

/* 상품 수정 */
document.querySelectorAll(".editProduct").forEach((btn) => {
	btn.addEventListener('click', (e) => {
			const {value} = e.target;
			const frm = document.editProductFrm;
			frm.proNo.value = value;
			frm.submit();
	});
});

</script>
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>