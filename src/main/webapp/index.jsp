<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container">
	 <!-- 캐러셀 -->
  <div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
	  <div class="carousel-indicators">
	    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
	    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
	    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button>
	  </div>
	  <div class="carousel-inner">
	    <div class="carousel-item active" data-bs-interval="6000">
	      <img src="<%= request.getContextPath() %>/images/index_page1.jpg" class="d-block w-100" alt="...">
	      <div class="carousel-caption d-none d-md-block">
	        <h5>주신사는...</h5>
	        <p>합리적인 가격으로 나아가며, 스타일에 맞는 유행 트렌드에 맞추어 고객님에게 정보를 제공하겠습니다.</p>
	      </div>
	    </div>
	    <div class="carousel-item" data-bs-interval="3000">
	      <img src="<%= request.getContextPath() %>/images/index_page2.jpg" class="d-block w-100" alt="...">
	      <div class="carousel-caption d-none d-md-block">
	        <h5 class="indexText">주신사는...</h5>
	        <p class="indexText">소비자간의 소통으로 브랜드나 옷에 대한 정보를 보다 사실적으로 공유할 수 있습니다.</p>
	      </div>
	    </div>
	    <div class="carousel-item">
	      <img src="<%= request.getContextPath() %>/images/index_page5.jpg" class="d-block w-100" alt="...">
	      <div class="carousel-caption d-none d-md-block">
	        <h5 class="indexText">주신사는...</h5>
	        <p class="indexText">오늘입은  스타일 공유를 통해 옷을 구매할 때 정보를 공유할 수 있습니다.</p>
	      </div>
	    </div>
	  </div>
	  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Previous</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Next</span>
	  </button>
	</div>
	<br /><br />
	<!-- 카드 -->
	<hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading">주신사는 고객께 옷 구매시 도움을 드릴 수 있는 <span class="textm">코디북</span>을 제공합니다.</h2>
        <p class="lead">빠른 속도로 변해가는 트렌드와 유행에 민감한 대한민국에 살고 있는 지금, 바쁜 시간 속 멋을 포기 할 수 없는 시대에 살고 있다. 과열된 쇼핑몰의 시장 속 어디서 어떻게 구매해야하는지, 가격은 적절한 지에 대한 의문점이 제기 되고 있다. 과열된 시장 속 고객들에게 좀 더 합리적인 가격으로 나아가며, 스타일에 맞는 유행 트렌드에 맞추어 고객에게 정보를 제공하여 구매할 수 있도록 돕는다.</p>
      </div>
      <div class="col-md-5">
        <img src="<%= request.getContextPath() %>/images/index_page4.jpg" width="100%" height="310"  alt="" />
      </div>
    </div>
    
    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7 order-md-2">
        <h2 class="featurette-heading">주신사는 고객께 옷 구매시 도움을 드릴 수 있는 <span class="textm">코디북</span>을 제공합니다.</h2>
        <p class="lead">다양한 브랜드와 각양각색의 옷들이 많지만 온라인에서는 숫자적인 수치 이외에는 정보가 부족한 것이 사실이다. 하지만 소비자간의 소통으로 브랜드나 옷에 대한 정보를 보다 사실적으로 공유할 수 있으며, 각자 자신의 스타일 공유를 통해 옷을 구매할 때 도움이 될 수 있는 기회가 생겨 실패 리스크를 줄일 수 있는 이점이 있다.</p>
      </div>
      <div class="col-md-5 order-md-1">
		<img src="<%= request.getContextPath() %>/images/index_page3.jpg" width="100%" height="310"  alt="" />
      </div>
    </div>

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading">주신사는 고객께 옷 구매시 도움을 드릴 수 있는 <span class="textm">코디북</span>을 제공합니다.</h2>
        <p class="lead">다양한 브랜드와 각양각색의 옷들이 많지만 온라인에서는 숫자적인 수치 이외에는 정보가 부족한 것이 사실이다. 하지만 소비자간의 소통으로 브랜드나 옷에 대한 정보를 보다 사실적으로 공유할 수 있으며, 각자 자신의 스타일 공유를 통해 옷을 구매할 때 도움이 될 수 있는 기회가 생겨 실패 리스크를 줄일 수 있는 이점이 있다.</p>
      </div>
      <div class="col-md-5">
		<img src="<%= request.getContextPath() %>/images/index_page6.jpg" width="100%" height="310"  alt="" />
      </div>
    </div>
  </div>
	
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>