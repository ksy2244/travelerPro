<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.footer {
	background: #F6F6F6;
	color: #A6A6A6;
	margin-top: 200px;
	width: 100%;
	height: 450px;
	z-index: 1;
}

.nav-next {
	margin-left: 450px;
	padding-top: 30px;
}

.gap {
	margin-bottom: 10px;
}

.width {
	margin-left: 450px;
	width: 1200px;
}

.nav-icon {
	margin-left: 450px;
	padding-top: 10px;
}

.left {
	margin-left: 1100px;
}

</style>
<footer class="navbar-fixed-bottom" style="border-top: 1px soild #EAEAEA;">
<div class="footer">
	<br><br>
    <ul class="nav nav-next">
        <li class="nav-item"><a class="text-reset" href="#">TRAVELER 회사소개</a></li>
        <li class="nav-item"><span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span></li>
        <li class="nav-item"><a class="text-reset" href="#">서비스 이용약관</a></li>
        <li class="nav-item"><span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span></li>
        <li class="nav-item"><a class="text-reset" href="#">개인정보처리방침</a></li>
        <li class="nav-item"><span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span></li>
        <li class="nav-item"><a class="text-reset" href="#">전자금융거래 이용약관</a></li>
        <li class="nav-item"><span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span></li>
        <li class="nav-item"><a class="text-reset" href="#">전자금융거래 이용자 유의사항</a></li>
   </ul>
   <ul class="nav nav-next">
   		<li class="nav-item">고객센터&nbsp;&nbsp;1670-1670</li>
   </ul>
   <ul class="nav nav-next">
   		<li class="nav-item">
   		© TRAVELER Corp.
   		<div class="gap"></div>
		주소 : 서울특별시 마포구 서교동 447-5, 풍성빌딩 2층 &nbsp;|&nbsp; 대표이사 : 김소연 &nbsp;|&nbsp; 사업자등록번호: 000-00-00000<br>
		통신판매번호 : 2022-서울마포-01779 &nbsp;|&nbsp; 관광사업자 등록번호: 제1026-24호 &nbsp;|&nbsp; 전화번호 : 1670-0761 &nbsp;|&nbsp; 전자우편주소 : help@traveler.com<div class="gap"></div>
		(주) TRAVELER은 통신판매중개자로서 통신판매의 당사자가 아니며, 상품의 예약, 이용 및 환불 등과 관련한 의무와 책임은 각 판매자에게 있습니다.</li>
   </ul>
   <ul class="nav nav-next">
   		<li class="nav-item">Copyright GC COMPANY Corp. All rights reserved.</li>
   </ul>
   <br>
   <hr class="width">
   <ul class="nav nav-icon">
   		<li class="nav-item"><i class="fa-brands fa-instagram fa-2x"></i></li>
   		<li class="nav-item">&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-brands fa-facebook fa-2x"></i></li>
   		<li><span class="left"></span></li>
   		<c:if test="${sessionScope.member.userRoll == 1 }">
	        <li class="nav-item"><a class="text-reset" href="${pageContext.request.contextPath}/ceo/main.do"><i class="fa-solid fa-house-user fa-2x"></i></a></li>
        </c:if>
        <c:if test="${sessionScope.member.userRoll == 99 }">
	        <li class="nav-item"><a class="text-reset" href="${pageContext.request.contextPath}/admin/main.do"><i class="fa-solid fa-user-secret fa-2x"></i></a></li>
        </c:if>
   </ul>
</div>
</footer>