<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<body class="col-lg-4 col-md-5 col-sm-11">

	<section class="container-fluid">
		<article class="row d-flex justify-content-center">

			<section id="p_list" class="col-lg-4 col-md-5 col-sm-11">
				<%@ include file="/WEB-INF/views/p-list.jsp"%>
			</section>

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

		</article>
	</section>


</body>

