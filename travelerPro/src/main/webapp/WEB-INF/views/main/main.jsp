<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TRAVELER</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title2.png" />
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/mainStyle.css"
	type="text/css">
<link rel="icon" href="/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/vendor/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/vendor/slick/slick-theme.css" />

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/vendor/slick/slick.js"></script>
<style type="text/css">
@import url('https://webfontworld.github.io/gmarket/GmarketSans.css');

body {
	background: #D4F4FA;
}

.body-container {
	max-width: 1500px;
}

.carouselExampleCaptions {
	width: 1500px;
}

.map-title {
	font-family: 'GmarketSans';
	font-size: 27px;
	margin-left: 60px;
	padding-top: 50px;
	font-weight: 500;
}

.company-famous {
	font-family: 'GmarketSans';
	font-size: 27px;
	margin-left: 60px;
	padding-top: 50px;
	font-weight: 500;
}

.map-sidetitle {
	font-family: 'GmarketSans';
	font-size: 19px;
	font-weight: 300;
}

.box {
	border: 1px solid #eee;
	margin-top: 50px;
	height: 1800px;
	background: white;
	border-radius: 7px;
}

.box2 {
	border: 1px solid #eee;
	margin-top: 50px;
	height: 500px;
	background: white;
	border-radius: 7px;
}

.region-button {
	font-family: 'GmarketSans';
	font-size: 15px;
}

.region-button button {
	border: none;
	color: black;
	background-color: rgba(0, 0, 0, 0);
	position: absolute;
}

.region-button button:hover {
	background: white;
}

.region-button .seoul {
	left: 1000px;
	top: 1100px;
}

.region-button .incheon {
	left: 950px;
	top: 1150px;
}

.region-button .sejeong {
	left: 970px;
	top: 1230px;
}

.region-button .guynggi {
	left: 1000px;
	top: 1170px;
}

.region-button .gangwon {
	left: 1150px;
	top: 1090px;
}

.region-button .daejeon {
	left: 970px;
	top: 1330px;
}

.region-button .daegu {
	left: 1150px;
	top: 1380px;
}

.region-button .wulsan {
	left: 1180px;
	top: 1460px;
}

.region-button .busan {
	left: 1130px;
	top: 1500px;
}

.region-button .gwangju {
	left: 1000px;
	top: 1450px;
}

.region-button .chungbuk {
	left: 1050px;
	top: 1300px;
}

.region-button .chungnam {
	left: 900px;
	top: 1300px;
}

.region-button .gyungbuk {
	left: 1190px;
	top: 1320px;
}

.region-button .gyungnam {
	left: 1080px;
	top: 1430px;
}

.region-button .jeonbuk {
	left: 930px;
	top: 1400px;
}

.region-button .jeonnam {
	left: 900px;
	top: 1500px;
}

.region-button .jeju {
	left: 820px;
	top: 1700px;
}

.click {
	font-family: 'GmarketSans';
	font-size: 23px;
	font-weight: 400;
	margin-left: 120px;
	padding-top: 50px;
}

.search-container {
	max-width: 1500px;
	/* position: relative; */
}

.page-wrapper {
	width: 100%;
	/* position: relative; */
	/* 	position: absolute;
	right: 0;
	top: 50px; */
}

.post-slider {
	width: 80%;
	margin: 0 auto;
	position: relative;
}

.post-slider .silder-title {
	text-align: center;
	margin: 30px auto;
	position: relative;
	font-family: 'GmarketSans';
	font-size: 30px;
	font-weight: 300;
}

.post-slider .next {
	position: absolute;
	right: 30px;
	font-size: 2em;
	cursor: pointer;
}

.post-slider .prev {
	position: absolute;
	left: 0;
	font-size: 2em;
	cursor: pointer;
}

.post-slider .post-wrapper {
	width: 1050px;
	height: 400px;
	right: 20px;
	overflow: hidden;
	padding: 10px 0;
	position: absolute;
}

