<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>traveler</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3>${title}</h3>
				</div>

				<div class="container">
					<div class="body-container">
						<div class="body-title">

							<c:forEach var="dto" items="${list}" varStatus="status">
								<div class="card border-secondary mb-3"
									style="max-width: 100rem;">

									<div class="card-body">
										<div class="roomDetailInfo" style="float: center">
											<p class="roomInfoTitle">
												&nbsp; <i class="fa-sharp fa-solid fa-door-closed"></i>
												&nbsp;객실 정보
											</p>
											<hr>
											<p class="eachRoomName">${dto.companyName}&nbsp;${dto.roomName}</p>
											<p class="address">
												<i class="fa-solid fa-location-dot"></i>&nbsp;${dto.addr}&nbsp;${dto.addrDetail}
											</p>

											<p class="eachRoomInfo">${dto.roomInfo}</p>
										</div>

									</div>
								</div>

								<br>

								<div class="card border-secondary mb-3"
									style="max-width: 100rem;">

									<div class="card-body">
										<div class="roomDetailInfo" style="float: center">
											<p class="roomInfoTitle">
												&nbsp; <i class="fa-regular fa-note-sticky"></i>&nbsp;서비스
											</p>

											<hr>
											<p class="roomInfoContent">${dto.amenities}</p>


										</div>
									</div>
								</div>

								<br>


								<div class="card border-secondary mb-3"
									style="max-width: 100rem;">

									<div class="card-body">
										<div class="roomDetailInfo" style="float: center">
											<p class="roomInfoTitle">
												&nbsp; <i class="fa-solid fa-calendar"></i>&nbsp;예약 공지
											</p>
											<hr>
											<p class="roomInfoContent">
												<span style="background-color: #eee; text-align: center">인원
												</span>기준 ${dto.headCount}인 / 최대 ${dto.headCount}인
											</p>

											<p class="roomInfoContent">
												<span style="background-color: #eee; text-align: center">체크인
												</span> ${roomDto.start_date} ${dto.checkInTime}
											</p>
											<p class="roomInfoContent">
												<span style="background-color: #eee; text-align: center">체크아웃
												</span> ${roomDto.end_date} ${dto.checkOutTime}
											</p>

											<p class="roomInfoContent">각 객실에 대한 예약 공지</p>

											<input type="hidden" name="headCount">${dto.headCount}
										</div>
									</div>
								</div>
								<br>
								<div style="width: 1500px">
									<button type="button" class="reservationBtn"
										style="float: right;" btn btn-primary" data-bs-toggle="modal"
										data-bs-target="#exampleModal1">객실 예약</button>
								</div>

							</c:forEach>

							<div class="card border-secondary mb-3"
								style="max-width: 100rem;">
								<div class="card-header">
									<h5>
										<i class="fa-solid fa-user"></i>&nbsp;이용자 정보&nbsp;
									</h5>
								</div>
								<div class="card-body text-secondary">
									<h5 class="card-title">이름</h5>
									<p class="card-text">
									<p>이용자 휴대폰 번호</p>
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





