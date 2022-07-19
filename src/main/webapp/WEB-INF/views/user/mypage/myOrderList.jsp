<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%@ include file ="/WEB-INF/views/common/myPageHeader.jsp" %>


<link rel="stylesheet" href="<%=request.getContextPath() %>/css/user/mypage/myOrderList.css">
<section class="cart">
  
    <form action="">
    <table class="cart_list">
            <thead>
                <tr>
                    <td><input type="checkbox"></td>
                    <td colspan="2">상품정보</td>
                    <td>주문번호</td>
                    <td>주문일자</td>
                    <td>주문금액</td>
                    <td>주문상태</td>
                    
                </tr>
            </thead>
            <tbody>
                <tr class="cart_list_detail">
                    <td><input type="checkbox"></td>
                    <td><img src="../kh_sina/img/clothes.png" alt="black-tshirt"></td>
                    <td><p>주신사 자체제작</p>
                        <span style="color:blue;">10047387483748</span>
                    </td>
                    <td class="order_table">
                        <p class="order_number">2022070212345-423423423</p>

                        <td><p>2022/07/03</p></td>
                        <td><p>50.000</p></td>
                        <td><p>배송중</p></td>
                    </td>
                </tr>
            </tbody>
           
        </table>
        <div class="cart_mainbtns">
    
            <button class="cart_bigorderbtn left">쇼핑계속하기</button>
            <button class="cart_bigorderbtn right">주문하기</button>
        </div>
          
        </form>
        

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>