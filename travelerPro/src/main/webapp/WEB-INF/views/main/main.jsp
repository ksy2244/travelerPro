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
<link rel="stylesheet" href="resources/style/mainStyle.css" type="text/css">
<style type="text/css">
@import url('https://webfontworld.github.io/gmarket/GmarketSans.css');


.body-container {
	max-width: 1500px;
}

</style>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main>

		<div id="carouselExampleCaptions"
			class="carousel slide body-container" data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner" style="text-align: right; font-family: 'GmarketSans'">
				<div class="carousel-item active">
					<img src="resources/images/mainImg/bokcheon.png" class="d-block w-100 bestRegion" alt="...">
					<div class="carousel-caption d-none d-md-block">
						<h1>북촌 한옥마을</h1>
						<h5 style="font-family: 'GmarketSans';">한국의 전통가옥과 서울의 모던한 건축물이 함께 어우러져 조화를 이루는 독특한 풍경을 감상할 수 있는 북촌
							한옥마을</h5>
					</div>
				</div>
				<div class="carousel-item">
					<img src="resources/images/mainImg/busan.png" class="d-block w-100 bestRegion" alt="..."> 
					<div class="carousel-caption d-none d-md-block">
						<h1>부산 해운대</h1>
						<h5>부산의 야경을 있는 그대로 확인 할 수 있는 해운대</h5>
					</div>
				</div>
				<div class="carousel-item">
					<img src="resources/images/mainImg/Gyeongbokgung.png" class="d-block w-100 bestRegion" alt="...">
					<div class="carousel-caption d-none d-md-block">
						<h1>경복궁</h1>
						<h5>고즈넉한 분위기와 호젓함을 경험할 수 있는 경복궁</h5>
					</div>
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

		<div align="center" >
			<div class="title">지역별 여행 둘러보기!</div>
			<div class="imageLayout"> <div>
		
		<!-- 	<div class="box">
					<img class="regionImg" src="resources/images/mainImg/busan.png"> 
					<div class="regionName"> 
					<i>제주도</i> 
					</div>
			</div>
			
			<div class="box">
					<img class="regionImg" src="resources/images/mainImg/busan.png"> 
					<div class="regionName"> 
					<i>부산</i> 
					</div>
			</div>
			 -->
			
					<img class="imageRound" src="resources/images/mainImg/busan.png"> 
					<img class="imageRound" src="resources/images//mainImg/busan.png"> 
					<img class="imageRound" src="resources/images//mainImg/busan.png"> 
					<img class="imageRound" src="resources/images//mainImg/busan.png"> 
					<img class="imageRound" src="resources/images//mainImg/busan.png"> 
					<img class="imageRound" src="resources/images//mainImg/busan.png"> 
					<img class="imageRound" src="resources/images/mainImg/busan.png"> 
					<img class="imageRound" src="resources/images/mainImg/busan.png"> 
					<img class="imageRound" src="resources/images/mainImg/busan.png"> 
					
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