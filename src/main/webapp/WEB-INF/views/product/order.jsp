<%@page import="com.kh.sinsa.product.model.dto.ProductAttachment"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.sinsa.product.model.dto.Product"%>
<%@page import="com.kh.sinsa.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/product/order.css" />
<%
	Product product = (Product) request.getAttribute("product");
	User user = (User) request.getAttribute("user");
	List<ProductAttachment> attachList = (List<ProductAttachment>) request.getAttribute("attachList");
	String orderAmount = (String) request.getAttribute("orderAmount");
	String size = (String) request.getAttribute("size");
%>
<main>
    <div class="container">
        <section class="py-5 text-center container">
            <p>주문페이지</p>
        </section>
        <div class="container-md">
            <p id="title">주문</p>
            <hr>
            <div>
                <p id="user-info">수령자 정보</p>
                <div>
                    <div class="recipient-info">
                        <p>배송지 선택</p>
                        <form action="">
                            <label for="default">기본 배송지</label>
                            <input type="radio" name="home" id="default" checked>
                            <label for="new">새로운 배송지</label>
                            <input type="radio" name="home" id="new">
                            <br>
                            <label for="name">수령인</label>
                            <input type="text" id="name" name="name" value="<%= user.getUserName() %>">
                            <br>
                            <label for="phone">전화번호</label>
                            <input type="text" id="phone" name="phone" value="<%= user.getUserPhone() %>">
                            <br>
                            <label for="address">주소</label>
                            <input type="text" id="address" name="address" value="<%= user.getUserAddress() %>">
                            <br>
                            <label for="request">배송 요청 사항</label>
                            <select class="form-select" aria-label="Default select example">
                                <option selected>배송 시 요청사항을 선택해주세요.</option>
                                <option value="1">빠른 배송 부탁드립니다.</option>
                                <option value="2">부재시 경비실에 보관해주세요.</option>
                                <option value="3">부재시 현관앞에 보관해주세요.</option>
                            </select>
                        </div>
                        <div class="product-info">
                            <p>주문 상품 정보 (Product Info)</p>
                            <table class="table">
                                <thead>
                                  <tr>
                                    <th scope="col">상품정보</th>
                                    <th scope="col">수량</th>
                                    <th scope="col">배송비</th>
                                    <th scope="col">상품 금액</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <tr>
                                    <th scope="row">
<% 
for(ProductAttachment att : attachList) {
%>
                                        <img src="<%= request.getContextPath() %>/upload/product/<%= att.getProOriginalFilename() %>" alt="">
<% 
 break; } 
%>
                                        <p><%= product.getProName() %></p>
                                        <p>옵션 : <%= size %></p>
                                    </th>
                                    <td>
                                        <p><%= orderAmount %></p>
                                    </td>
                                    <td>
                                        <p>무료</p>
                                    </td>
                                    <td>
                                        <p><%= product.getProPrice() %>원</p>
                                    </td>
                                  </tr>
                                </tbody>
                              </table>
                        </div>
                            <div class="product-price">
                            <h3>결제 금액</h3>
                            <p><%= product.getProPrice() %>원</p>
                            <h3>할인 금액</h3>
                            <p>0원</p>
                            <h3>최종 결제 금액</h3>
                            <p><%= product.getProPrice() %>원</p>
                        </div>
                        <button class="button">결제하기</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>