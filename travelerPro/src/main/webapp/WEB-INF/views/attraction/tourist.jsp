<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>attraction</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style/tourist/main.css"
	type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style/tourist/content.css"
	type="text/css">
<style type="text/css">
@import url('https://webfontworld.github.io/hallym/Hallym.css');
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
	/* 	out += "    <div class='tit_cont'>";
		out += "    	<h2 class='tour-title'>지역의 추천 관광지</h2>";
		out += "    </div>"; */
		/* out += "    <div class='box_leftType1'>"; */
		out += "        <ul class='list_thumType flnon'>";
		out += "        	<li class='bdr_nor'>";
		out += "        		<div class='photo'>";
		out += "        			<a href='#'>";		
		out += "        				<img alt='' src='"+img+"'>";
		out += "					</a>";			
		out += "    			</div>";
		out += "    			<div class='area_txt'>";
		out += "    				<div class='tit'>";
		out += "    					<a onclick="+"location.href='${pageContext.request.contextPath}/attraction/content.do?region=${region}&areacode="+${areacode}+"&contenttypeid="+contenttypeid+"&contentid="+contentid+"'"+">"+title+"</a>";
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
		<p><a>서울 인천</a></p>
		<p><a>대전 대구</a></p>
		<p><a>광주 부산</a></p>
		<p><a>울산 세종</a></p>
		<p><a>경기도 강원도</a></p>
		<p><a>충청북도 충청남도</a></p>
		<p><a>경상북도 경상남도</a></p>
		<p><a>전라북도 전라남도</a></p>
		<p><a>제주도</a></p>
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
			<button type="button" class="btn btn-primary btnPrev" disabled="disabled">이전</button>
			<button type="button" class="btn btn-primary btnNext" disabled="disabled">다음</button>
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