.post-slider .post-wrapper .post {
	display: inline-block;
	background: white;
	border-radius: 5px;
}

.post-slider .post-wrapper .post:first-child {
	margin-left: 5px;
}

.post-slider .post-wrapper .post .slider-image>img {
	width: 240px;
	height: 300px;
	margin-left: 10px;
	margin-right: 10px;
	border-top-left-radius: 5px;
	border-bottom-right-radius: 5px;
	margin-top: 10px;
}

.post-slider .post-wrapper .post .post-info {
	padding: 5px;
}

.post-slider .post-wrapper .post .post-info .post-subject {
	color: black;
}

.post-slider .post-wrapper .post .post-info .post-link {
	cursor: pointer;
	color: #787878;
}

.post-slider .post-wrapper .post .post-info .post-link:hover {
	color: #0d6efd;
}

#areaCode {
	margin-top: 20px;
}

.btnSearchOk {
	margin-top: 20px;
}

.btnSearchInit {
	margin-top: 20px;
}

.tour-list {
	font-family: 'GmarketSans';
}

.card {
	font-family: '맑은고딕';
	font-size: 15px;
	width: 350px;
}

.gray {
	margin-top: 7px;
}

.company-photo {
	margin-bottom: 20px;
}

.company-name {
	font-size: 16px;
	margin-top: 10px;
	margin-bottom: 5px;
}

.star {
	color: #FFBB00;
	margin-left: 18px;
}

.all {
	color: black;
}

.company-price {
	font-size: 20px;
	font-weight: bold;
	padding-left: 100px;
}

.main-image {
	position: relative;
}

.main-image-text {
    top: 0px;
    left: 210px;;
    color: white;
    font-size: 50px;
    text-shadow: 1px 1px black;
 }
</style>

<script type="text/javascript">
function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		error:function(e) {
			console.log(e.responseText);
		}
	});
}

$(function(){
	sendRegion('1', '서울');
	companyphoto('1','서울');
});
function companyphoto(areaCode,areaName) {
	let url = "${pageContext.request.contextPath}/main/companyphoto.do";
	let query = "areaCode="+areaCode+"&areaName="+areaName;
	const fn = function(data) {
		printphoto(data);
	};
	ajaxFun(url,"get",query,"json",fn);
}

function printphoto(data){
	let out = "";
	for(let item of data.list){
		let companyName = item.companyName;
		let imageFileName = item.imageFileName;
		let minPrice = item.minPrice;
		let companyNum = item.companyNum;
		let starRate = item.starRate;
		let reviewCount = item.reviewCount;
		
		out += "<div class='company-photo'>";
		out += "	<a href='${pageContext.request.contextPath}/reservation/roomInfo.do?companyNum="+companyNum+"'>";		
		out += "		<img alt='' src='${pageContext.request.contextPath}/uploads/ceo/"+imageFileName+"'>";
		out += "	</a>";
		out += "	<div class='company-name'>";
		out += "		<a href='${pageContext.request.contextPath}/reservation/roomInfo.do?companyNum="+companyNum+"'>"+companyName+"</a>";
		out += "	</div>";
		out += "	<div class='star'><i class='fa-solid fa-star fa-lg'></i>&nbsp;<span class='all'>총&nbsp;"+ starRate+"점 ("+reviewCount+")</div>"
		out += "<br>"
		out += "	<div class='company-price'>"+minPrice+"원</div>";
		out += "</div>";
	}
	$(".company-content").html(out);
	
}

function sendRegion(areaCode, areaName){
	$(".tour-title").html(areaName + " 지역의 추천 관광지");
	
	 areaBasedList(areaCode); // 지역 기반 리스트
}

