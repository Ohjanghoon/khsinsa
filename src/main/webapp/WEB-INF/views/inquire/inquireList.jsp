<%@page import="com.kh.sinsa.inquire.model.dto.Inquire"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
	List<Inquire> list = (List<Inquire>) request.getAttribute("list");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/inquire/inquireList.css" />


    <div class="header">
      1:1문의
    </div>
    
        <div class="container">
            <div class="th">
            <div class="row">
              <div class="col-lg-5">

                <input type="button" value="문의하기" onclick="<%= request.getContextPath() %>/inquire/inquireAdd" />
              
               </div>
 
              <div class="col-lg-4">
                <span class="dropdown">
                    <select name="one" class="dropdown-select">
                      <option value="0">전체</option>
                      <option value="1">내용</option>
                      <option value="2">제목</option>
                      <option value="3">작성자</option>
                    </select>
                </span>
              </div>
              <div class="col-lg-3">
                <input type="text" name="" id="title" value="검색어를 입력하세요">
              </div>
            </div>
          </div>
          </div>

        <div class="content">
            <div class="container">
                <div class="tr">
                <div class="row">
                  <div class="col-lg-2">
                   
                  
                  </div>
                  <div class="col-lg-4">
                    제목
                    
                  </div>
                  <div class="col-lg-2">
                    작성자
                  </div>
                  <div class="col-lg-2">
                    작성일
                  </div>
                  <div class="col-lg-2">
                    답변상태
                  </div>
                </div>
              </div>
        </div>
       
<%
	for(Inquire iq : list){
%>
        <div class="container">
            <div class="td">
            <div class="row">
              <div class="col-lg-2">
               <span><%= iq.getInquireNo() %></span>
              </div>
              <div class="col-lg-4" >
             <a  href="<%= request.getContextPath() %>/inquire/inquireEdit"><%= iq.getInquireTitle() %></a>
              </div>
              <div class="col-lg-2">
                <spqn><%= iq.getUserId() %></spqn>
              </div>
              <div class="col-lg-2">
                <spqn><%= iq.getInquireDate() %></spqn>
              </div>
              <div class="col-lg-2">
                <span><%= iq.getInquireAnswerRef() %></span>	
              </div>
            </div>
          </div>
    </div>
<%
	}
%>  

<div id="pagebar">
 <%= request.getAttribute("pagebar") %>
</div>
    </div>