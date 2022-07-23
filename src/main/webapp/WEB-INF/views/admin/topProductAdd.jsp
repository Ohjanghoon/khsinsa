<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/admin/topProductAdd.css" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<body>
	<div id="container">
		<div id="header1"></div>
		<div id="header2">ADMIN PAGE</div>
		<nav class="navi">
			<ul>
				<li><a href="<%= request.getContextPath() %>/admin/adminpage">회원 관리</a></li>
				<li><a href="<%= request.getContextPath() %>/admin/requestmanagement">요청 처리</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/productManagement">상품 관리</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/ordermanagement">주문 관리</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/StatisticsViewServlet">통계 관리</a></li>
			</ul>
		</nav>
		<form name="topProductAddFrm"
			action="<%=request.getContextPath()%>/admin/productManagement/topProductAdd" 
			method="post"
			encType = "multipart/form-data">
			<h2 style="font-size: 30px; color: black;">상품 등록</h2>
			<hr style="border-top: 3px solid black;">
			<div id="content" style="margin: 30px;">
				<span class="drop"> 
				<select name="one" id="drop-select" onchange="if(this.value) location.href=(this.value)">
						<option class="option" value="">상품 분류</option>
						<option class="option" value="<%=request.getContextPath()%>/admin/productManagement/topProductAdd"" selected/>상의</option>
						<option class="option" value="<%=request.getContextPath()%>/admin/productManagement/bottomProductAdd""/>하의</option>
				</select>
				</span> 
				<br> 
				<input type="text" name="name" id="name" placeholder="상품 이름 입력"> 	
				<br>
				<input type="text" name="price" id="price" placeholder="상품 가격 입력">
				<br>
				<input type="text" name="size" id="size" placeholder="상품 사이즈 입력(S / M / L)">
				<p>
					<textarea name="content" cols="100" rows="50"></textarea>
				</p>
				<div>
					<input type="file" name="imgproduct1" accept="image/*">
					<input type="file" name="imgproduct2" accept="image/*">
					<input type="file" name="imgproduct3" accept="image/*">
					<input type="file" name="imgproduct4" accept="image/*">
				</div>

		<div id="btn-sum" style="margin:30px;">
			<span class="btn-add"> <input type="submit" id="btn-add" value="작성" style="width:150px;"></span> 
			<span class="btn-sel"> <input type="button" value="취소" style="width:150px;"></span>
		</div>

	</div>
	</form>

	<script>
/**
* topProductAddFrmFrm 유효성 검사
*/
document.topProductAddFrm.onsubmit = (e) => {
	const frm = e.target;
	//상품 이름을 작성하지 않은 경우
	if(!/^.+$/.test(frm.name.value)){
		alert("상품 이름을 작성해주세요.");
		frm.name.focus();
		return false;
	}
	
	if(!/^.+$/.test(frm.price.value)){
		alert("상품 가격을 작성해주세요.");
		frm.price.focus();
		return false;
	}
	
	if(!/^.+$/.test(frm.size.value)){
		alert("상품 사이즈를 작성해주세요.");
		frm.size.focus();
		return false;
	}
	
	if(!/^.+$/.test(frm.content.value)){
		alert("상품 내용을 작성해주세요.");
		frm.content.focus();
		return false;
	}
	return true;
}


</script>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>