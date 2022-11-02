<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<title>TRAVELER</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/reservation/reservationStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/traveler/travelerStyle.css"
	type="text/css">
<link rel="import" href="map.html">

<style type="text/css">
.img {
	padding-top: 20px;
	padding-left: 20px;
	width: 300px;
	height: 300px;
	border-radius: 10px;
}

.card {
	border: none;
}

.company {
	font-weight: bold;
	font-size: 17px;
	margin-left: 20px;
}

.png {
	width: 15px;
}

.star {
	color: #FFBB00;
	margin-left: 20px;
}

.bold {
	color: black;
	font-weight: 600;
}

.price {
	padding-left: 210px;
	color: #787878;
}

.realprice {
	color: black;
	font-weight: bold;
	font-size: 20px;
	padding-left: 175px;
	float: left;
}

.realpriceMin {
	color: black;
	font-weight: bold;
	font-size: 20px;
	padding-left: 187px;
	float: left;
}

.won {
	color: black;
	font-weight: bold;
	font-size: 20px;
	margin-right: 20px;
}

.paging {
	font-weight: bold; 
	font-size: 18px;
}

</style>
</head>
<body class="pt-5">
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="pt-5">
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3>예약</h3>
				</div>

				<div class="body-main">
					<div class="row board-list-header">
						<div class="col-auto me-auto">
					
						</div>
					</div>
					<div class="row">
						<c:forEach var="dto" items="${list}" varStatus="status">
							<div class="col-md-4 col-lg-3 p-1"> 
								<div class="card-group" style="width: 1500px; margin: auto;">
									<div class="card" style="margin: 10px;"
										onclick="location.href='${articleUrl}&companyNum=${dto.companyNum}'">
										<img
											src="${pageContext.request.contextPath}/uploads/ceo/${dto.imageFileName}"
											class="card-img-top img">
										<div class="card-body">
											<div class="card-title company">${dto.companyName}</div>
											<c:choose>
												<c:when test="${dto.starRate > 4.5}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 4.0}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 3.5}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 3.0}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 2.5}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 2.0}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 1.5}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 1.0}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 0.5}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 0}">
													<span class="star"><i class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:otherwise>
													<span class="star"><i class="fa-regular fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:otherwise>
											</c:choose>
											<div class="price pt-4 pb-1">1박 기준</div>
											<c:if test="${dto.minPrice < 100000 }">
												<div class="card-title realpriceMin">${dto.minPrice}</div><span class="won">원</span>
											</c:if>
											<c:if test="${dto.minPrice >= 100000 }">
												<div class="card-title realprice">${dto.minPrice}</div><span class="won">원</span>
											</c:if>
										</div>
									</div>
								</div>

							</div>
						</c:forEach>
					</div>

					<div class="page-navigation paging">
						${dataCount == 0 ? "등록된 업체가 없습니다." : paging}
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