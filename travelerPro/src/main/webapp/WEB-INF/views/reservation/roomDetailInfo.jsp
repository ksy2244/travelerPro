<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Traveler</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<title>traveler</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<link rel="stylesheet"
	href="../resources/style/reservation/reservationStyle.css"
	type="text/css">
<link rel="import" href="map.html">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>


	<main>

		<div id="carouselExampleCaptions" class="carousel carousel-dark slide"
			data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner" data-bs-interval="100"
				style="text-align: right; font-family: 'GmarketSans'">
				<div class="carousel-item active">
					<img class="roomImg"
						src="${pageContext.request.contextPath}/resources/images/mainImg/bokcheon.png"
						class="d-block w-100 bestRegion" alt="...">
					<div class="carousel-caption d-none d-md-block"></div>
				</div>
				<div class="carousel-item">
					<img class="roomImg"
						src="${pageContext.request.contextPath}/resources/images/mainImg/busan.png"
						class="d-block w-100 bestRegion" alt="...">
					<div class="carousel-caption d-none d-md-block"></div>
				</div>
				<div class="carousel-item">
					<img class="roomImg"
						src="${pageContext.request.contextPath}/resources/images/mainImg/bokcheon.png"
						class="d-block w-100 bestRegion" alt="...">
					<div class="carousel-caption d-none d-md-block"></div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
	</main>

<br>
<br>
	<div class="card" style="width: 1485px; margin: auto">
		<div class="card-body">
			<div class="roomDetailInfo" style="float: center">
				<p class="roomInfoTitle">
					&nbsp; <i class="fa-sharp fa-solid fa-door-closed"></i> &nbsp;객실 정보
				</p>
				<hr>
				<p class="eachRoomName">${dto.roomName}</p>
				<p class="eachRoomInfo">주차불가, ROOM UPGRADE 가능!!!</p>
				<p class="roomInfoContent">
					<span style="background-color: #eee; text-align: center">인원
					</span>기준 2인 / 최대 2인
				</p>
				<p class="roomInfoContent">
					<span style="background-color: #eee; text-align: center">체크인
					</span>체크인 시간 
				</p>
				<p class="roomInfoContent">
					<span style="background-color: #eee; text-align: center">체크아웃
					</span>체크아웃 시간 
				</p>


				<!-- <p class="eachRoomMoney">
					<span style="color: purple">10% &nbsp;</span>100,000원
				</p> -->
				
					<button type="button" class="reservationBtn"
						style ="float:right"
						class="btn btn-primary" data-bs-toggle="modal"
						data-bs-target="#exampleModal1">객실 예약</button>
				

			</div>
		</div>

	</div>

	<div class="card" style="width: 1485px; margin: auto">
		<div class="card-body">
			<div class="roomDetailInfo" style="float: center">
				<p class="roomInfoTitle">
					&nbsp; <i class="fa-regular fa-note-sticky"></i>&nbsp;기본 정보
				</p>

				<hr>
				<p class="roomInfoContent">각 객실에 대한 예약 공지</p>


			</div>
		</div>
	</div>

	<div class="card" style="width: 1485px; margin: auto">
		<div class="card-body">
			<div class="roomDetailInfo" style="float: center">
				<p class="roomInfoTitle">
					&nbsp; <i class="fa-solid fa-calendar"></i>&nbsp;예약 공지
				</p>
				<hr>

				<p class="roomInfoContent">각 객실에 대한 예약 공지</p>

			</div>
		</div>
	</div>


	<!-- 숙소 입력 확인 모달 -->
	<div class="modal fade" id="exampleModal1" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel"
						style="text-align: center; font-Size: 60px; font-Size: 500; font-weight: 500">숙소
						예약</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p
						style="font-Size: 23px; font-weight: 400; text-align: center; background: #eee">체크인
						2022.10.19(수) ~ 체크아웃 2022.10.20(목)</p>
					<p class="eachRoomMoney">80,000원</p>
					<p class="paymentRule"
						style="font-weight: 400; font-Size: 20px; float: bottom">취소 및
						환불 불가</p>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						style="background: purple"
						onclick="location.href='${pageContext.request.contextPath}/reservation/reservation.do'">숙소
						예매</button>
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