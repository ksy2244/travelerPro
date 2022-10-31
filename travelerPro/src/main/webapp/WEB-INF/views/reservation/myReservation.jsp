<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<title>traveler</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/reservation/reservationStyle.css"
	type="text/css">
<link rel="import" href="map.html">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<i class="fa-solid fa-hotel"></i>&nbsp; 숙박 업체 리스트
				</div>

				<div class="body-main">
					<div class="row">
						<c:forEach var="dto" items="${list}" varStatus="status">
							<div>
								<img
									src="${pageContext.request.contextPath}/uploads/ceo/${dto.imageFileName}"
									class="card-img-top">
								<div class="card-body">
									<h4 class="card-title">${dto.userName}님의이용정보</h4>
									<h4 class="card-title">${dto.companyName}</h4>
									<h4 class="card-title">${dto.roomName}</h4>
									<h5 class="card-title">${dto.paymentPrice}</h5>
									<h5 class="card-title">${dto.checkInTime}</h5>
									<h5 class="card-title">${dto.start_date}</h5>
									<h5 class="card-title">${dto.checkOutTime}</h5>
									<h5 class="card-title">${dto.end_date}</h5>
									<h5 class="card-title">${dto.reservation_date}</h5>
									<button type="button" name="sendButton"
										class="dateBtn btn btn-danger"
										onclick="location.href='${pageContext.request.contextPath}/reservation/review.do">아직 연결 못해 ㅠ </button>
								</div>
							</div>

						</c:forEach>
					</div>


				</div>
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />




</body>
</html>