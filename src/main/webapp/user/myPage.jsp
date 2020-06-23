<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Happy House</title>
        <link href="${root}/css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>
    </head>

<body>
	<%@include file="/menubar.jsp"%>

	<div class="col-lg-9">
		<div class="card-header">
			<h3 class="text-center font-weight-light my-4">마이페이지 - 내 정보</h3>
		</div>
		<div class="card-body">
			<form id="userform" method="post" action="">

				<div class="form-group">
					<label class="small mb-1">아이디</label><input
						class="form-control py-4" style="font-weight: bold;"
						value="${userinfo.id}" readonly/>
				</div>
				<div class="form-group">
					<label class="small mb-1">이름</label><input
						class="form-control py-4" style="font-weight: bold;"
						value="${userinfo.name}" readonly />
				</div>
				<div class="form-group">
					<label class="small mb-1">연락처</label><input
						class="form-control py-4" style="font-weight: bold;"
						value="${userinfo.contact}" readonly/>
				</div>

				<div class="form-group">
					<label class="small mb-1">주소</label><input
						class="form-control py-4" style="font-weight: bold;"
						value="${userinfo.address}" readonly />
				</div>

				<div align=center>
					<a class="btn btn-primary" href="${root}/user/userModify.jsp">수정</a>&nbsp&nbsp<a
						class="btn btn-primary" href="${root}/user/userDelete.jsp">삭제</a>
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
