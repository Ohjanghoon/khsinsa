<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/admin/ProductAdd.css" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<body>
	<div id="container">
		<div id="header1"></div>
		<div id="header2">Admin Page</div>
		<nav>
			<ul class="navi">
				<li><a href="<%= request.getContextPath() %>/admin/adminpage">회원관리</a></li>
				<li><a href="<%= request.getContextPath() %>/admin/requestmanagement">요청처리</a></li>
				<li><a href="<%= request.getContextPath() %>/admin/productManagement">상품관리</a></li>
				<li><a href="<%= request.getContextPath() %>/admin/ordermanagement">주문관리</a></li>
				<li><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet">통계관리</a></li>
			</ul>
		</nav>
		<form name="productAddFrm"
			action="<%=request.getContextPath()%>/admin/productManagement/ProductAdd" 
			method="post"
			enctype="multipart/form-data">
			<h2 style="font-size: 30px; color: black;">상품 등록</h2>
			<hr style="border-top: 3px solid black;">
			<div id="content" style="margin: 30px;">
				<span class="dropdown">
			<!-- 	String type = request.getParameter("type");
			String name = request.getParameter("name");
			int price = Integer.parseInt(request.getParameter("price"));
			String size = request.getParameter("size");
			String content = request.getParameter("content");
			Product product = new Product(null, type, name, price, size, null, content); -->
				<select name="productType" class="dropdown-select">
						<option value="0" selected>상.하의 선택</option>
						<option value="P10">상의</option>
						<option value="P20">하의</option>
				</select>
				</span> 
				<br>
				<input type="text" name="name" id="name" placeholder="상품 이름 입력">
				<br>
				<input type="text" name="price" id="price" placeholder="상품 가격 입력(원)">
				<br>
				<input type="text" name="size" id="size" placeholder="상품 사이즈 입력(S / M / L)">
				<br>
				<input type="file" name="productimg1">
				<input type="file" name="productimg2">
				<input type="file" name="productimg3">
				<input type="file" name="productimg4">
				<p>
				<textarea name="content" cols="10" rows="10" placeholder="상품 상세 설명 입력"></textarea>
				</p>

		<div id="btn-sum" style="margin:30px;">
			<span class="btn-add"> <input type="submit" id="btn-add" value="작성" style="width:150px;"></span> 
			<span class="btn-sel"> <input type="button" value="취소" style="width:150px;"></span>
		</div>

	</div>
	</form>

	<script>
/**
* topProductAddFrm 유효성 검사
*/
document.topProductFrm.onsubmit = (e) => {
	const frm = e.target;
	//이름을 작성하지 않은 경우
	if(!/^.+$/.test(frm.name.value)){
		alert("상품 이름을 작성해주세요.");
		frm.name.focus();
		return false;
	}
	
	//가격을 작성하지 않은 경우 
	if(!/^(.|\n)+$/.test(frm.price.value)){
		alert("상품 가격을 작성해주세요.");
		frm.price.focus();	
		return false;
	}
	
	//사이즈를 작성하지 않은 경우 
	if(!/^.+$/.test(frm.size.value)){
		alert("상품 사이즈를 작성해주세요.");
		frm.size.focus();
		return false;
	}
	
	return true;
}


</script>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>