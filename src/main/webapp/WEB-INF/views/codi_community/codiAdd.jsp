<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<main>
 <div class="container">
       <section class="py-5 text-center container">
           <h3>Out Fit Edit</h3>
       </section>
       <div class="mb-3">
           <label for="exampleFormControlInput1" class="form-label">Title</label>
           <input type="text" class="form-control" id="exampleFormControlInput1" placeholder="">
       </div>
       <div class="mb-3">
           <label for="formFile" class="form-label">Select The File</label>
           <input class="form-control" type="file" id="formFile">
       </div>
       <div class="mb-3">
           <label for="exampleFormControlTextarea1" class="form-label">Content</label>
           <textarea class="form-control" id="exampleFormControlTextarea1" rows="10"></textarea>
       </div>
       <div class="text-center">
           <button type="button" class="btn btn-outline-danger">Cancle</button>
           <button type="button" class="btn btn-outline-secondary">Edit</button>
       </div>
   </div>
</main>	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>