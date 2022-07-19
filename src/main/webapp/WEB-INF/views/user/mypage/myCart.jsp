<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/user/mypage/myPageHeader.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/user/mypage/myCart.css">



<section class="cart">
	<h2>장바구니</h2>

	<form action="">
		<table class="cart_list">
			<thead>
				<tr>
					<td><input type="checkbox"></td>
					<td colspan="2">상품정보</td>
					<td>상품금액</td>
					<td>수량</td>
					<td>배송형태/배송비</td>


				</tr>
			</thead>
			<tbody>
				<tr class="cart_list_detail">
					<td><input type="checkbox"></td>
					<td><img src="../kh_sina/img/clothes.png" alt="black-tshirt"></td>
					<td>
						<p>주신사 자체제작</p> <span style="color: blue;">10047387483748</span>
					</td>
					<!-- 가격 -->
					<td class="cart-table">
						<p class="cart-price">50.000</p> <!-- 수량 -->
					<td>
						<button class="quantity">-</button> <input id="cart_ipt"
						type="text" value="1" disabled>
						<button class="quantity">+</button>
					</td>
					<td>
						<p>택배배송</p>
						<p>배송비 무료</p>
					</td>

					</td>
				</tr>
			</tbody>

		</table>

		<div class="myCart_btn_area">
			<button class="delete_btn">삭제</button>
		</div>
		<div class="cart_mainbtns">

			<button class="cart_bigorderbtn left">쇼핑계속하기</button>
			<button class="cart_bigorderbtn right">주문하기</button>
		</div>

	</form>


</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>