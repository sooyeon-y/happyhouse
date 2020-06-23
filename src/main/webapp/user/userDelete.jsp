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
<title>회원정보 삭제</title>
<link href="${root}/css/styles.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"
	crossorigin="anonymous"></script>
</head>

<body>
	<%@include file="/menubar.jsp"%>
	<div class="col-lg-9">
		<div class="card-header">
			<h3 class="text-center font-weight-light my-4">회원정보 삭제</h3>
		</div>
		<div class="card-body">
			<%
				String errorMessage = (String) request.getAttribute("errorMessage");
				if (errorMessage != null) {
			%>
			<div style="color: red; text-decoration: underline;">
				<%=errorMessage%>
			</div>
			<%
				}
			%>
			<form action="${root}/delete" method="post"
				onsubmit="return confirm('정말 탈퇴 하시겠습니까? 되돌 릴 수 없습니다.')">
				탈퇴 하시려면 비밀번호를 입력해 주십시요<br> <br> 비밀번호 : <input
					type="password" name="password" class="form-control py-4"><br>
				<input type="submit"  class="btn btn-primary" value="탈퇴">&nbsp &nbsp<input type="reset"
					 class="btn btn-primary" value="취소" onclick="history.back()">
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
