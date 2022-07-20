<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductExt"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/adminpage/productManagement.css">
<%
	List<Product> productlist = (List<Product>) request.getAttribute("productlist");
	List<ProductAttachment> productattachList = (List<ProductAttachment>) request.getAttribute("productattachList");
	System.out.println(productattachList);
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
                <button type="button" class="btn btn-secondary float-right">상품 등록</button></div>
            <table class="table table-bordered" style="margin-left: auto; margin-right: auto; text-align: center;">
<% 
	if(productlist != null && !productlist.isEmpty()){ 
		for(Product product : productlist){
%>
                <thead>
                    <tr>
                        <th style = "width: 8%">NO</th>
                        <th style = "width: 8%">분류</th>
                        <th style = "width: 10%">이름</th>
                        <th style = "width: 10%" colspan = "2">사진</th>
                        <th style = "width: 24%">내용</th>
                        <th style = "width: 10%">가격</th>
                        <th style = "width: 10%">사이즈</th>
                        <th style = "width: 10%">등록일</th>
                        <th style = "width: 10%">수정/삭제</th>
                    </tr>
                </thead>
                    <tbody>
                        <td><%= product.getProNo() %></td>
                        <td><%= product.getProType() %></td>
                        <td><%= product.getProName() %></td>
<%
	for(ProductAttachment pa : productattachList){
		if(product.getProNo().equals(pa.getProNo())){
%>
						<td>
							<a href="<%= request.getContextPath() %>/admin/productManagementDetail?proNo=<%= product.getProNo() %>">
							<div class = 'img-container'>
								<img src="<%= request.getContextPath() %>/upload/product/<%= pa.getProOriginalFilename() %>" width = "100px" height = "100px" colspan = "2" alt="" class="img-product">
							</div>
						<td>
<%
		break; }		
	}
%>
                        <td><%= product.getProContent() %></td>
                        <td><%= product.getProPrice() %></td>
                        <td><%= product.getProSize() %></td>
                        <td><%= product.getRegDate() %></td>
                        <td>
                            <button type="button" class="btn_edit">수정</button>
                            <button type="button" class="btn_delete">삭제</button>
                        </td>
                        <% 		}
       		} %>
                    </tbody>
            </table>
            <p class="pagination justify-content-center"><%= request.getAttribute("pagebar") %></p>
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>