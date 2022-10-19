<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
					<img
						src="${pageContext.request.contextPath}/resources/images/reservationImg/no.png"
						class="d-block w-100 bestRegion" alt="...">
					<div class="carousel-caption d-none d-md-block"></div>
				</div>
				<div class="carousel-item">
					<img
						src="${pageContext.request.contextPath}/resources/images/reservationImg/no.png"
						class="d-block w-100 bestRegion" alt="...">
					<div class="carousel-caption d-none d-md-block"></div>
				</div>
				<div class="carousel-item">
					<img
						src="${pageContext.request.contextPath}/resources/images/reservationImg/no.png"
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



	<div class="item">
		<div class="grid">
			<img class="eachRoom" style="float: left"
				src="${pageContext.request.contextPath}/resources/images/reservationImg/no.png">
			<div class="roomDetailInfo ">
				<p class="eachRoomName">스탠다드</p>
				<p class="eachRoomInfo">주차불가, ROOM UPGRADE 가능!!!</p>
				<p class="headCount">기준 2인 / 최대 2인</p>
				<p class="eachRoomMoney">
					<span style="color: purple">10% &nbsp;</span>100,000원
				</p>
				<!-- <p class="paymentRule">취소 및 환불 불가~</p> -->
				<button class="reservationBtn">객실 예약</button>

			</div>



		</div>

	</div>

	<div class="item">
		<div class="grid">
			<img class="eachRoom" style="float: left"
				src="${pageContext.request.contextPath}/resources/images/reservationImg/no.png">
			<div class="roomDetailInfo ">
				<p class="eachRoomName">스탠다드</p>
				<p class="eachRoomInfo">주차불가, ROOM UPGRADE 가능!!!</p>
				<p class="headCount">기준 2인 / 최대 2인</p>
				<p class="eachRoomMoney">
					<span style="color: purple">10% &nbsp;</span>100,000원
				</p>
				<!-- <p class="paymentRule">취소 및 환불 불가~</p> -->
				<button class="reservationBtn">객실 예약</button>

			</div>



		</div>

	</div>

	<div class="item">
		<div class="grid">
			<img class="eachRoom" style="float: left"
				src="${pageContext.request.contextPath}/resources/images/reservationImg/no.png">
			<div class="roomDetailInfo ">
				<p class="eachRoomName">스탠다드</p>
				<p class="eachRoomInfo">주차불가, ROOM UPGRADE 가능!!!</p>
				<p class="headCount">기준 2인 / 최대 2인</p>
				<p class="eachRoomMoney">
					<span style="color: purple">10% &nbsp;</span>100,000원
				</p>
				<!-- <p class="paymentRule">취소 및 환불 불가~</p> -->
				<button type ="button" class="reservationBtn"  class="btn btn-primary"
					data-bs-toggle="modal" data-bs-target="#exampleModal1">객실 예약</button>



			</div>



		</div>

	</div>


	<!-- 숙소 입력 확인 모달 -->
	<div class="modal fade" id="exampleModal1" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel" style = "text-align:center; font-Size:60px; font-Size:500; font-weight:500">숙소 예약</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
				<p style ="font-Size:23px; font-weight: 400; text-align:center; background: #eee" >체크인 2022.10.19(수) ~ 체크아웃 2022.10.20(목) </p>
				<p class = "eachRoomMoney">80,000원 </p>
				<p class ="paymentRule" style= "font-weight: 400; font-Size:20px; float:bottom";>취소 및 환불 불가 </p>
				
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" style ="background: ">Save changes</button>
				</div>
			</div>
		</div>
	</div>




	<!-- 카카오 지도 (마커 표시) -->
	<div id="map" style="width: 1000px; height: 1000px; margin: auto"></div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0662433c3f6d691c3d739417758f655c"></script>

	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// 마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng(33.450701, 126.570667);

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);
	</script>


	<!-- AJAX로 수정해야 함 -->
	<!--  부트스트랩  내비게이션 & 탭 -->
	<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item" role="presentation">
			<button class="nav-link active" id="home-tab" data-bs-toggle="tab"
				data-bs-target="#home-tab-pane" type="button" role="tab"
				aria-controls="home-tab-pane" aria-selected="true">객실 선택</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
				data-bs-target="#profile-tab-pane" type="button" role="tab"
				aria-controls="profile-tab-pane" aria-selected="false">위치/교통</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
				data-bs-target="#contact-tab-pane" type="button" role="tab"
				aria-controls="contact-tab-pane" aria-selected="false">숙소정책</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="disabled-tab" data-bs-toggle="tab"
				data-bs-target="#disabled-tab-pane" type="button" role="tab"
				aria-controls="disabled-tab-pane" aria-selected="false" disabled>후기</button>
		</li>
	</ul>
	<div class="tab-content" id="myTabContent">
		<div class="tab-pane fade show active" id="home-tab-pane"
			role="tabpanel" aria-labelledby="home-tab" tabindex="0">...</div>
		<div class="tab-pane fade" id="profile-tab-pane" role="tabpanel"
			aria-labelledby="profile-tab" tabindex="0">...</div>
		<div class="tab-pane fade" id="contact-tab-pane" role="tabpanel"
			aria-labelledby="contact-tab" tabindex="0">...</div>
		<div class="tab-pane fade" id="disabled-tab-pane" role="tabpanel"
			aria-labelledby="disabled-tab" tabindex="0">...</div>
	</div>
	<!--  부트스트랩  내비게이션 & 탭 -->




	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>