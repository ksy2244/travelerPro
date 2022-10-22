<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
@import url('https://webfontworld.github.io/gmarket/GmarketSans.css');

</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/menubar.css" type="text/css">

<nav>
   <ul class="menu">
      <li><a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/notice/list.do" title="공지관리">공지관리</a></li>
      <li><a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/coupon/list.do" title="쿠폰관리">쿠폰관리</a></li>
      <li><a href="${pageContext.request.contextPath}/ceo/paylist.do"></a></li>
      <li><a href="${pageContext.request.contextPath}/ceo/reservation.do"></a></li>
      <li><a href="${pageContext.request.contextPath}/ceo/room.do"></a></li>
   </ul>
</nav>

<nav class="navbar navbar-expand-lg justify-content-end" style=" background: #3C2317; border: 30px solid #3C2317">
  <div class="container-fluid">
    <a class="navbar-brand text-white" href="${pageContext.request.contextPath}/admin/main.do" style="font-family: 'GmarketSans'; font-size: 50px; margin-left: 300px;"><i class="fa-regular fa-handshake">TRAVELER</i></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasDarkNavbar" aria-controls="offcanvasDarkNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    
  </div>
</nav>