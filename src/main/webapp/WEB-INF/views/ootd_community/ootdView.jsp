<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/ootdAdd.css" /> 
  <form action="<%= request.getContextPath()%>/community/CommunityOotdAdd" method="POST">
    <section class="container">
        <span class="dropdown">
          <select name="one" class="dropdown-select">
            <option value="">정렬 기준</option>
            <option value="1">최신순</option>
            <option value="2">조회순</option>
            <option value="2">추천순</option>
            <option value="3">댓글많은순</option>
          </select>
        </span>
        <span class="dropdown">
            <select name="two" class="dropdown-select">
              <option value="">검색 조건</option>
              <option value="1">제목</option>
              <option value="2">작성자</option>
              <option value="3">본문 내용</option>
            </select>
          </span>
          <div class="search">
            <input type="text" id="search" value="검색창">
          </div>
          <input 
          	type="button" value="글쓰기" 
          	class="ootdAddBtn"
          	onclick="location.href='<%= request.getContextPath() %>/?community/CommunityOotdAdd">
   
</form>

    <div class="main">
        <ul>
            <li>
                
                <a href=""></a>
                <img src="/sample/image/bgsample.PNG" alt="">
                <div class="title">게시글제목</div>
                <div class="date">날짜</div>
                <div class="summ">
                  <span class="recommend">추천수</span>
                  <span class="readcount">조회수</span>   
                  <span class="comment_no">댓글수</span>
                </div>
                
            </li>
            <li>
                
                <a href=""></a>
                <img src="/sample/image/bgsample.PNG" alt="">
                <div class="title">게시글제목</div>
                <div class="date">날짜</div>
                <div class="summ">
                  <span class="recommend">추천수</span>
                  <span class="readcount">조회수</span>   
                  <span class="comment_no">댓글수</span>
                </div>
                
            </li>
            <li>
                
                <a href=""></a>
                <img src="/sample/image/bgsample.PNG" alt="">
                <div class="title">게시글제목</div>
                <div class="date">날짜</div>
                <div class="summ">
                  <span class="recommend">추천수</span>
                  <span class="readcount">조회수</span>   
                  <span class="comment_no">댓글수</span>
                </div>
                
            </li>
            <li>
                
                <a href=""></a>
                <img src="/sample/image/bgsample.PNG" alt="">
                <div class="title">게시글제목</div>
                <div class="date">날짜</div>
                <div class="summ">
                  <span class="recommend">추천수</span>
                  <span class="readcount">조회수</span>   
                  <span class="comment_no">댓글수</span>
                </div>
                
            </li>
            <li>
                
                <a href=""></a>
                <img src="/sample/image/bgsample.PNG" alt="">
                <div class="title">게시글제목</div>
                <div class="date">날짜</div>
                <div class="summ">
                  <span class="recommend">추천수</span>
                  <span class="readcount">조회수</span>   
                  <span class="comment_no">댓글수</span>
                </div>
                
            </li>
            <li>
                
                <a href=""></a>
                <img src="/sample/image/bgsample.PNG" alt="">
                <div class="title">게시글제목</div>
                <div class="date">날짜</div>
                <div class="summ">
                  <span class="recommend">추천수</span>
                  <span class="readcount">조회수</span>   
                  <span class="comment_no">댓글수</span>
                </div>
                
            </li>
        </ul>
    </div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>