function areaBasedList(areaCode) {
	let MobileOS = "ETC";
	let MobileApp = "AppTest";
	let arrange = "B";
	let numOfRows = 20;
	let pageNo = 1;
	
	let url = "http://apis.data.go.kr/B551011/KorService/areaBasedList";
	let serviceKey = "zoYzQ4HJAPjbBlboD7ozq5qMtBW4Ug2KyjcpX0%2FtxnM9Kn%2F1EmvgUjvNCEe6nhYUKeL4wnHIsZMhQXqCTg1ADA%3D%3D";
	let query = "ServiceKey="+serviceKey;
	query += "&pageNo="+pageNo;
	query += "&numOfRows="+numOfRows;
	query += "&MobileOS="+MobileOS;
	query += "&MobileApp="+MobileApp;
	query += "&arrange="+arrange;
	query += "&areaCode="+areaCode;
		
	var fn = function(data) {
		console.log(data);
		printAreaBasedList(data);
		
	};
	
	ajaxFun(url, "get", query, "xml", fn);
}

function printAreaBasedList(data) {

	if( $(".tour-list").text() ) {
		// slick을 unslick 하지 않은 상태에서 다시 slick을 하면 Cannot read property 'add' of null 에러 발생
		$('.tour-list').slick("unslick")
	}

	
	var out = "";	
	let ex="";
	var noImg = "${pageContext.request.contextPath}/resources/images/noimage.png";
	var dataCount = $(data).find("totalCount").text();
	$(data).find("item").each(function() {
		var item = $(this);
		var title = item.find("title").text();
		var img = item.find("firstimage").text();
		var contentid = item.find("contentid").text();
		var contenttypeid = item.find("contenttypeid").text();
		if(! img) {
			img = noImg;
		}
		var code = $("#areaCode").value;
		
		out += "<div class='post'>";
		out += "    <div class='slider-image'><img src='"+img+"'></div>";
		out += "    <div class='post-info'>";
		out += "        <div class='fs-6 post-subject'>" + title + "</div>";
		out += "        <div class='fs-6 post-link'><a onclick="+"location.href='${pageContext.request.contextPath}/attraction/content.do?contentid="+contentid+"'"+"> 둘러보기 </a><i class='bi bi-arrow-right-circle'></i></div>";
		out += "    </div>";
		out += "</div>";
	});
	
	$(".tour-list").html(out);
	

	
	$('.tour-list').slick({
		  slidesToShow: 4,
		  slidesToScroll: 1,
		  autoplay: true,
		  autoplaySpeed: 2000,
		  nextArrow:$('.tour-wrapper .next'),
		  prevArrow:$('.tour-wrapper .prev')
	});
}

//검색 ------------------------------------
$(function(){
	$(".btnSearchOk").click(function(){
		let areaCode = $("#areaCode").val(); // 지역코드
		let areaName = $("#areaCode :selected").text(); // 지역명
		let kwd = $("#kwd").val();

		if( ! kwd ) {
			sendRegion(areaCode, areaName);
			return;
		}
		
		
	});

	$(".btnSearchInit").click(function(){
		$("#areaCode").val("1");
		$("#kwd").val("");
		sendRegion("1", "서울");
	});
});


