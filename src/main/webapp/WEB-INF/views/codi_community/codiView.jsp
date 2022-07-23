<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/codi/codiView.css" />
<div class="container">
    <section class="py-5 text-center container">
        <h3>Product Detail</h3>
    </section>
    <nav class="py-2 bg-light border-bottom">
        <div class="container d-flex flex-wrap" id="moveTovar">
          <ul class="nav me-auto">
            <li class="nav-item"><a href="#" class="nav-link link-dark px-2">OTTD</a></li>
            <li class="nav-item"><a href="<%= request.getContextPath() %>/community/codiView" class="nav-link link-dark px-2">코디북</a></li>
            <li class="nav-item"><a href="#" class="nav-link link-dark px-2">정보공유</a></li>
            <li class="nav-item"><a href="#" class="nav-link link-dark px-2">자유게시판</a></li>
            <li class="nav-item"><a href="#" class="nav-link link-dark px-2">패션토크</a></li>
          </ul>
        </div>
      </nav>
      
    <br><br><br>
    <div>
        <h3>코디북</h3>
        <p>전문 스타일리스트가 제안하는 다양한 코디로 매일 반복되는 코디 고민을 덜어보세요.</p>
        <p>최신 트렌드부터 누구나 입기 쉬운 룩까지 다양한 코디법을 담았습니다.</p>
        <p>※ 부적절한 게시글/댓글의 경우 '삭제', '제한' 될 수 있는점 알려드립니다.</p>
    </div>

    <div class="album py-5 bg-light">
        <div class="container">
            
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <div class="col">
                    <div class="card shadow-sm">
                        <img src="<%= request.getContextPath() %>/images/index_image_1.jpg" alt="" />
                        <div class="card-body">
                            <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                                    <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                                </div>
                                <small class="text-muted">9 mins</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>