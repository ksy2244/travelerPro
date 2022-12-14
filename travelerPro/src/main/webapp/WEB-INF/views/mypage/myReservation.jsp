<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<title>TRAVELER</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title2.png" />
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/reservation/reservationStyle.css"
	type="text/css">
<link rel="import" href="map.html">

<style type="text/css">
.body-container {
	max-width: 1500px;
}

.body-main {
	max-width: 900px;
	margin-left: 230px;
}

.body-title {
	margin-top: 20px;
	margin-bottom: 40px;
}

.list {
	border: 1px solid #ccc;
	border-radius: 8px;
	margin-bottom: 50px;
}

.img {
	width: 250px;
	height: 230px;
}

.date {
	font-size: 21px;
	font-weight: bold;
}

.gap {
	margin-bottom: 100px; 
}

.body {
	margin-left: 120px;
	margin-top: 50px;
}

.company {
	font-weight: bold;
	font-size: 20px;
}

.rnum {
	color: #787878;
	font-size: 15px; 
}

.room {
	color: #787878;
	font-size: 17px;
}

.day {
	color: #787878;
	font-size: 15px;
}

.dateBtn {
	width: 300px;
}

.plus1 {
	font-size: 15px;
	color: #787878;
}

.plus2 {
	color: #787878;
}

.paging {
	font-weight: bold; 
	font-size: 18px;
}

.plus {
	text-align: center;
	color: skyblue;
	font-size: 16px;
	margin-bottom: 150px;
}

</style>

<script type="text/javascript">
$(function() {
	$(window).scroll(function() {
	    // top button controll
	    if ($(this).scrollTop() > 50) {
	        $('#topButton').fadeIn();
	    } else {
	        $('#topButton').fadeOut();
	    }
	});

	$("#topButton").click(function() {   
		   $('html, body').animate({
		     scrollTop : 0    
		    }, 200);          
		    return false;
	});
		
});


</script>
</head>
<body class="pt-5">
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="pt-5"> 
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3>?????? ??????</h3>
				</div>
				
				<div class="body-main mt-5">
					<div class="row">
						<c:forEach var="dto" items="${list}" varStatus="status">
							<div class="list">
								<h5 class="card-title date pt-4 ps-5">${dto.reservation_date}</h5>
								<hr class="pt-2">
								<div class="rnum ps-5">?????? ???????????? ${dto.reservationNum} <a href= "${pageContext.request.contextPath}/mypage/reservationDetail.do?&reservationNum=${dto.reservationNum}"><span style ="color:blue; float:right">?????? ??????&nbsp;</span></a></div>
								<img
									src="${pageContext.request.contextPath}/uploads/ceo/${dto.imageFileName}"
									class="card-img-top ps-5 pt-4 img">
								
								<div class="body"> 
									<div class="company">${dto.companyName}</div>
									<div class="room">${dto.roomName}</div>
									<div class="day">${dto.start_date} ~ ${dto.end_date} | ${dto.day}???</div>
									<div class="day">????????? ${dto.checkInTime} | ???????????? ${dto.checkOutTime}</div>
									<br>
									<button type="button" name="sendButton"
										class="dateBtn btn btn-danger mb-5"
										onclick="location.href= '${pageContext.request.contextPath}/reservation/roomInfo.do?&companyNum=${dto.companyNum}'">?????? ???????????? </button>
								</div> 						
							</div>
							<div class="gap"></div>
						</c:forEach>
						<c:if test="${dataCount == 0}">
							<div class="page-navigation paging mb-2">????????? ?????? ????????? ????????????.</div>
							<div class="plus">?????? ?????? TRAVELER??? ????????? ??????????????????!</div> 
						</c:if>
					</div>
					<br><br>
				</div>
				<div id="topButton" align="right"><i class="fa-solid fa-angles-up fa-3x"></i></div>
			</div>
			<div class="plus1 pt-3" align="center">??????????????? ?????? 2????????? ????????? ??? ?????????, ???????????? ????????? ???????????? ????????????.</div>
					<br><br>
			<div class="plus2" align="center">(???)TRAVELER??? ??????????????????????????????, ??????????????? ???????????? ???????????? ????????? ???????????? ????????? ??????, ?????? ??? ?????? ?????? ????????? ????????? ????????? ??? ??????????????? ????????????.</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />




</body>
</html>