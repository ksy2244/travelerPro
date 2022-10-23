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
	href="${pageContext.request.contextPath}/resources/style/reservation/reservationStyle.css"
	type="text/css">
<link rel="import" href="map.html">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>


<script>
	//DatePicker 한글로 변환
	$.datepicker.setDefaults({
		dateFormat : 'yymmdd',
		prevText : '이전 달',
		nextText : '다음 달',
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
				'10월', '11월', '12월' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
				'9월', '10월', '11월', '12월' ],
		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		showMonthAfterYear : true,
		yearSuffix : '년',

	});

	//Datepicker 적용할 id 가져오기, 지난 날짜 선택 불가하도록 설정 
	$(function() {
		$("#start_date").datepicker({
			minDate : 0
		});
		$("#end_date").datepicker({
			minDate : 0
		});

		$.datepicker.setDefaults({
			dateFormat : 'yy-mm-dd' //input display format 변경
		});

		$('#start_date').datepicker('setDate', 'today'); // 시작일 초기값 오늘로 설정 

		$('#end_date').datepicker('setDate', '+1D'); // 종료일 초기값 내일로 설정 
	});
</script>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0662433c3f6d691c3d739417758f655c">
	
</script>



<style>
.ui-datepicker {
	font-size: 30px;
	width: 600px;
} /* jQuery UI datepicker 크기 조정  */
.ui-datepicker-header {
	background: #B8b5ff;
}

.ui-datepicker select.ui-datepicker-month {
	width: 200px;
	font-size: 30px;
	text-align: center;
} /* jQuery UI 날짜 선택기 너비 */
.ui-datepicker select.ui-datepicker-year {
	width: 200px;
	font-size: 30px;
} /* jQuery UI 날짜 선택기 작게 */
.ui-state-default.ui-state-highlight {
	background: #E4FBFF;
	border-color: #B8b5ff;
}

.ui-state.default.ui-state-active {
	background: #B8b5ff;
}
</style>

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



	<div class="card"
		style="width: 1500px; text-align: center; font-size: 25px; font-weight: 400; margin: auto; margin-top: 20px; margin-bottom: 20px">
		<div class="card-body">인기 시설 및 서비스</div>
	</div>

	<div class="card"
		style="width: 1500px; text-align: center; font-size: 25px; font-weight: 400; margin: auto; margin-top: 20px; margin-bottom: 20px;">
		<div class="card-body">
			<form action="roomInfo.jsp" method="get">
				<p style="font-size: 25px;">
					시작일 <input type="text" id="start_date" name="start"> 종료일 <input
						type="text" id="end_date" name="end">
					<button class="reservationBtn" type="submit"
						onclick="location.href='reservation/roomInfo.do?companyNum=${dto.companyNum}'">객실
						선택</button>
				</p>

				<input type="submit">객실선택
			</form>

		</div>
	</div>


	<div class="row">
		<c:forEach var="dto" items="${list}" varStatus="status">

			<div class="card" style="width: 1500px; margin: auto">
				<div class="card mb-3" style="width: 1485px; margin: auto">
					<img
						src="${pageContext.request.contextPath}/resources/images/mainImg/busan.png"
						class="card-img-top" alt="...">
					<div class="card-body">
						<p class="eachRoomName">${dto.roomName}</p>
						<p class="eachRoomInfo">${dto.roomInfo}</p>
						<p class="headCount">기준 ${dto.headCount}인 / 최대
							${dto.headCount}인</p>
						<p class="eachRoomMoney">
							<span style="color: purple">${dto.discountRate}% &nbsp;</span>${dto.roomPrice}원
						<p>


							<button class="reservationBtn" type="submit"
								onclick="location.href='reservation/roomDetailInfo.do?companyNum=${dto.companyNum}&roomNum=${dto.roomNum}'">객실
								선택</button>

							<!-- 	&start_date=${start_date}&dateDto=${end_date} -->

						</p>

					</div>
				</div>

			</div>
		</c:forEach>
	</div>


	<!-- 카카오 지도 (마커 표시) -->
	<div id="map" style="width: 1000px; height: 1000px; margin: auto"></div>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성

		// 마커가 표시될 위치 설정
		var markerPosition = new kakao.maps.LatLng(33.450701, 126.570667);

		// 마커를 생성
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});

		// 마커를 지도 위에 표시되도록 설정
		marker.setMap(map);

		// 지도 위의 마커를 제거하는 코드
		// marker.setMap(null);
	</script>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>