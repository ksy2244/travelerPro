<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
@import url('https://webfontworld.github.io/gmarket/GmarketSans.css');

</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/menubar.css" type="text/css">

<nav class="navbar navbar-expand-lg justify-content-end" style=" background: #3C2317; border: 30px solid #3C2317">
  <div class="container-fluid">
    <a class="navbar-brand text-white" href="${pageContext.request.contextPath}/admin/main.do" style="font-family: 'GmarketSans'; font-size: 50px; margin-left: 300px;"><i class="fa-regular fa-handshake">TRAVELER</i></a>
    <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent" style="margin-right: 350px;">
      <ul class="navbar-nav mb-2 mb-lg-0">
	        <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle fw-semibold text-white" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
	           style="font-family: 'GmarketSans'; font-size: 25px; margin-right: 20px;">
	            정보 관리
	          </a>
	          <ul class="dropdown-menu">
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/userList.do" style="font-family: 'GmarketSans';">회원 정보 확인</a></li>
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/companyList.do" style="font-family: 'GmarketSans';">업체 정보 확인</a></li>
	          </ul>
	        </li>
	        
	        <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle fw-semibold text-white" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
	           style="font-family: 'GmarketSans'; font-size: 25px; margin-right: 20px;">
	            문의 관리
	          </a>
	          <ul class="dropdown-menu">
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/faq/tab.do" style="font-family: 'GmarketSans';">자주 묻는 질문 FAQ</a></li>
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/qna/list.do" style="font-family: 'GmarketSans';">1:1 문의</a></li>
	          </ul>
	        </li>
	      	
	      	<li class="nav-item fw-semibold text-white">
	          	<a class="nav-link fw-semibold text-white" href="${pageContext.request.contextPath}/notice/list.do" title="공지 관리"
	          		style="font-family: 'GmarketSans'; font-size: 25px; margin-top: 6px; margin-right: 20px;">공지 관리</a>
	        </li>
	      	<li class="nav-item fw-semibold text-white">
	          	<a class="nav-link fw-semibold text-white" href="${pageContext.request.contextPath}/coupon/list.do" title="쿠폰 관리" 
	          		style="font-family: 'GmarketSans'; font-size: 25px; margin-top: 6px; margin-right: 20px;">쿠폰 관리</a>
	        </li>
    	</ul>
    </div>
  </div>
</nav>