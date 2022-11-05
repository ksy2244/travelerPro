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
<style type="text/css">
.body-contain {
	width: 100%;
	height: 200px;
}

.img {
	width: 200px !important;
	height: 230px !important;
	margin-left: 100px;
}

div card {
	/* margin-left: 100px; */
	margin: auto;
	display: block;
}

.card {
	border: none;
	width: 200px;
	height: 500px;
}

.card-body {
	width: 100%;
	height: 200px;
}

.btnc {
	margin-right: 100px;
	margin-bottom: 100px;
}

.company {
	font-weight: bold;
	font-size: 17px;
	margin-left: 100px;
}

.png {
	width: 18px;
	margin-left: 22px;
}

.pick {
	color: #787878;
	margin-left: 80px;
	margin-top:35px;
	
}

.review {
	color: #787878;
	margin-left: 80px;
}

.star {
	color: #FFBB00;
	float: left;
	margin-left: 100px;
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
	font-size: 10px;
	padding-left: 150px;
	float: left;
}

.won {
	color: black;
	font-weight: bold;
	font-size: 10px;
	margin-right: 20px;
}

.paging {
	font-weight: bold;
	font-size: 18px;
}

.company2 {
	font-size: 20px;
	margin-top: 30px;
	margin-left: 30px;
	font-weight: bold;
	margin-bottom: 50px;
}

.region {
	color: #5CD1E5;
	font-size: 25px;
}

.card {
	height: 400px;
}

</style>

</head>
<body class="pt-5">
	<div class="container">
		<div class="body-contain">
			<div class="company2">
				<span class="region">${region}</span> 지역 숙소
			</div>
			<div class="body-main">
				<div class="row row-cols-auto">
					<c:forEach var="dto" items="${list}" varStatus="status" begin="1"
						end="3">
						<div class="row row-cols-1 row-cols-md-3 g-4">
							<div class="card-group"
								style="width: 300px; height: 300px; margin: auto;">
								<div class="card"
									style="width: 250px; height: 350px; margin: 10px;"
									onclick="location.href='${pageContext.request.contextPath}/reservation/roomInfo.do?companyNum=${dto.companyNum}'">
									<img
										src="${pageContext.request.contextPath}/uploads/ceo/${dto.imageFileName}"
										class="img">
									<div class="card-body">
										<div class="card-title company">${dto.companyName}</div>
										<c:choose>
											<c:when test="${dto.starRate > 4.5}">
												<span class="star"><i class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (${dto.reviewCount})
														</span></span>
											</c:when>
											<c:when test="${dto.starRate > 4.0}">
												<span class="star"><i class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span
													class="bold">${dto.starRate} (${dto.reviewCount})</span></span>
											</c:when>
											<c:when test="${dto.starRate > 3.5}">
												<span class="star"><i class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (${dto.reviewCount})</span></span>
											</c:when>
											<c:when test="${dto.starRate > 3.0}">
												<span class="star"><i class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span
													class="bold">${dto.starRate} (${dto.reviewCount})</span></span>
											</c:when>
											<c:when test="${dto.starRate > 2.5}">
												<span class="star"><i class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate}
														${dto.reviewCount} (${dto.reviewCount})</span></span>
											</c:when>
											<c:when test="${dto.starRate > 2.0}">
												<span class="star"><i class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span
													class="bold">${dto.starRate} (${dto.reviewCount})</span></span>
											</c:when>
											<c:when test="${dto.starRate > 1.5}">
												<span class="star"><i class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (${dto.reviewCount})
												</span></span>
											</c:when>
											<c:when test="${dto.starRate > 1.0}">
												<span class="star"><i class="fa-solid fa-star fa-lg"></i><i
													class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span
													class="bold">${dto.starRate} (${dto.reviewCount})</span></span>
											</c:when>
											<c:when test="${dto.starRate > 0.5}">
												<span class="star"><i class="fa-solid fa-star fa-lg"></i>&nbsp;<span
													class="bold">${dto.starRate} (${dto.reviewCount})</span></span>
											</c:when>
											<c:when test="${dto.starRate > 0}">
												<span class="star"><i
													class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span
													class="bold">${dto.starRate} (${dto.reviewCount})</span></span>
											</c:when>
											<c:otherwise>
												<span class="star"><i
													class="fa-regular fa-star fa-lg"></i>&nbsp;<span
													class="bold">${dto.starRate} (${dto.reviewCount})</span></span>
											</c:otherwise>
										</c:choose>
										<div class="pick">
											<img
												src="${pageContext.request.contextPath}/resources/images/icon/pick.png"
												class="png">&nbsp;<span class="pick-text">${dto.pick}</span>
										</div>
										
									</div>
								</div>
							</div>
						</div>
					</c:forEach>


				</div>
				<button type="button" class="btn bg-danger text-white btnc"
					style="width: 900px; margin-left: 70px; margin-top: 90px;"
					onclick="location.href='${pageContext.request.contextPath}/reservation/companyList.do';">더
					많은 숙소보기</button>

			</div>

		</div>

	</div>

</body>
</html>