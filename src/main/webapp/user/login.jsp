<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Login page</title>
<link href="${root}/css/styles.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"
	crossorigin="anonymous"></script>

<script type="text/javascript">
			function login() {
				if (document.getElementById("id").value == "") {
					alert("아이디 입력!!!");
					return;
				} else if (document.getElementById("password").value == "") {
					alert("비밀번호 입력!!!");
					return;
				} else {
					document.getElementById("loginform").action = "${root}/login";
					document.getElementById("loginform").submit();
				}
			}
		
			function moveJoin() {
				document.location.href = "${root}/mvjoin";
			}
		
			function moveForgetPW() {
				document.location.href = "${root}/mvforgetpw";
			}
	</script>
</head>
<body class="bg-primary">

	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-5">
							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-header">
									<h3 class="text-center font-weight-light my-4">로그인</h3>
									<c:if test="${!empty msg}">
										<h6 style="color:red" class="text-center font-weight-light my-4">${msg}</h6>
									</c:if>
								</div>
								<div class="card-body">
									<form id="loginform" method="post" action="">
										<div class="form-group">
											<label class="small mb-1">아이디</label><input
												class="form-control py-4" id="id" name="id" type="email"
												placeholder="아이디를 입력하세요" />
										</div>
										<div class="form-group">
											<label class="small mb-1">비밀번호</label><input
												class="form-control py-4" id="password" name="password"
												type="password" placeholder="비밀번호를 입력하세요"
												onkeydown="javascript:if(event.keyCode == 13) {login();}" />
										</div>

										<div
											class="form-group d-flex align-items-center justify-content-between mt-4 mb-0">
											<a class="small" href="javascript:moveForgetPW();">비밀번호
												찾기</a><a class="btn btn-primary" href="javascript:login();">로그인</a>
										</div>
									</form>
								</div>
								<div class="card-footer text-center">
									<div class="small">
										<a href="javascript:moveJoin();">계정이 없으신가요? 회원가입 </a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
		<div id="layoutAuthentication_footer">
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">SSAFY 3기 8반 윤수연, 김수민</div>
						<div class="text-muted">
							Template by <a
								href="https://startbootstrap.com/templates/sb-admin/">startbootstrap</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
</body>
</html>
