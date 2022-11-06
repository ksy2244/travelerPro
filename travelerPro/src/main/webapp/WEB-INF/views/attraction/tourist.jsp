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
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style/tourist/main.css"
	type="text/css">

<style type="text/css">
/* div {
	box-sizing: border-box;
}

ul {
	list-style: none;
}

.body-container {
	width: 100%;
	margin: 0 auto;
	padding: 0 20px 27px 20px;
}
.region-content {
	width: 80%;
	margin-top: 100px;
	
}
.region-list{
	width: 80%;
}
.region-list > li.region-one {
	border-top: 1px solid #e6e6e6;
}
.region-list > li .photo {
/*     position: absolute;
    left: 0;
    top: 20px; */
    width: 200px;
    height: 200px;
}
.region-list > li .photo img {
	width: 200px;
    height: 200px;
}

.area-body {
	margin-top: 60px;
	position: relative;
}

.area-tag {
   float: right;
   position: fixed;
   top: 200px;
   width: 380px;
   height: 500px;
   text-align: center;
   margin-left: 1500px; 
   box-shadow: 8px 8px gray;
   font-family: 'GmarketSans';
   background: #D4F4FA;
   
}

.font {
   
   font-size: 22px;
   color: black;
}

@import url('https://webfontworld.github.io/gmarket/GmarketSans.css');

.btn {
   display: inline-block;
   font-family: 'GmarketSans'; 
}

.gap {
   margin-right: 20px;
}

.btnPrev {
	font-family: '맑은 고딕';
}

.btnNext {
	font-family: '맑은 고딕';
}
/* 이벤트 */


.tit_cont h2{overflow: hidden;font-weight:500;color: #333;font-size:36px;letter-spacing:-1px;word-break: keep-all; font-family: 'GmarketSans'; margin-bottom: 50px;}
.wrap_contView {
	margin-top: 20px;
}
.list_thumType > li{position: relative; padding: 20px 0 20px; border-bottom: 1px solid #e6e6e6;}
/* .list_thumType > li:first-child{border-top: 1px solid #999;} */
.list_thumType > li.bdr_nor{border-top: 1px solid #e6e6e6;}
.list_thumType{width: 1000px;}
.list_thumType > li .photo{position: absolute;left:0;top:20px; width: 140px;height:94px;}
.list_thumType > li .photo img{width: 140px;height:94px;}
.list_thumType > li .photo a{display: block;}
.list_thumType > li .area_txt{min-height:94px;padding-left:160px;padding-right:20px;}

.list_thumType > li .area_txt .tit{margin-top:-5px;padding-bottom: 5px;}
.list_thumType > li .area_txt .tit a br{display:none;}
.list_thumType > li .area_txt .tit a{overflow:hidden;display: inline-block;width:100%; font-weight:bold;font-size: 21px; color: #000;text-overflow:ellipsis;white-space: nowrap;}
.list_thumType > li .area_txt .tit a em{font-weight:500;color:#ed4956;}
.list_thumType > li .area_txt .tit a:hover{text-decoration: underline;}
.list_thumType > li .area_txt .tit span{display: inline-block; padding-left: 5px; font-size: 16px;}
.list_thumType > li .area_txt p{font-size: 14px;}

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
	//sendRegion(${id}, ${typeid});
	toutlist(${areacode},'${region}');
});


/* function sendRegion(id, typeid){
	//$(".tour-title").html(areaName + " 지역의 관광지");
	areaBasedList(id,typeid);
	//areaBasedList2(areaCode);
} */
function toutlist(areaCode,areaName) {
	$(".tour-title").html(areaName + " 지역의 관광지");
	areaBasedList2(areaCode, 1);
}


function areaBasedList2(areaCode, pageNo) {
	let MobileOS = "ETC";
	let MobileApp = "AppTest";
	let arrange = "B";
	let numOfRows = 20;
	
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
		// console.log(data);
		let count = $(data).find("item").length;
		pageNo = parseInt(pageNo);
		
		$(".btnPrev").attr("data-pageNo", pageNo<=1?1:pageNo-1);
		$(".btnNext").attr("data-pageNo", pageNo+1);
		$(".btnPrev").attr("data-areaCode", areaCode);
		$(".btnNext").attr("data-areaCode", areaCode);
		
		if(pageNo<=1) {
			$(".btnPrev").prop("disabled", true);
			$(".btnNext").prop("disabled", false);
		} else {
			$(".btnPrev").prop("disabled", false);
			$(".btnNext").prop("disabled", false);
		}
		
		if(count < numOfRows) {
			$(".btnNext").prop("disabled", true);
		}
		
		console.log(data);
		printAreaBasedList(data);

	};
	
	ajaxFun(url, "get", query, "xml", fn);
}

$(function(){
	$(".btnPrev, .btnNext").click(function(){
		let pageNo = $(this).attr("data-pageNo");
		let areaCode = $(this).attr("data-areaCode");
		
		if(! pageNo || ! areaCode) {
			return false;
		}
		
		areaBasedList2(areaCode, pageNo);
	});
});

function printAreaBasedList(data) {
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
		var addr = item.find("addr1").text();
		//alert(contentid);
 		/* ex = "<a href='${pageContext.request.contextPath}/apiEx/test.jsp'"; */
 		//${pageContext.request.contextPath}/attraction/list.do?contentid="+contentid+'"

		out += "<div class='wrap_contView clfix'>";
		out += "        <ul class='list_thumType flnon'>";
		out += "        	<li class='bdr_nor'>";
		out += "        		<div class='photo'>";
		out += "        			<a href='#'>";		
		out += "        				<img alt='' src='"+img+"'>";
		out += "					</a>";			
		out += "    			</div>";
		out += "    			<div class='area_txt'>";
		out += "    				<div class='tit'>";
		out += "    					<a onclick="+"location.href='${pageContext.request.contextPath}/attraction/content.do?contentid="+contentid+"'"+">"+title+"</a>";
		out += "					</div>";
		out += "					<p>"+addr+"</p>";
		out += "				</div>";
		out += "			</li>";
		out += "		</ul>";
		out += "	</div>";
		out += "</div>";
		
	});
	
	$(".box_leftType1").html(out);
	
		
		

		

	
	

}

