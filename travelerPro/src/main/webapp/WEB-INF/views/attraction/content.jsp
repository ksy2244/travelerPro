<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TRAVELER</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title2.png" />
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<style type="text/css">
@import url('https://webfontworld.github.io/hallym/Hallym.css');
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

#myTab {
	margin-top: 20px;
	width: 1030px;
	margin-left: 130px;
	color: black;
}

#nav-tabContent{
	width: 1030px;
	margin-left: 130px;
	height: 500px;
}

.attraction-title {
	font-family: 'GmarketSans';
	font-weight: 500;
	font-size: 30px;
	margin-top: 80px;
	text-align: center;
}

.attraction-image {
	width: 600px;
	height: 650px;
	margin-left: 130px;
}

.body-container {
	max-width: 1500px;
}

.icon {
	float: left;
	margin-right: 1200px;
}

.attraction-content {
	font-size: 20px;
	line-height: 50px;
}

.more {
	font-size: 22px;
	font-weight: 600;
	margin-left: 130px;
}

.red {
	font-size: 32px;
	color: #5CD1E5;
	font-weight: bold;
}

.name {
	color: black;
	padding: 20px;
	font-size: 22px;
}


.name2 {
	font-size: 19px;
	color: #787878;
	border: 1px solid #eee;
	border-radius: 7px;
	padding: 7px;
	background: #eee;
	text-align: center;
	padding-left: 4px;
	margin-right: 25px;
}
/*  main {
	height: 2500px;
} */

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

	
	ex += "<img class='attraction-image' alt='attraction' src='"+image+"'>";
	ct += overview;
	ti += title1;
	//out+= "<div>????????????</div>";
		
	$(".img").html(ex);
	$(".attraction-content").html(ct);
	$(".attraction-title").html(ti);
	
	out += "<p class='name'> <span class='name2'>&nbsp;<i class='fa-solid fa-square-phone'></i>&nbsp;????????????</span>"+tel+"</p>";
	out += "<p class='name'> <span class='name2'>&nbsp;<i class='fa-solid fa-house-signal'></i>&nbsp;????????????</span>"+homepage+"</p>";
	out += "<p class='name'> <span class='name2'>&nbsp;<i class='fa-solid fa-location-dot'></i>&nbsp;??????</span>"+addr1+"</p>";
	
	
	$("#nav-1").html(out);

}

function map(){
	var mapContainer = document.getElementById('map'), // ????????? ????????? div 
	
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // ????????? ????????????
        level: 3 // ????????? ?????? ??????
    };  

	// ????????? ???????????????    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// ??????-?????? ?????? ????????? ???????????????
	var geocoder = new kakao.maps.services.Geocoder();
	
	// ????????? ????????? ???????????????
	geocoder.addressSearch(addr, function(result, status) {
	
	    // ??????????????? ????????? ??????????????? 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // ??????????????? ?????? ????????? ????????? ???????????????
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // ?????????????????? ????????? ?????? ????????? ???????????????
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+title+'</div>'
	        });
	        infowindow.open(map, marker);
	
	        // ????????? ????????? ??????????????? ?????? ????????? ??????????????????
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
			$(".body-main").css({
				"height":"2500px"
			});
			let selector = "#nav-"+tab;
			let url= "${pageContext.request.contextPath}/attraction/surroundcompany.do";
			let a = addr.split(" ");
			if( a && a[0] ) {
				let query="addr="+encodeURIComponent(a[0]);
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

<main class="pt-5 body-main">
	<div class="container">
	<div class="body-containerMain">
		<div class="attraction-title"></div>
		<br>
		<div class="icon"><i class="fa-solid fa-share-nodes fa-2x"></i></div><span><i class="fa-regular fa-bookmark fa-2x"></i></span>&nbsp;&nbsp;<span><i class="fa-solid fa-print fa-2x"></i></span>
		<hr style="width: 1300px; color: #787878">
		<br><br>
		<div class="img" align="left"></div>
		<br><br>
		<div class="more">??? <span class="red">?????????</span>??????,</div><br>
		<div class="attraction-content"></div>
		<div class="mt-4 mb-2 pt-3"><br>
		<div class="more">??? <span class="red">?????????</span>??? ??? ????????????????</div>
		<div class="mt-4 mb-2 pt-3 moreBox">
		
		<ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="tab-1" data-bs-toggle="tab" data-bs-target="#nav-1" type="button" role="tab" aria-controls="1" aria-selected="true">??????</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="tab-2" data-bs-toggle="tab" data-bs-target="#nav-2" type="button" role="tab" aria-controls="2" aria-selected="true">??????</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="tab-3" data-bs-toggle="tab" data-bs-target="#nav-3" type="button" role="tab" aria-controls="3" aria-selected="true">?????? ??????</button>
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