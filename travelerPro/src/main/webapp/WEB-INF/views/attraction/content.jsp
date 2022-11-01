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
	areaBasedList(id,typeid);

}
function toutlist(areaCode,region) {
	areaBasedList2(areaCode);
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
		printAreaBasedList(data);

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
		
	var fn = function(data) {
		console.log(data);		
		printAreaBasedList(data);

	};
	
	ajaxFun(url, "get", query, "xml", fn);
}

</script>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
		<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>