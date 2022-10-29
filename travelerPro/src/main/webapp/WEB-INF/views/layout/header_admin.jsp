<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
@import url('https://webfontworld.github.io/gmarket/GmarketSans.css');

.menubar {
	background-color: #343a40;
	border: 30px solid #343a40;
}

.traveler {
	font-family: 'GmarketSans'; 
	font-size: 50px; 
	margin-left: 300px; 
	letter-spacing: 7px;
}

.navContainer {
	display: grid;
	line-height: 1.0;
	margin-left: 20px;
	float: right;
}

</style>

<nav class="navbar navbar-expand-lg justify-content-end menubar">
  <div class="container-fluid">
    <a class="navbar-brand text-white traveler" href="${pageContext.request.contextPath}/admin/main.do"><i class="fa-regular fa-handshake">TRAVELER</i></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent" style="margin-right: 100px;">
      <div class="navContainer" style="margin-right:10px;">
      <ul class="navbar-nav mb-2 mb-lg-0">
	        <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
	           style="font-family: 'GmarketSans'; font-size: 25px; margin-right: 20px; margin-top: 8px;" title="정보 관리">
	            정보 관리
	          </a>
	          <ul class="dropdown-menu">
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/userList.do" style="font-family: 'GmarketSans';" title="회원 정보">회원 정보 확인</a></li>
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/companyList.do" style="font-family: 'GmarketSans';" title="업체 정보">업체 정보 확인</a></li>
	          </ul>
	        </li>
	        
	        <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
	           style="font-family: 'GmarketSans'; font-size: 25px; margin-right: 20px; margin-top: 8px;" title="문의 관리">
	            문의 관리 
	          </a>
	          <ul class="dropdown-menu">
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/answer/faq.do" style="font-family: 'GmarketSans';" title="FAQ" >자주 묻는 질문 FAQ</a></li>
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/answer/qnaList.do" style="font-family: 'GmarketSans';" title="Q&A">1:1 문의</a></li>
	          </ul>
	        </li>
	        
      		<li class="nav-item text-white">
	          	<a class="nav-link text-white" href="${pageContext.request.contextPath}/notice/list.do" title="공지 관리"
	          		style="font-family: 'GmarketSans'; font-size: 25px; margin-top: 6px; margin-right: 20px;">공지 관리</a>
	        </li>
	      	<li class="nav-item text-white">
	          	<a class="nav-link text-white" href="${pageContext.request.contextPath}/coupon/list.do" title="쿠폰 관리" 
	          		style="font-family: 'GmarketSans'; font-size: 25px; margin-top: 6px; margin-right: 20px;">쿠폰 관리</a>
	        </li>
    	</ul>
    	</div>
    </div>
  </div>
</nav>