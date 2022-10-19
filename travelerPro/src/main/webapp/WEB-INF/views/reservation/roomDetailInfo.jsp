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

<script type="text/javascript">
	
</script>
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

				<p>상품 정보 조건 1건</p>
				<div class="alert" role="alert" style="background: #E4FBFF">
					예약 정보를 입력해주세요.</div>

				<div class="roomCheck">
					<p>서면 라이온호텔 부산</p>
					<p>주차불가, ROOM UPGRADE 가능!!!</p>
					<p>2022.10.19(수)~2022.10.20(목) 1박</p>
					<p>체크인 15:00 체크아웃 12:00</p>
					
					<p>10,000원</p>
					<p>취소 및 환불 불가 </p>
					

					<span style="color: purple">10% &nbsp;</span>100,000원 s
					<!-- <p class="paymentRule">취소 및 환불 불가~</p> -->
					<button class="reservationBtn">객실 예약</button>
				</div>







				<div class="body-main">

					<form name="reservationForm" method="post">
						<div class="row mb-2">

							<H4>예약자 정보</H4>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="realUserName">예약자
									이름 이름</label>
								<div class="col-sm-10">
									<input type="text" name="userName" id="realUserName"
										class="form-control" value="" placeholder="체크인시 필요한 정보입니다.">
								</div>
							</div>

							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="realUserName">예약자
									전화번호 </label>
								<div class="col-sm-10">
									<input type="text" name="userName" id="realUserName"
										class="form-control" value="" placeholder="체크인시 필요한 정보입니다.">
								</div>
							</div>



						</div>
					</form>

				</div>
				
				
				<div id="map">
				</div>
			<!-- 	//인라인 스타일 또는 외부 스타일 등으로 map의 크기를 지정합니다.
//ex) style="width:500px; height:400px;"
//ex) #map {width:500px; height:400px;} -->

<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=0662433c3f6d691c3d739417758f655cY"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>




</script>
				 -->
				
			</div>

		</div>

	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>