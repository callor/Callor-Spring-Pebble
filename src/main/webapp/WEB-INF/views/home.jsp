<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상품정보 관리</title>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style>
div {
	margin: 5px;
}

div.row {
	margin: 0 auto;
}

div#p_list {
	height: 600px;
	overflow: auto;
}

#p_image {
	position: relative;
}

#p_image:hover {
	background-color: rgba(0, 0, 0, 0.3);
}
</style>
<script>
	$(function() {
		$("#p_image").click(function() {
			if (confirm("이미지를 삭제할까요")) {
				let p_code = $("#p_code").val()
				document.location.href = "${rootPath}/imgDelete?p_code="+ p_code
			}
		})
		
		let p_list =  new Vue({
		  el: '#p_list',
		  data: {
		    message: '안녕하세요 처음 시작하는 Vue!'
		  }
		})
		
	})
	

</script>
</head>
<section class="container-fluid">
	<%@ include file="/WEB-INF/views/include/include-header.jsp" %>
	<article class="row d-flex justify-content-center">
		

		<div id="p_list" class="col-lg-4 col-md-5 col-sm-11">
			<%@ include file="/WEB-INF/views/p-list.jsp"%>
			{{message}}
		</div>

		<section class="col-lg-4 col-md-5 col-sm-11">

			<form class="was-validated" method="POST"
				enctype="multipart/form-data" action="${rootPath}/input">

				<div class="form-group">
					<label for="p_code">상품코드:</label> <input type="text"
						class="form-control" placeholder="상품코드를 입력하세요" name="p_code"
						id="p_code">
				</div>
				<div class="form-group">
					<label for="p_name">상품이름</label> <input type="text"
						class="form-control" placeholder="상품이름을 입력하세요" name="p_name"
						id="p_name" required>
					<div class="valid-feedback">Valid.</div>
					<div class="invalid-feedback">상품이름은 반드시 입력하세요</div>
				</div>

				<div class="form-group">
					<label for="p_iprice">매입가격</label> <input type="text"
						class="form-control" placeholder="매입가격을 입력하세요" name="p_iprice"
						id="p_iprice" required>
					<div class="valid-feedback">Valid.</div>
					<div class="invalid-feedback">매입가격을 입력하세요</div>
				</div>

				<div class="form-group form-check">
					<label class="form-check-label"> <input
						class="form-check-input" type="checkbox" name="p_vat" value="1">
						과세
					</label>
				</div>
				<div class="form-group">
					<label for="p_oprice">매출가격</label> <input type="text"
						class="form-control" placeholder="매출가격을 입력하세요" name="p_oprice"
						id="p_oprice" required>
					<div class="valid-feedback">Valid.</div>
					<div class="invalid-feedback">매출가격을 입력하세요</div>
				</div>
				<%
					/*
					input type="text"
					파일을 업로드 수행하기 위한 컨트롤 요소
					multiple="muliple" : 여러개의 파일을 동시에 업로드 가능
					accept="" : 특정한 성질의 파일만 올리고 싶을때
					accept="image/*" : 이미지관련 파일들
					accept="text/plain" : text 파일만(*.txt)
					accept="text/html" : text 파일중에 *.html
					accept="video/*" : 동영상 관련 파일
					
					accept="application/vnd.ms-excel" : excel 파일만
					aceept=".xls|.xlsx" : excel 파일
					*/
				%>

				<div class="form-group">
					<input type="hidden" name="p_file" id="p_file"> <label
						class='label'>대표이미지</label> <input type="file"
						class="form-controller" name="u_file" multiple="multiple"
						accept="image/*" id="u_file">
				</div>

				<div class="form-group">
					<label>기타이미지</label> <input type="file" class="form-controller"
						name="u_files" multiple="multiple" accept="image/*" id="u_files">
				</div>
				<div class="form-group">
					<label>대표이미지</label> <img src="${rootPath}/files/noimage.png"
						id="p_image" width="200px" height="200px">
				</div>

				<button type="reset" class="btn btn-warning">새로작성</button>
				<button type="submit" class="btn btn-primary">저장</button>
			</form>

		</section>
		<div id="p_sub_list" class="col-lg-3 col-md-5 col-sm-11">보조정보</div>

	</article>
	<%@ include file="/WEB-INF/views/include/include-footer.jsp" %>
</section>
</html>