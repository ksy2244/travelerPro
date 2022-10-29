<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0662433c3f6d691c3d739417758f655c">
</script>

</head>
<body>
	<div id="map" style="width: 1000px; height: 1000px; margin: auto"></div>
	<script>
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					level : 3
				// 지도의 확대 레벨
				};
				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성
				// 마커가 표시될 위치 설정
				var markerPosition = new kakao.maps.LatLng(33.450701,
						126.570667);
				// 마커를 생성
				var marker = new kakao.maps.Marker({
					position : markerPosition
				});
				// 마커를 지도 위에 표시되도록 설정
				marker.setMap(map);
				// 지도 위의 마커를 제거하는 코드
				// marker.setMap(null);
		</script>

</body>
</html>