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

    <div class="container-fluid">
       <h3 class="mt-4">추천 결과</h3>
		<p>Knapsack 알고리즘을 이용해 추천된 조합은 다음과 같습니다.</p>
		<p>총 금액: ${totalMoney}</p>
		<p>총 면적: ${totalArea}</p>


	<!-- 결과 테이블 -->
	
                <div class="card mb-4">
                   <div class="card-header"><i class="fas fa-table mr-1"></i>추천 결과</div>
                   <div class="card-body">
                       <div class="table-responsive">
                           <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                               <thead>
                                   <tr>
                                       <th>거래 번호</th>
                                       <th>법정동</th>
                                       <th>아파트 이름</th>
                                       <th>거래 금액</th>
                                       <th>거래 종류</th>
                                   </tr>
                               </thead>
                               <tbody>
                               
			<c:forEach items="${deals}" var="deal">
				<tr>
					<td>${deal.no}</td>
					<td>${deal.dong}</td>
					<td><a href="${root}/dealdetail?no=${deal.no}">${deal.aptName}</a></td>
					<td>${deal.dealAmount}</td>
					<td>${deal.type}</td>
				</tr>
			</c:forEach>

                               </tbody>
                           </table>
                       </div>
                   </div>
               </div>

	</div>
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