</script>
</head>
<body class="pt-5">

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main class="container pt-5">
		<div class="body-container">
		<div class="main-image">
			<img
				src="${pageContext.request.contextPath}/resources/images/main.jpg"
				class="d-block w-100" alt="..." style="height: 700px;">
			<div class="carousel-caption d-none d-md-block">
				<h1 class="main-image-text" style="opacity: 1; font-family: 'GmarketSans';">
					오늘 TRAVELER와 여행 어때요?
				</h1>
			</div>
		</div>
			
			<div class="box">
				<div class="map-title">
					<div>지금 필요한 여행 정보</div>
					<div class="map-sidetitle">TRAVELER가 알아서 좋은걸 준비했어요</div>
				</div>
				<div class="click">지역별 관광지 둘러보기</div>

				<div class="api-container">
					<div class="map-image">
						<img alt="지도"
							src="${pageContext.request.contextPath}/resources/images/map.png">
					</div>
					<div class="region-button">
						<button class="seoul" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=1&region=서울'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							서울
						</button>
						<button class="incheon" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=2&region=인천'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							인천
						</button>
						<button class="sejeong" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=8&region=세종'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							세종
						</button>
						<button class="guynggi" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=31&region=경기도'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							경기도
						</button>
						<button class="gangwon" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=32&region=강원도'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							강원도
						</button>
						<button class="daejeon" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=3&region=대전'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							대전
						</button>
						<button class="daegu" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=4&region=대구'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							대구
						</button>
						<button class="gwangju" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=5&region=광주'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							광주
						</button>
						<button class="busan" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=6&region=부산'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							부산
						</button>
						<button class="wulsan" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=7&region=울산'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							울산
						</button>
						<button class="chungbuk" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=33&region=충청북도'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							충청북도
						</button>
						<button class="chungnam" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=34&region=충청남도'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							충청남도
						</button>
						<button class="gyungnam" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=36&region=경상남도'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							경상남도
						</button>
						<button class="gyungbuk" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=35&region=경상북도'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							경상북도
						</button>
						<button class="jeonbuk" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=37&region=전라북도'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							전라북도
						</button>
						<button class="jeonnam" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=38&region=전라남도'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							전라남도
						</button>
						<button class="jeju" type="submit"
							onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=39&region=제주도'">
							<div style="color: red;">
								<i class="fa-solid fa-location-dot fa-2x"></i>
							</div>
							제주도
						</button>
					</div>
					<div class="api-list">
						<hr style="color: #787878; width: 1300px;">
						<div class="click">
							지역별 추천 관광지 미리보기 <span> <a class="btn gray"
								data-bs-toggle="collapse" href="#collapseExample" role="button"
								aria-expanded="false" aria-controls="collapseExample"> <i
									class="fa-solid fa-circle-exclamation"></i>
							</a>
							</span>
							<div class="collapse" id="collapseExample">
								<div class="card card-body">이미지가 없는 경우 NO IMAGE로 표시됩니다.</div>
							</div>
						</div>
						<div class="search-container">
							<form class="row justify-content-center" method="get">
								<div class="col-auto p-1">
									<select name="areaCode" id="areaCode" class="form-select">
										<option value="1">서울</option>
										<option value="2">인천</option>
										<option value="3">대전</option>
										<option value="4">대구</option>
										<option value="5">광주</option>
										<option value="6">부산</option>
										<option value="7">울산</option>
										<option value="8">세종특별자치시</option>
										<option value="31">경기도</option>
										<option value="32">강원도</option>
										<option value="33">충청북도</option>
										<option value="34">충청남도</option>
										<option value="35">경상북도</option>
										<option value="36">경상남도</option>
										<option value="37">전라북도</option>
										<option value="38">전라남도</option>
										<option value="39">제주도</option>
									</select>
								</div>
								<div class="col-auto p-1">
									<button type="button" class="btn btnSearchOk">
										<i class="fa-solid fa-magnifying-glass"></i>
									</button>
								</div>
								<div class="col-auto p-1">
									<button type="button" class="btn btnSearchInit">
										<i class="fa-solid fa-rotate-right"></i>
									</button>
								</div>
							</form>
						</div>

						<div class="page-wrapper tour-wrapper">
							<!--page slider -->
							<div class="post-slider">
								<h1 class="silder-title tour-title">이 지역의 추천 관광지</h1>
								<span class="prev"> <i class="bi bi-chevron-left"></i>
								</span> <span class="next"> <i class="bi bi-chevron-right"></i>
								</span>
								<div class="post-wrapper tour-list"></div>
							</div>
							<!--post slider-->
						</div>
					</div>
				</div>
			</div>
			<div class="box2">
				<div class="company-famous">
					<span>지금 인기 Top</span>
					<div class="map-sidetitle">
						TRAVELER의 인기숙소도 같이 만나보세요 
						<a href="${pageContext.request.contextPath}/reservation/companyList.do?"
							style ="float:right; margin-right:60px">
							더보기 <i class="fa-sharp fa-solid fa-chevron-right"></i>
						</a>
					</div>
				</div>
				<div class="company-list">
					<div class="company-content"></div>
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