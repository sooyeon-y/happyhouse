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
<title>회원가입</title>
<link href="${root}/css/styles.css" rel="stylesheet" />
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"
   crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
   crossorigin="anonymous"></script>
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"
   crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>

<script type="text/javascript">
   $(document).ready(function() {
      $("#registerBtn").click(function() {

         if ($("#id").val() == "") {
            alert("아이디 입력!!!");
            return;
         } else if ($("#password").val() == "") {
            alert("비밀번호 입력!!!");
            return;
         } else if ($("#name").val() == "") {
            alert("이름 입력!!!");
            return;
         } else if ($("#address").val() == "") {
            alert("주소 입력!!!");
            return;
         } else if ($("#contact").val() == "") {
            alert("전화번호 입력!!!");
            return;
         } else {
            $("#userform").attr("action", "${root}/join").submit();
         }
      });
   });

   function moveLogin() {
      document.location.href = "${root}/mvjoin";
   }
</script>
</head>
<body class="bg-primary">
   <div id="layoutAuthentication">
      <div id="layoutAuthentication_content">
         <main>
         <div class="container">
            <div class="row justify-content-center">
               <div class="col-lg-7">
                  <div class="card shadow-lg border-0 rounded-lg mt-5">
                     <div class="card-header">
                        <h3 class="text-center font-weight-light my-4">회원가입</h3>
                     </div>
                     <div class="card-body">
                        <form id="userform" method="post" action="">
                           <div class="form-row">
                              <div class="col-md-6">
                                 <div class="form-group">
                                    <label class="small mb-1" for="inputPassword">아이디</label><input
                                       class="form-control py-4" id="id" name="id"
                                       placeholder="id" />
                                 </div>
                              </div>
                              <div class="col-md-6">
                                 <div class="form-group">
                                    <label class="small mb-1" for="inputConfirmPassword">비밀번호</label><input
                                       type="password" class="form-control py-4" id="password" name="password"
                                       placeholder="영문 숫자 포함 6자리 이상" />
                                 </div>
                              </div>
                           </div>
                           <div class="form-row">
                              <div class="col-md-6">
                                 <div class="form-group">
                                    <label class="small mb-1" for="inputPassword">이름</label><input
                                       class="form-control py-4" id="name" name="name"
                                       placeholder="name" />
                                 </div>
                              </div>
                              <div class="col-md-6">
                                 <div class="form-group">
                                    <label class="small mb-1" for="inputConfirmPassword">전화번호</label><input
                                       class="form-control py-4" id="contact" name="contact"
                                       placeholder="010-xxxx-xxxx" />
                                 </div>
                              </div>
                           </div>
                           <div class="form-group">
                              <label class="small mb-1" for="inputEmailAddress">주소</label><input
                                 class="form-control py-4" id="address" name="address"
                                 placeholder="address" />
                           </div>

                           <div class="form-group mt-4 mb-0">
                              <a class="btn btn-primary btn-block" id="registerBtn"
                                 onclick="">회원가입</a>
                           </div>
                        </form>
                     </div>
                     <div class="card-footer text-center">
                        <div class="small">
                           <a href="${root}/mvlogin">이미 계정이 있으신가요? 로그인</a>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         </main>
      </div>
      <br>
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

</body>
</html>