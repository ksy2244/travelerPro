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
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style/mainStyle.css"
	type="text/css">
<link rel="icon" href="/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/slick/slick-theme.css"/>

<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/slick/slick.js"></script>
<style type="text/css">
@import url('https://webfontworld.github.io/hallym/Hallym.css');





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
	let url = "${pageContext.request.contextPath}/companyphoto.do";
	let query = "areaCode="+areaCode+"areaName="+areaName;
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
		out += "<div class=company-photo>";
		out += "	<a href=#>";		
		out += "		<img alt='' src='"+imageFileName+"'>";
		out += "	</a>";
		out += "</div>";
		out += "<div class='company-name'>";
		out += "	<a href=#>"+companyName+"</a>";
		out += "</div>";
		out += "<div class='company-price'>"+minPrice+"</div>";
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
	
	//let url="http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList";
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
		//alert(contentid);
 		/* ex = "<a href='${pageContext.request.contextPath}/apiEx/test.jsp'"; */
 		//${pageContext.request.contextPath}/attraction/list.do?contentid="+contentid+'"
		
		out += "<div class='post'>";
		out += "    <div class='slider-image'><img src='"+img+"'></div>";
		out += "    <div class='post-info'>";
		out += "        <div class='fs-6 post-subject'>" + title + "</div>";
		out += "        <div class='fs-6 post-link'><a onclick="+"location.href='${pageContext.request.contextPath}/attraction/list.do?areacode="+code+"&contenttypeid="+contenttypeid+"&contentid="+contentid+"'"+"> 둘러보기</a><i class='bi bi-arrow-right-circle'></i></div>";
		out += "    </div>";
		out += "</div>";
	});
	
	$(".tour-list").html(out);
	

	
	$('.tour-list').slick({
		  slidesToShow: 3,
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

/* function printAreaBasedList(data) {
	let out = "";
	let noImg = "${pageContext.request.contextPath}/resources/images/noimage2.png";
	let dataCount = $(data).find("totalCount").text();

	
	$(data).find("item").each(function(){
		let item = $(this);
		let title = item.find("title").text();
		let img = item.find("firstimage").text();
		if(! img) {
			img = noImg;
		}
		
		out += "<div class='carousel-item'>";
		out += "	<img class='d-block w-100 bestRegion' src='"+img+"'>";
		out += "		<div class='carousel-caption d-none d-md-block'>"
		out += "			<h1>"+title+"<h1>";	
		out += "		</div>";
		out += "</div>";
	});
	$(".carousel-inner").html(out);
	$(".carousel-item:last").addClass('active');
} */
</script>
</head>
<body class="pt-5">

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main class="container mt-5">
		<div class="body-container">
			<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="false">
			  <div class="carousel-indicators">
			    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
			    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
			  </div>
			  <div class="carousel-inner">
			    <div class="carousel-item active">
			      <img src="resources/images/fall.png" class="d-block w-100" alt="...">
			      <div class="carousel-caption d-none d-md-block">
			        <h2 style="opacity: 1"><strong>가을 정취를 느낄 수 있는 서울의 단풍</strong></h2>
			        <p>Some representative placeholder content for the first slide.</p>
			      </div>
			    </div>
			    <div class="carousel-item">
			      <img src="resources/images/flower.png" class="d-block w-100" alt="...">
			      <div class="carousel-caption d-none d-md-block">
			        <h5>Second slide label</h5>
			        <p>Some representative placeholder content for the second slide.</p>
			      </div>
			    </div>
			    <div class="carousel-item">
			      <img src="resources/images/green.png" class="d-block w-100" alt="...">
			      <div class="carousel-caption d-none d-md-block">
			        <h5>Third slide label</h5>
			        <p>Some representative placeholder content for the third slide.</p>
			      </div>
			    </div>
			  </div>
			  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Previous</span>
			  </button>
			  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Next</span>
			  </button>
			</div>
			<div class="map-title">
				<p>원하는 지역을 선택하세요</p>
			</div>
			<div class="api-container">
 				<div class="map-image">
					<img alt="지도" src="resources/images/map.png">
					<!-- <img alt="지도" src="resources/images/exmarker.png"> -->
				</div>
			<div class="region-button">
				<button class="seoul" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=1&region=서울'">서울</button>
				<button class="incheon" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=2&region=인천'">인천</button>
				<button class="sejeong" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=8&region=세종'">세종</button>
				<button class="guynggi" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=31&region=경기도'">경기도</button>
				<button class="gangwon" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=32&region=강원도'">강원도</button>
				<button class="daejeon" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=3&region=대전'">대전</button>
				<button class="daegu" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=4&region=대구'">대구</button>
				<button class="gwangju" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=4&region=광주'">광주</button>
				<button class="busan" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=6&region=부산'">부산</button>
				<button class="wulsan" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=7&region=울산'">울산</button>
				<button class="chungbuk" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=33&region=충청북도'">충청북도</button>
				<button class="chungnam" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=34&region=충청남도'">충청남도</button>
				<button class="gyungnam" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=36&region=경상남도'">경상남도</button>
				<button class="gyungbuk" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=35&region=경상북도'">경상북도</button>
				<button class="jeonbuk" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=37&region=전라북도'">전라북도</button>
				<button class="jeonnam" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=38&region=전라남도'">전라남도</button>
				<button class="jeju" type="submit" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=39&region=제주도'">제주도</button>
			</div>
				<div class="api-list">
					<div class="search-container mt-3">
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
							<!-- <div class="col-auto p-1">
								<input type="text" class="form-control" placeholder="검색 키워드 입력" autocomplete="off" 
										name="kwd" id="kwd">
							</div>
							<div class="col-auto p-1">
								<button type="button" class="btn btn-light btnSearchOk"> <i class="bi bi-search"></i> </button> 
							</div>
							<div class="col-auto p-1">
								<button type="button" class="btn btn-light btnSearchInit"> <i class="bi bi-arrow-clockwise"></i> </button>
							</div> -->
						</form>
					</div>
				
					<div class="page-wrapper tour-wrapper">
						<!--page slider -->
						<div class="post-slider">
							<h1 class="silder-title tour-title">이 지역의 추천 관광지</h1>
							<span class="prev"> <i class="bi bi-chevron-left"></i> </span>
							<span class="next"> <i class="bi bi-chevron-right"></i> </span>
							<div class="post-wrapper tour-list"></div>
						</div>
						<!--post slider-->
					</div>
				</div>
			</div>
				<div>
					<span>숙박업체</span>
				</div>
				<div class="company-list">
					<div class="company-content">
						
					</div>
				</div>
			

<!--  	<div align="center" class="region-container">
			<div class="traveleTitle" style="font-family: HallyM">지역별 여행
				둘러보기!</div> -->
		<!-- <div class="imageLayout">
				<div class="box">
					<img class="regionImg" src="resources/images/mainImg/busan.png">
					<div class="regionName">
						<i>제주도</i>
					</div>
				</div>


				<div class="box">
					<img class="regionImg" src="resources/images/mainImg/busan.png">
					<div class="regionName">
						<i>서울</i>
					</div>
				</div>

				<div class="box">
					<img class="regionImg" src="resources/images/mainImg/busan.png">
					<div class="regionName">
						<i>대전</i>
					</div>
				</div>

				<div class="box">
					<img class="regionImg" src="resources/images/mainImg/busan.png">
					<div class="regionName">
						<i>대구</i>
					</div>
				</div>

				<div class="box">
					<img class="regionImg" src="resources/images/mainImg/busan.png">
					<div class="regionName">
						<i>부산</i>
					</div>
				</div>
			</div> -->
			

		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
		<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>