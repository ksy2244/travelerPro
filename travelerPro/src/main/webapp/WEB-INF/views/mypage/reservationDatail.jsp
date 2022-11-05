<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 소연 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TRAVELER</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title2.png" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/reservation/reservationStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/traveler/travelerStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/traveler/datePicker.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/traveler/review.css"
	type="text/css">

<style type="text/css">
.card {
	border: 1px solid #eee;
}

.name {
	font-weight: bold;
	font-size: 30px;
	color: black;
}

.shadowBox {
	padding: 40px;
	margin-left: 100px;
	margin-top: 0px;
}

.font {
	font-size: 20px;
	font-weight: 600;
}

.reservationContent {
	font-size: 17px;
}

.rightContent {
	float: right;
	font-size: 20px;
	font-weight: 600;
}

.couponContent {
	color: gray;
	font-size: 17px;
}

.priceContent {
	float: right;
	font-size: 40px;
	font-weight: 600;
}

.back {
	font-size: 30px;
	font-weight: 600;
}
</style>
</head>
<body class="pt-5">
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<div class="container mt-5">
		<div class="body-container">
			<div class="body-title">
				<div class="shadowBox" style="width: 1100px; height: 900px;">
					<p class="back">
						<a
							href="${pageContext.request.contextPath}/mypage/myReservation.do?">
							<i class="fa-sharp fa-solid fa-chevron-left"></i>&nbsp;&nbsp;예약
							내역 상세
						</a>
					</p>
					<hr>
					<a class="btn gray font pb-3" data-bs-toggle="collapse"
						href="#collapseExample" role="button" aria-expanded="false"
						aria-controls="collapseExample"><span class="ok"><i
							class="fa-sharp fa-solid fa-chevron-down"></i>&nbsp;예약자 정보</span> </a>


					<div class="collapse" id="collapseExample">
						<p class="reservationContent">
							이름 <span class="rightContent">${dto.userName}</span>
						</p>
						<p class="reservationContent">
							휴대폰 번호 <span class="rightContent"> ${dto.tel}</span>
						</p>

					</div>







					<br> <br>
					<div>
						<p class="font pb-3">이용자 정보</p>
						<p class="reservationContent">
							이름 <span class="rightContent">${dto.realUserName}</span>
						</p>
						<p class="reservationContent">
							휴대폰 번호 <span class="rightContent"> ${dto.realUserTel}</span>
						</p>
					</div>
					<hr>
					<br>
					<div>
						<p class="font pb-3">금액 및 할인 정보</p>
						<p class="reservationContent">
							예약 금액 <span class="rightContent">${dto.totalPrice}원</span>
						</p>
						<p class="reservationContent">
							총 할인 금액 <span class="rightContent">-${dto.sales}원</span>
						</p>
						<p class="couponContent">${dto.couponName}
							~(${dto.end_date}까지)
							<c:choose>
								<c:when test="${dto.discountRate == 0 }">
									<span class="rightContent"> ${dto.couponPrice}원</span>
								</c:when>
								<c:otherwise>
									<span class="rightContent"> ${dto.discountRate}%</span>
								</c:otherwise>
							</c:choose>
						</p>
					</div>
					<hr>
					<br>
					<div>
						<p class="reservationContent">
							결제 금액 <span class="priceContent">${dto.paymentPrice}원</span>
						</p>
						<br>
						<p class="reservationContent">
							결제 수단 <span class="rightContent">KG이니시스</span>
						</p>
					</div>

				</div>
			</div>
		</div>
	</div>



	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>