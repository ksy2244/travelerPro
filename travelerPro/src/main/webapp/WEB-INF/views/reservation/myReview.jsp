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
<link rel="import" href="map.html">
<style type="text/css">
.body-container {
	max-width: 1500px;
}

.body-main {
	max-width: 1000px;
	margin-left: 150px;
}

.body-title {
	margin-top: 20px;
	margin-bottom: 40px;
}

.list {
	border: 1px solid #ccc;
	border-radius: 8px;
}

.date {
	font-size: 21px;
	font-weight: bold;
}

.gap {
	margin-bottom: 100px;
}

.body {
	margin-left: 200px;
}

.company {
	font-weight: bold;
	font-size: 20px;
}

.rnum {
	color: #787878;
	font-size: 15px;
}

.room {
	color: #787878;
	font-size: 16px;
}

.day {
	color: #787878;
	font-size: 15px;
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
					<h3>나의 작성 리뷰</h3>
				</div>

			<div class="body-main"> 
					<div class="row"> 
						 <c:forEach var="dto" items="${list}" varStatus="status">
							<div class="list">							
								<h5 class="card-title date pt-4 ps-5">${dto.reg_date}</h5>
								<hr class="pt-2">
								<div class="rnum ps-5">숙소 예약번호 ${dto.reservationNum}</div>

								<div class="body ps-5">
									<div class="company">${dto.companyName}</div>
									<div class="room">${dto.roomName}</div>
									<div class="day">${dto.startDate}~ ${dto.endDate}</div>
									<div>평점 ${dto.starRate}</div>
									<div>리뷰 내용 ${dto.content}</div>
									<div>리뷰 내용 ${dto.reg_date}</div>
									<br>
	
								</div>
							</div>
							<div class="gap"></div>
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