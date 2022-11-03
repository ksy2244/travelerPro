<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<style type="text/css">
@import url('https://webfontworld.github.io/hallym/Hallym.css');
.container {
	height: 1500px;
}
.body-container {
	margin-left: 15%;
	width:3000px;
	overflow: hidden;
	object-fit: fill;
}
.body-container img{
	width: 30%;
	height: 30rem;
}
.attraction-title {
	font-size:40px;
	font-weight:bold;
	text-align: center;
}
.attraction-content {
	margin-top: 2%;
	width: 80%;
	margin-left: 10%;
}
#nav-1 p{
	margin-top:3rem;
	font-size: 20px;
	line-height: 3rem;
}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0662433c3f6d691c3d739417758f655c&libraries=services"></script>
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
	detailCommon('${id}');
});

function detailCommon(id) {
	let MobileOS = "ETC";
	let MobileApp = "AppTest";
	let arrange = "B";
	
	//let url="http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList";
	let url = "http://apis.data.go.kr/B551011/KorService/detailCommon";
	let serviceKey = "zoYzQ4HJAPjbBlboD7ozq5qMtBW4Ug2KyjcpX0%2FtxnM9Kn%2F1EmvgUjvNCEe6nhYUKeL4wnHIsZMhQXqCTg1ADA%3D%3D";
	let query = "ServiceKey="+serviceKey;
	//query += "&pageNo="+pageNo;
	//query += "&numOfRows="+numOfRows;
	query += "&MobileOS="+MobileOS;
	query += "&MobileApp="+MobileApp;
	//query += "&arrange="+arrange;
	//query += "&areaCode="+areaCode;
	query += "&contentId="+id;
	query += "&firstImageYN=Y";
	query += "&defaultYN=Y";
	query += "&addrinfoYN=Y";
	query += "&mapinfoYN=Y";
	query += "&overviewYN=Y";
		
	var fn = function(data) {	
		printdetailCommon(data);
	};
	
	ajaxFun(url, "get", query, "xml", fn);
}

var addr = "";
var title = "";
function printdetailCommon(data) {
	var out = "";
	let ti = "";
	let ex="";
	let ct ="";
	let item = $(data).find("item");
	let image = item.find("firstimage").text();
	let title1 = item.find("title").text();
	title = title1 
	let tel = item.find("tel").text();
	let homepage = item.find("homepage").text();
	let contentid = item.find("contentid").text();
	let addr1 = item.find("addr1").text();
	addr = addr1;
	let mapx = item.find("mapx").text();
	let mapy = item.find("mapy").text();
	let overview = item.find("overview").text();

	
	ex += "<img class='attraction-image alt='attraction' src='"+image+"'>";
	ct += overview;
	ti += title1;
	//out+= "<div>아아아아</div>";
		
	$(".body-container").html(ex);
	$(".attraction-content").html(ct);
	$(".attraction-title").html(ti);
	
	out += "<p>전화번호:&nbsp;&nbsp;"+tel+"</p>";
	out += "<p>홈페이지:&nbsp;&nbsp;"+homepage+"</p>";
	out += "<p>주소:&nbsp;&nbsp;"+addr1+"</p>";
	
	
	$("#nav-1").html(out);

}

function map(){
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(addr, function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+title+'</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
    } 
});    
	
}
$(function(){
	//detailCommon(${id});
	$("button[role='tab']").on("click", function(e) {
		let tab = $(this).attr("aria-controls");
		let selector = "#nav-" + tab;
	
		if (tab == "1") {
			return false;
		} else if (tab == "2") {
			map();
		} else if (tab == "3") {
			let selector = "#nav-"+tab;
			let url= "${pageContext.request.contextPath}/attraction/surroundcompany.do";
			let a = addr.split(" ");
			if( a && a[0] ) {
				let query="addr="+encodeURIComponent(a[0])+"&tmp="+new Date().getTime();
				$(selector).load(url+"?"+query);
			}
		}
	
	});
	
});

</script>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body class="pt-5">
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main class="container mt-5">
		<div class="attraction-title"></div>
		<div class="body-container"></div>
		
		<div class="attraction-content"></div>
		<div class="container mt-4 mb-2 pt-3">

		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="tab-1" data-bs-toggle="tab" data-bs-target="#nav-1" type="button" role="tab" aria-controls="1" aria-selected="true">관광지정보</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="tab-2" data-bs-toggle="tab" data-bs-target="#nav-2" type="button" role="tab" aria-controls="2" aria-selected="true">위치</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="tab-3" data-bs-toggle="tab" data-bs-target="#nav-3" type="button" role="tab" aria-controls="3" aria-selected="true">주변숙소</button>
			</li>
		</ul>

		<div class="tab-content pt-2" id="nav-tabContent">
			<div class="tab-pane fade show active" id="nav-1" role="tabpanel" aria-labelledby="nav-tab-1">
			</div>
			<div class="tab-pane fade p-2" id="nav-2" role="tabpanel" aria-labelledby="nav-tab-2">
				<div id="map" style="width: 100%; height: 500px;"></div>
			</div>
			<div class="tab-pane fade" id="nav-3" role="tabpanel" aria-labelledby="nav-tab-2">
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