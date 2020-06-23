<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>

<!-- 사진 없을경우 다세대주택.jpg로 대체하기 위한 코드 -->
<c:choose> 
<c:when test="${empty deal.img}">
<c:set var="imgname" value="다세대주택.jpg"/>
</c:when>
<c:otherwise>
<c:set var="imgname" value="${deal.img}"/>
</c:otherwise>
</c:choose>
    
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

<h3 class="mt-4">거래내역 상세 조회</h3>

<br>

<div class="card" style="width: 30rem;">
  <img class="card-img-top" src="img/${imgname}" alt="image">
  <div class="card-body">
    <h5 class="card-title">${deal.aptName}</h5>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item">거래금액: ${deal.dealAmount}</li>
    <li class="list-group-item">월세금액: ${deal.rentMoney}</li>
    <li class="list-group-item">건축연도: ${deal.buildYear}</li>
    <li class="list-group-item">전용면적: ${deal.area} </li>
    <li class="list-group-item">거래일: ${deal.dealYear}년 ${deal.dealMonth}월 ${deal.dealDay}일 </li>
    <li class="list-group-item">법정동: ${deal.dong} </li>
    <li class="list-group-item">지번: ${deal.jibun}</li>
  </ul>
</div>




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