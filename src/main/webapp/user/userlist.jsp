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
        <link href="${root}/css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">

<%@include file="/menubar.jsp" %>

<div id="layoutSidenav_content">
    <main>
        <div class="container-fluid">

<h3 class="mt-4">유저 리스트 조회</h3>

<br>

<div class="card mb-4">
     <div class="card-header"><i class="fas fa-table mr-1"></i>유저 리스트</div>
     <div class="card-body">
         <div class="table-responsive">
             <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                 <thead>
                     <tr>
                         <th>ID</th>
                         <th>이름</th>
                         <th>주소</th>
                         <th>연락처</th>
                         <th>관리자 여부</th>
                     </tr>
                 </thead>
                 <tbody>
                 
<c:forEach items="${userList}" var="user">
		<tr>
			<td>${user.id}</td>
			<td>${user.name}</td> 
			<td>${user.address}</td>
			<td>${user.contact}</td>
			<td>${user.isAdmin}</td>
		</tr>	
</c:forEach>

                </tbody>
            </table>
        </div>
    </div>
</div>

</div>
</main>
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