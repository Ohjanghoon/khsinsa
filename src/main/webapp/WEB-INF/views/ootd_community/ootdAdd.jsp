<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<%@ include file="/WEB-INF/views/common/header.jsp"%>
    <div id="container">

<form action="">
<div id="content">
    <span class="dropdown">
        <select name="one" class="dropdown-select">
          <option value="0">게시판 이동</option>
          <option value="1">OOTD</option>
          <option value="2">코디북</option>
          <option value="3">정보공유</option>
          <option value="4">자유게시판</option>
          <option value="5">패션토크</option>
        </select>
    </span>
</form>
        <br>
        <div class="title">
        <input type="text" name="" id="title" value="제목">
        </div>
        <br>

        <p><textarea cols="100" rows="30"></textarea></p>
<form action="">
<div id="btn-sum">
<div id="file">   
    <input type="file" id="file">
</div>
<span class="btn-add">
    <input type="button" id="btn-add" value="작성">    
</span>
<span class="btn-sel">
    <input type="button" value="취소">
</span>
</div>
</form>
</div>

  </div>
  <%@ include file="/WEB-INF/views/common/footer.jsp"%>