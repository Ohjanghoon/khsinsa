<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/inquire/inquireAdd.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<div class="container">
	<form action="" method="POST" id="inqure_Frm">
		<p class="title">문의하기</p>
		<div class="inquire_input">
			<table>
				<colgroup>
					<col style="width: 15%;">
					<col style="width: 75%;">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><span class="label"> <label
								for="check">문의유형</label>
						</span></th>
						<td><select class="form-select form-select-sm-1"
							aria-label=".form-select-sm example">
								<option value="1">상품</option>
								<option value="2">커뮤니티</option>
								<option value="3">마이페이지</option>
								<option value="4">로그인</option>


						</select></td>
					</tr>

					<tr>
						<th scope="row"><span class="label"> <label
								for="psot_title">글제목</label>
						</span></th>
						<td>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label"></label> <input
									type="text" class="form-control" id="formGroupExampleInput"
									placeholder="제목을 입력하세요">
							</div>
						</td>
					</tr>

					<tr>
						<th scope="row"><span class="label"> <label
								for="post_content">문의내용</label>
						</span></th>
						<td><textarea name="post_content" id="post_content" cols="100"
								rows="10" ></textarea></td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="inquire_input2">

			<div class="input-group mb-3">
				<input type="file" class="form-control" id="inputGroupFile02">
				<label class="input-group-text" for="inputGroupFile02">파일등록</label>
			</div>

			<button type="submit" class="btn btn-success">등록하기</button>
			<button type="submit" class="btn btn-light">취소하기</button>


		</div>
	</form>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>