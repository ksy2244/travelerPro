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
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=329e8054b8da87474aa8b9dc313c1c45"></script>
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
	sendRegion(${id}, ${typeid});
	toutlist(${areacode},'${region}');
	image(${id});
});

function sendRegion(id, typeid){
//$(".tour-title").html(areaName + " 지역의 관광지");
	//areaBasedList(id,typeid);

}
function toutlist(areaCode,region) {
	//areaBasedList2(areaCode);
}
function image(id){
	areaBasedList3(id);
}

 function areaBasedList(id,typeid) {
	let MobileOS = "ETC";
	let MobileApp = "AppTest";
	let contentId = id;
	let contentTypeId = typeid;
	//let arrange = "B";
	
	//let url="http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList";
	let url = "http://apis.data.go.kr/B551011/KorService/detailIntro";
	let serviceKey = "zoYzQ4HJAPjbBlboD7ozq5qMtBW4Ug2KyjcpX0%2FtxnM9Kn%2F1EmvgUjvNCEe6nhYUKeL4wnHIsZMhQXqCTg1ADA%3D%3D";
	let query = "ServiceKey="+serviceKey;
	 query += "&MobileOS="+MobileOS;
	query += "&MobileApp="+MobileApp;
	query += "&contentId="+contentId;
	query += "&contentTypeId="+contentTypeId;
	//query += "&arrange="+arrange;
	//query += "&type="+type;
		
	var fn = function(data) {
		console.log(data);
		printAreaBasedList(data);
		
	};
	
	ajaxFun(url, "get", query, "xml", fn);
} 

function areaBasedList2(areaCode) {
	let MobileOS = "ETC";
	let MobileApp = "AppTest";
	let arrange = "B";
	let numOfRows = 20;
	
	//let url="http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList";
	let url = "http://apis.data.go.kr/B551011/KorService/areaBasedList";
	let serviceKey = "zoYzQ4HJAPjbBlboD7ozq5qMtBW4Ug2KyjcpX0%2FtxnM9Kn%2F1EmvgUjvNCEe6nhYUKeL4wnHIsZMhQXqCTg1ADA%3D%3D";
	let query = "ServiceKey="+serviceKey;
	//query += "&pageNo="+pageNo;
	query += "&numOfRows="+numOfRows;
	query += "&MobileOS="+MobileOS;
	query += "&MobileApp="+MobileApp;
	query += "&arrange="+arrange;
	query += "&areaCode="+areaCode;
	
		
	var fn = function(data) {
		console.log(data);		
		//printAreaBasedList(data);

	};
	
	ajaxFun(url, "get", query, "xml", fn);
}

function areaBasedList3(id) {
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
		console.log(data);		
		//printAreaBasedList(data);

	};
	
	ajaxFun(url, "get", query, "xml", fn);
}
function printAreaBasedList(data) {
	var out = "";	
	let ex="";
	var item = $(data).find("item");
	var restdate = item.find("restdate").text();
	var parking = item.find("parking").text();
	var infocenter = item.find("infocenter").text();
	var usetime = item.find("usetime").text();
	var contentid = item.find("contentid").text();
	var contenttypeid = item.find("contenttypeid").text();
	var mapx = item.find("mapx").text();
	var mapy = item.find("mapy").text();
	var addr = item.find("addr1").text();
	alert(restdate);
	out += "<p>"+restdate+"</p>";
	out += "<p>"+parking+"</p>";
	out += "<p>"+infocenter+"</p>";
	out += "<p>"+usetime+"</p>";

		
	
	
		$("button[role='tab']").on("click", function(e) {
			let tab = $(this).attr("aria-controls");
			let selector = "#nav-" + tab;
			alert(tab);

			let url = "${pageContext.request.contextPath}/attraction/";
			if (tab =="1"){
				$("#nav-1").html(out);
			}
		});
	//$(".box_leftType1").html(out);
}

$(function (){
	$("button[role='tab']").on("click", function(e) {
		let tab = $(this).attr("aria-controls");
		let selector = "#nav-" + tab;

		let url = "${pageContext.request.contextPath}/attraction/";

		 if (tab == "2") {
			url += "map.do?mapx=${mapx}&mapy=${mapy}";
		} else {
			url += "companylist.do";
		}

		$(selector).load(url);

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
		<div class="body-container">
			<img alt="" src="${pageContext.request.contextPath}/resources/images/mainImg/bokcheon.png">
		</div>
		<div class="container mb-2 pt-3">

		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="tab-1" data-bs-toggle="tab" data-bs-target="#nav-1" type="button" role="tab" aria-controls="1" aria-selected="true">관광지정보</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="tab-2" data-bs-toggle="tab" data-bs-target="#nav-2" type="button" role="tab" aria-controls="2" aria-selected="true">위치</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="tab-3" data-bs-toggle="tab" data-bs-target="#nav-3" type="button" role="tab" aria-controls="3" aria-selected="true">세번째</button>
			</li>
		</ul>

		<div class="tab-content pt-2" id="nav-tabContent">
			<div class="tab-pane fade show active" id="nav-1" role="tabpanel" aria-labelledby="nav-tab-1">
			</div>
			<div class="tab-pane fade" id="nav-2" role="tabpanel" aria-labelledby="nav-tab-2">
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