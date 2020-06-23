<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand">Happy House</a><button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button
            ><!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
                <div class="input-group">

                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ml-auto ml-md-0">
                     <c:if test="${!empty userinfo}">
                        <div class="small" style="color:#E2E2E2; font-weight: bold;font-style: italic; font-size: 18px">
                        ${userinfo.name}(${userinfo.id})님 로그인<!-- 이 부분에 세션에서 받아온 아이디랑 닉네임 넣기 -->
                    	</div>
                    </c:if>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                              <a class="dropdown-item" href="${root}/logout">Logout</a>
                           
                    </div>
                </li>
            </ul>
        </nav>
        
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-light" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        
                        <c:if test="${!empty userinfo}">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Menu</div>
                            <a class="nav-link" href="${root}/main"
                                ><div class="sb-nav-link-icon"><i class="fas fa-meh"></i></div>
                                	메인 화면</a
                            >
                            <a class="nav-link" href="${root}/deallist"
                                ><div class="sb-nav-link-icon"><i class="fas fa-home"></i></div>
                                	거래 정보</a
                            >
                            <a class="nav-link" href="${root}/mypage"
                                ><div class="sb-nav-link-icon"><i class="fas fa-user-friends"></i></div>
                                	마이페이지</a
                            >
                            <a class="nav-link" href="${root}/comparehistory"
                                ><div class="sb-nav-link-icon"><i class="fas fa-user-circle"></i></div>
                                	거래내역 비교기록</a
                            >
                            <a class="nav-link" href="${root}/vueqna"
                                ><div class="sb-nav-link-icon"><i class="fas fa-user-circle"></i></div>
                                	QnA 게시판 : Vue </a
                            >
                        </div>
                        </c:if>
                        
                    </div>
                <!--     <div class="sb-sidenav-footer"></div> -->                                       
                </nav>
 
            </div>        
