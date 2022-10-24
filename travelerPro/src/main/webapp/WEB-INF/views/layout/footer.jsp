<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.footer {
	color: gray;
	margin-top: 200px;
}

</style>
<div class="container-fluid footer">
    <ul class="nav justify-content-center p-3">
        <li class="nav-item"><a class="text-reset" href="#">TRAVELER 회사소개</a></li>
        <li class="nav-item"><span>&nbsp;&middot;&nbsp;</span></li>
        <li class="nav-item"><a class="text-reset" href="#">이용약관</a></li>
        <li class="nav-item"><span>&nbsp;&middot;&nbsp;</span></li>
        <li class="nav-item"><a class="text-reset" href="#">개인정보처리방침</a></li>
        <li class="nav-item"><span>&nbsp;&middot;&nbsp;</span></li>
        <li class="nav-item"><a class="text-reset" href="#">소비자 분쟁해결 기준</a></li>
        <li class="nav-item"><span>&nbsp;&middot;&nbsp;</span></li>
        <li class="nav-item"><a class="text-reset" href="#">개인정보취급방침</a></li>
        <c:if test="${sessionScope.member.userRoll == 1 }">
	        <li class="nav-item"><span>&nbsp;&middot;&nbsp;</span></li>
	        <li class="nav-item"><a class="text-reset" href="${pageContext.request.contextPath}/ceo/main.do">숙박업체</a></li>
        </c:if>
        <li class="nav-item"><span>&nbsp;&nbsp;© TRAVELER Corp.</span></li>
    </ul>
    <br>
</div>
