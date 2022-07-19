<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
           <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/inquire/inquireEdit.css" />
    <div id="container">
  <div id="header1">COMMUNITY</div>
      <nav>
          <ul class="navi">
              <li><a href="#">OOTD</a></li>
              <li><a href="#">코디북</a></li>
              <li><a href="#">정보공유</a></li>
              <li><a href="#">자유게시판</a></li>
              <li><a href="#">패션토크</a></li>
          </ul>
      </nav>
    </div> 
    
 <div id="title"><h1>글제목</h1></div>

    <ul class="meta">
        <li>
          <dt>
            문의번호
          </dt>
          <dd>
            1234
          </dd>
        </li>
        <li>
          <dt>
            작성자
          </dt>
          <dd>
            홍길동
          </dd>
        </li>
        <li>
          <dt>
            작성일
          </dt>
          <dd>
            2022.01.01
          </dd>
        </li>
        <li>
          <dt>
            조회수
          </dt>
          <dd>
            15
          </dd>
        </li>
    </ul>

<div class="content">


<div class="qna question">
  <i class="que">Q</i>
  <p class="title">답변</p>
</div>
<div class="text">
<p>옷 사이즈가 어떻게됨?옷 사이즈가 어떻게됨?옷 사이즈가 어떻게됨?옷 사이즈가 어떻게됨?</p>

</div>
<div class="qna answer">
  <i class="ans">A</i>
  <p class="title">답변</p>

<div class="text">
<p>정 사이즈 입니다.정 사이즈 입니다.정 사이즈 입니다.정 사이즈 입니다.정 사이즈 입니다.정 사이즈 입니다</p>

</div>
</div>
  <div class="ctrl">
    <ul>
      <li>수정</li>
      <li>삭제</li>
    </ul>
    
  </div>
  
</div>

<p>페이징영역</p>
