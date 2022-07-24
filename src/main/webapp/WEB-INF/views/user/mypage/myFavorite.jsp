<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="com.kh.sinsa.cart.model.dto.Cart"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/user/mypage/myPageHeader.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/user/mypage/myFavorite.css">
<%
	List<String> myFavList = (List<String>) request.getAttribute("myFavList");
	List<Product> _proInfoList = (List<Product>) request.getAttribute("proInfoList");
	List<ProductAttachment> _proAttachList = (List<ProductAttachment>) request.getAttribute("proAttachList");
	
	HashSet<Product> proInfoList = new HashSet<>(_proInfoList);
	HashSet<ProductAttachment> proAttachList = new HashSet<>(_proAttachList);
%>


<div class="myFavorite_content">
  	<div class="myFavorite_content_header">
  		<h2>관심상품</h2>
  	</div>
  	
    <div class="myFavorite_list">
    	<ul class="myFavorite_container">
	    <% if(myFavList != null && !myFavList.isEmpty()) {
			for(String fav : myFavList) { 
				for(Product pro : proInfoList){
					if(fav.equals(pro.getProNo())){
					for(ProductAttachment proAttach : proAttachList){
						if(fav.equals(proAttach.getProNo())){
						
			%>
			<li class="myFavorite_wrapper">
				<div class="proNo">
					<div class="proInfo">
			            <a href="<%= request.getContextPath() %>/product/productDetail?proNo=<%= pro.getProNo()%>">
			            	<img src="<%= request.getContextPath() %>/upload/product/<%= proAttach.getProOriginalFilename() %>">
		            	</a>
		            	<ul>
			        		<li><%= pro.getProNo() %> / <%= pro.getProType() %></li>
			        		<li>
				        		<a href="<%= request.getContextPath() %>/product/productDetail?proNo=<%= pro.getProNo()%>">
				        			<%= pro.getProName() %>
				        		</a>
			        		</li>
			        		<li><%= new DecimalFormat("###,###").format(pro.getProPrice()) %>원</li>
			        	</ul>
					</div>
				</div>
			
			</li>
	   	<%   			}
	   			 	}
	   			 	}
	   		 	}
			}
		   } else {%>
		   		<p>등록된 관심상품이 없습니다.</p>
		   
		<% } %>
		   </ul>
	           
	</div>
   	<div class="pagebar">
		<%= request.getAttribute("pagebar") %>
	</div>    
</div>	
	
	
	
<%@ include file="/WEB-INF/views/common/footer.jsp"%>