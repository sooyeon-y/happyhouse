<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>        
    
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Happy House</title>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">

<%@include file="menubar.jsp" %>

<div id="layoutSidenav_content">
    <main>
        <div class="container-fluid">
        
        <h3 class="mt-4">공지사항 상세 확인</h3>
        <br>

	  <table class="table table-active">
	    <tbody>
	      <tr class="table-info">
	        <td>작성자: ${notice.userId}</td>
	        <td align="right">작성일시: ${notice.writeDate}</td>
	      </tr>
	      <tr>
	        <td colspan="2" class="table-danger"><strong>#${notice.num} ${notice.title}</strong></td>
	      </tr>
	      <tr>
	        <td colspan="2">${notice.content}</td>
	      </tr>
	      
	      
	      <c:if test="${userinfo.isAdmin == true}">
	      <tr>
	        <td colspan="2">
				<form method="post">
					<input type="hidden" name="num" value="${notice.num}">
					<input type="submit" value="수정" class="btn btn-warning" formaction="${root}/noticemodifypage">
					<input type="submit" value="삭제" class="btn btn-danger" formaction="${root}/noticedelete">
				</form>
			</td>
	      </tr>
	      </c:if>
	      
	    </tbody>
	  </table>
	  
	  </div>
	  </main>
	  </div>



        <script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/datatables-demo.js"></script>

</body>
</html>