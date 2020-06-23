<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>비밀번호 찾기</title>
<link href="${root}/css/styles.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"
	crossorigin="anonymous"></script>
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
								<h3 class="text-center font-weight-light my-4">비밀번호 찾기</h3>
							</div>
							<div class="card-body">
								<div class="small mb-3 text-muted">비밀번호를 찾으시려면 ID와 연락처를
									입력해 주세요.</div>
								<form id="loginform" method="post" action="${root}/forgetpw">
									<div class="form-group">
										<label class="small mb-1">아이디</label><input
											class="form-control py-4" id="id" name="id"
											placeholder="아이디를 입력하세요" value="" />
									</div>
									<div class="form-group">
										<label class="small mb-1">연락처</label><input
											class="form-control py-4" name="phone"
											placeholder="연락처를 입력하세요" value="" />
									</div>

									<div
										class="form-group d-flex align-items-center justify-content-between mt-4 mb-0">
										<a href="${root}/mvlogin">로그인으로 돌아가기</a><input
											type="submit" class="btn btn-primary" value="찾기">
									</div>
								</form>
							</div>
							<div class="card-footer text-center">
								<div class="small">
									<a href="${root}/mvjoin">계정이 없으신가요? 회원가입 </a>
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
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">SSAFY 3기 8반 윤수연, 김수민</div>
                            <div class="text-muted">Template by <a href="https://startbootstrap.com/templates/sb-admin/">startbootstrap</a></div>
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
