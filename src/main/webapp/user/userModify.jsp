<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>회원정보 수정</title>
<link href="${root}/css/styles.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"
	crossorigin="anonymous"></script>
</head>

<body>
	<%@include file="/menubar.jsp"%>

	<div class="col-lg-9">
		<div class="card-header">
			<h3 class="text-center font-weight-light my-4">회원정보 수정</h3>
		</div>
		<div class="card-body">
			<form action="${root}/modify" method="post">
				<div class="form-row">
					<div class="col-md-6">
						<div class="form-group">
							<label class="small mb-1">아이디</label><input type="text"
								class="form-control py-4" id="id" name="id" readonly="readonly"
								value="${userinfo.id}" />
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label class="small mb-1">비밀번호</label><input type="password"
								class="form-control py-4" id="password" name="password"
								value="${userinfo.password}" />
						</div>
					</div>
				</div>
				<div class="form-row">
					<div class="col-md-6">
						<div class="form-group">
							<label class="small mb-1">이름</label><input type="text"
								class="form-control py-4" id="name" name="name"
								value="${userinfo.name}" />
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label class="small mb-1">전화번호</label><input type="text"
								class="form-control py-4" id="contact" name="contact"
								value="${userinfo.contact}" />
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="small mb-1">주소</label><input type="text"
						class="form-control py-4" id="address" name="address"
						value="${userinfo.address}" />
				</div>
				
				<input type="hidden" name="isAdmin" value="${userinfo.isAdmin}">
				
				<div class="form-group mt-4 mb-0">
					<input class="btn btn-primary" type="submit" value="수정" />
				</div>
			</form>
		</div>
		<div class="card-footer text-center">
			<div class="small"></div>
		</div>
	</div>


	        <script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${root}/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="${root}/assets/demo/chart-area-demo.js"></script>
        <script src="${root}/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="${root}/assets/demo/datatables-demo.js"></script>
</body>
</html>
