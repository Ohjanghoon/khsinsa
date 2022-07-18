<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="/WEB-INF/views/common/header.jsp" %> --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<%@ include file ="/WEB-INF/views/common/myPageHeader.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/user/mypage/cart.css">
<!-- <div class="wrapper relative">

        <p class="my_page_txt">MY PAGE</p>

    </div> -->



    <div class="orderlist_txt">
        <p>장바구니</p>
    </div>


    <section class="cart">

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
                            <p>주신사 자체제작</p>
                            <span style="color:blue;">10047387483748</span>
                        </td>
                        <!-- 가격 -->
                        <td class="cart-table">
                            <p class="cart-price">50.000</p>
                            <!-- 수량 -->
                        <td>
                            <button class="quantity">-</button>
                            <input id="cart_ipt" type="text" value="1" disabled>
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

            <div>
                <button class="delete_btn">삭제</button>
            </div>
            <div class="cart_mainbtns">

                <button class="cart_bigorderbtn left">쇼핑계속하기</button>
                <button class="cart_bigorderbtn right">주문하기</button>
            </div>

        </form>


    </section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>