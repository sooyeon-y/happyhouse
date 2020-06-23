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
                        <h2 class="mt-4">Happy House: 행복한 우리 집 </h2>
                        
                        
                        <article>
						<h4>어서와 이런 집은 처음이지? 당신이 살 집을 한번에 찾아줄 플랫폼!</h4>	
						<br>
						<ul>
						<img class="card" src="img/house.jpg"style="witdh:900px;height:500px" alt="image"> 
				
						</ul>
						</article>                      

                        <div class="card mb-4">
                            <div class="card-header"><i class="fas fa-table mr-1"></i>공지사항</div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>No.</th>
                                                <th>제목</th>
                                                <th>작성자</th>
                                                <th>작성일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        
                                        <c:forEach items="${noticeList}" var="notice">
										<tr>
											<th scope="row">${notice.num}</th>
											<td><a href="${root}/noticedetail?no=${notice.num}">${notice.title}</a></td> 
											<td>${notice.userId}</td>
											<td>${notice.writeDate}</td>
										</tr>	
										</c:forEach>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                                                                                            
                    <c:if test="${userinfo.isAdmin == true}">
					<h3 class="mt-4">관리자 전용 기능</h3>
					 <button type="button" class="btn btn-primary" onClick="location.href='${root}/noticewritepage'">공지사항 작성</button>
					 <button type="button" class="btn btn-success" onClick="location.href='${root}/userlist'">전체 회원정보 조회</button>
					<br>
					</c:if>
                        
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">SSAFY 3기 8반 윤수연, 김수민</div>
                            <div class="text-muted">Template by <a href="https://startbootstrap.com/templates/sb-admin/">startbootstrap</a></div>
                        </div>
                    </div>
                </footer>
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
