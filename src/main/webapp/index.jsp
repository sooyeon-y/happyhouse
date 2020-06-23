<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>    
<head>
    <meta charset="utf-8" />
    
    <!-- 즉시 로그인페이지로 이동 -->
    <meta http-equiv="refresh" content="0;URL='${root}/mvlogin'">
    
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

<!--  
<%@include file="menubar.jsp" %>

<div id="layoutSidenav_content">
    <main>
        <div class="container-fluid">
        
        <br>
        	 <button type="button" class="btn btn-success" onClick="location.href='${root}/mvlogin'">시작하기 (로그인 화면으로 이동)</button>
        <br>
        
        </div>
    </main>
</div>
-->
  
</body>
</html>