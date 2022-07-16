<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/product/productDetail.css" />
<main>
    <div class="container-fluid">
        <section class="py-5 text-center container">
            <p>상품상세보기</p>
        </section>

        <div class="container-md">
            <p class="product-name">쿨 썸머 에센셜 라운드 반팔 니트티 BLACK</p>
            <div class="product-img">
                <img src="./img/flower1.PNG" alt="">
            </div>
            <div class="product-text">
                <p>Product Info</p>
                <p>상품명</p>
                <p>좋아요 수</p>
                <p>베송비</p>
                <p>옵션</p>
                <form action="" name="productFrm">
                    <select class="form-select" aria-label="Default select example">
                        <option selected>사이즈를 선택해주세요.</option>
                        <option value="1">L</option>
                        <option value="2">M</option>
                        <option value="3">S</option>
                    </select>
                    <p>수량</p>
                    <button>-</button>
                    <input type="text" value="1" disabled>
                    <button>+</button>
                    <p>총 결제 금액</p>
                    <p>0원</p>
                    <button id="buy">구매하기</button>
                    <button>찜하기</button>
                    <button>장바구니 담기</button>
                </form>
            </div>
            <hr>
            <div class="product-info">
                <img src="./img/flower2.PNG" alt="">
                <img src="./img/flower3.PNG" alt="">
                <img src="./img/flower4.PNG" alt="">
                <p>상품설명</p>
                <span>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Voluptas iure, id, distinctio dignissimos saepe provident quidem iusto a consequuntur inventore eos exercitationem molestiae hic? Nobis cum perferendis reprehenderit ullam nesciunt! Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi aut deleniti facilis fugit temporibus, non, nostrum molestiae consectetur, aliquid necessitatibus officiis iusto. Ipsum dignissimos nulla, error saepe aliquid nostrum eveniet?</span>
                <p>사이즈 기준표</p>
                <img src="./img/hyunta.jpg" alt="">
            </div>
            <hr>
            <section>
                <form action="">
                    <p>리뷰</p>
                    <div class="review">
                    <p>아이디</p>
                    <p>L</p>
                    <p>후기</p>
                    <img src="./img/tiger.jpg" alt="">
                    <button>👍 추천</button>
                    <button>🚨 신고</button>
                </form>
                <section class="py-5 text-center container">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <a class="page-link" href="#">이전</a>
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#">다음</a>
                            </li>
                        </ul>
                    </nav>
                </section>
            </section>
            </div>
        </div>
    </div>
</main>
<script>
	document.querySelector("#buy").addEventListener('click', (e) => {
		productFrm.action = "<%= request.getContextPath() %>/product/order";
	});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>