</script>
</head>
<body class="pt-5 area-body">
<div class="area-tag" >
     <div class="font pt-5"><i class="fa-solid fa-earth-americas"></i> 다른 지역을 여행하고 싶다면? </div>
     <div class="pt-3"><br></div>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=1&region=서울'">#서울</button></span>
      <span class="gap"></span>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=2&region=인천'">#인천</button></span>
      <span class="gap"></span>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=8&region=세종'">#세종</button></span>
      <br>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=3&region=대전'">#대전</button></span>
      <span class="gap"></span>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=4&region=대구'">#대구</button></span>
      <span class="gap"></span>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=5&region=광주'">#광주</button></span>
      <br>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=7&region=울산'">#울산</button></span>
      <span class="gap"></span>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=6&region=부산'">#부산</button></span>
      <span class="gap"></span>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=31&region=경기도'">#경기도</button></span>
      <br>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=32&region=강원도'">#강원도</button></span>
      <span class="gap"></span>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=33&region=충청북도'">#충청북도</button></span>
      <span class="gap"></span>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=34&region=충청남도'">#충청남도</button></span>
      <br>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=35&region=경상북도'">#경상북도</button></span>
      <span class="gap"></span>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=36&region=경상남도'">#경상남도</button></span>
      <br>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=37&region=전라북도'">#전라북도</button></span>
      <span class="gap"></span>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=38&region=전라남도'">#전라남도</button></span>
      <br>
      <span><button type="button" class="btn btn-light mb-3" onclick="location.href='${pageContext.request.contextPath}/attraction/list.do?areacode=39&region=제주도'">#제주도</button></span>
</div>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main class="container pt-5" id="contents">
		 <div class="wrap_contView clfix">
			<div class="tit_cont">
				<h2 class="tour-title">지역의 추천 관광지</h2>
			</div>
			<div class="box_leftType1">
				<%--<ul class="list_thumType flnon">
					<li class="bdr_nor">
						<div class="photo">
							<a href="#">
								<img alt="" src="${pageContext.request.contextPath}/resources/images/mainImg/bokcheon.png">
							</a>
						</div>
						<div class="area_txt">
							<div class="tit">
								<a href="#">북촌한옥마을</a>
							</div>
							<p>주소</p>
						</div>
					</li>
				</ul>--%>
			</div>
		</div>
		<div class="paging" style="margin-top: 50px;">
			<button type="button" class="btn btn-danger btnPrev" disabled="disabled">이전</button>
			<button type="button" class="btn btn-danger btnNext" disabled="disabled">다음</button>
		</div>
	</main>
<%-- 		<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main class="container pt-5">
		<div class="body-container">
			<div class="region-name">
				<h2 class="tour-title">지역의 추천 관광지</h2>
			</div>
			<div class="region-content">
				<ul class="region-list">
					<li class="region-one">
						<div class="photo">
							<a href="#">
								<img alt="" src="${pageContext.request.contextPath}/resources/images/noimage.png">
							</a>
						</div>
						<div class="content-text">
							<div class="content-title">
								<a href="#">힌강달빛야시장</a>
							</div>
							<p>주소</p>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</main> --%>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
		<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>