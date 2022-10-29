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
<title>traveler</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/reservation/reservationStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/traveler/travelerStyle.css"
	type="text/css">

<link rel="import" href="map.html">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>


<script>
	//DatePicker 한글로 변환
	$.datepicker.setDefaults({
		dateFormat : 'yymmdd',
		prevText : '이전 달',
		nextText : '다음 달',
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
				'10월', '11월', '12월' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
				'9월', '10월', '11월', '12월' ],
		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		showMonthAfterYear : true,
		yearSuffix : '년',

	});

	//Datepicker 적용할 id 가져오기, 지난 날짜 선택 불가하도록 설정 
	$(function() {
		$("#start_date").datepicker({
			minDate : 0
		});
		$("#end_date").datepicker({
			minDate : 0
		});

		$.datepicker.setDefaults({
			dateFormat : 'yy-mm-dd' //input display format 변경
		});

		$('#start_date').datepicker('setDate', 'today'); // 시작일 초기값 오늘로 설정 

		$('#end_date').datepicker('setDate', '+1D'); // 종료일 초기값 내일로 설정 
	});
	
	
	function dateBtn() {
		const f = document.dateForm;
		alert(hello);
		alert(f.start_date.value);
		if(f.start_date.value >= f.end_date.value){
		
			alert("이용 종료일이 이용 시작일 이후여야 합니다. ");
			f.start_date.focus();
		}
	}

</script>

<style>
.ui-datepicker {
	font-size: 30px;
	width: 600px;
} /* jQuery UI datepicker 크기 조정  */
.ui-datepicker-header {
	background: #B8b5ff;
}

.ui-datepicker select.ui-datepicker-month {
	width: 200px;
	font-size: 30px;
	text-align: center;
} /* jQuery UI 날짜 선택기 너비 */
.ui-datepicker select.ui-datepicker-year {
	width: 200px;
	font-size: 30px;
} /* jQuery UI 날짜 선택기 작게 */
.ui-state-default.ui-state-highlight {
	background: #E4FBFF;
	border-color: #B8b5ff;
}

.ui-state.default.ui-state-active {
	background: #B8b5ff;
}
</style>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>


	<main>
		<div class="row">
			<c:forEach var="room" items="${roomList}" varStatus="status">
				<div class="card border-secondary mb-3" style="max-width: 100rem;">

					<img
						src="${pageContext.request.contextPath}/resources/images/mainImg/busan.png"
						class="card-img-top" alt="...">

					<div class="card-body">
						<p class="eachRoomName">${room.roomName}</p>
						<p class="eachRoomInfo">${room.roomInfo}</p>

						<p class="headCount">기준 ${room.headCount}인 /
							${room.headCount}최대 ${room.headCount}인</p>
						<p class="eachRoomMoney">
							<span style="color: purple">${room.discountRate}% &nbsp;</span>${room.roomPrice}원
						</p>

						<form action="reservation.do" method="get">
							<input type="hidden" value="${companyNum}" name="companyNum">
							<input type="hidden" value="${room.roomNum}" name="roomNum">
							<input type="hidden" value="${start_date}" name=start_date>
							<input type="hidden" value="${end_date}" name="end_date">
							<button class="dateBtn btn btn-danger" type="submit">객실 선택</button>
						</form>
					</div>
				</div>

			</c:forEach>
		</div>
	</main>
</body>
</html>