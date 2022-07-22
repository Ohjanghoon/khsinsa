<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/ootd_community/ootdList.css" />

<div class="container">
	<div class="title">
		<h3>OOTD Outfit Of The Day</h3>
		<h5>
			주신사 고객님들이 직접 촬영한 패션 사진을 공유하고 소통하며,<br> '오늘 뭐 입지?' 에 대한 고민을 덜어보실
			수 있습니다.
			<p>※ 부적절한 게시글/댓글의 경우 '삭제', '제한' 될 수 있는점 알려드립니다.</p>
		</h5>
	</div>
	<div class="row justify-content-md-center">

		<div class="row">
			<div class="col">
				<select class="form-select" aria-label="Default select example"
					id="alignment" name="alignment">
					<option selected>정렬기준</option>
					<option value="조회순">조회순</option>
					<option value="추천순">추천순</option>
					<option value="댓글순">댓글순</option>
				</select>
			</div>

			<div class="input-group mb-3" id="search" name="search">
				<select class="form-select" id="inputGroupSelect02">
					<option selected>검색기준</option>
					<option value="제목">제목</option>
					<option value="작성자">작성자</option>
					<option value="내용">내용</option>
				</select> <label class="input-group-text" for="inputGroupSelect02">검색</label>
			</div>

			<div class="col col-lg-2">
				<button type="button" class="btn btn-secondary">Secondary</button>
			</div>
		</div>
	</div>
</div>




<div class="content">
	<ul>
		<li><a href=""><img src="" class="contain"></a>
			<div class="title">게시글제목</div>
			<div class="date">날짜</div>
			<div class="summ">
				<span class="recommend">추천수</span> <span class="readcount">조회수</span>
				<span class="comment_no">댓글수</span>
			</div></li>

		<li><a href=""></a> <img src="/sample/image/bgsample.PNG" alt="">
			<div class="title">게시글제목</div>
			<div class="date">날짜</div>
			<div class="summ">
				<span class="recommend">추천수</span> <span class="readcount">조회수</span>
				<span class="comment_no">댓글수</span>
			</div></li>
		<li><a href=""></a> <img src="/sample/image/bgsample.PNG" alt="">
			<div class="title">게시글제목</div>
			<div class="date">날짜</div>
			<div class="summ">
				<span class="recommend">추천수</span> <span class="readcount">조회수</span>
				<span class="comment_no">댓글수</span>
			</div></li>
		<li><a href=""></a> <img src="/sample/image/bgsample.PNG" alt="">
			<div class="title">게시글제목</div>
			<div class="date">날짜</div>
			<div class="summ">
				<span class="recommend">추천수</span> <span class="readcount">조회수</span>
				<span class="comment_no">댓글수</span>
			</div></li>
		<li><a href=""></a> <img src="/sample/image/bgsample.PNG" alt="">
			<div class="title">게시글제목</div>
			<div class="date">날짜</div>
			<div class="summ">
				<span class="recommend">추천수</span> <span class="readcount">조회수</span>
				<span class="comment_no">댓글수</span>
			</div></li>
		<li><a href=""></a> <img src="/sample/image/bgsample.PNG" alt="">
			<div class="title">게시글제목</div>
			<div class="date">날짜</div>
			<div class="summ">
				<span class="recommend">추천수</span> <span class="readcount">조회수</span>
				<span class="comment_no">댓글수</span>
			</div></li>
	</ul>
</div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>