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
	max-width: 800px;
	margin-left: 250px;
}

.body-title {
	margin-top: 20px;
	margin-bottom: 40px;
}

.box {
	border-bottom: 1px solid #ccc;
	border-radius: 8px;
	margin-bottom: 20px;
}

.date {
	font-size: 21px;
	font-weight: bold;
}

.gap {
	margin-bottom: 200px;
}

.body {
	margin-left: 40px;
	margin-top: 60px;
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
	font-size: 16px;
}

.day {
	color: #787878;
	font-size: 15px;
}

.color {
	color: #00B4DB;
	padding-top: 20px;
	padding-left: 50px;
	float: left;
}

.star {
	color: red;
}

.starRate {
	padding-left: 50px;
}

.bold {
	font-weight: bold;
	color: black;
	font-size: 15px;
}

.content {
	clear: both;
	margin-left: 50px;
	font-size: 20px;
	height: 100px;
}

.reg_date {
	float: right;
	font-size: 12px;
	color: #787878;
	padding-top: 70px;
}

.paging {
	font-weight: bold; 
	font-size: 18px;
}

.plus {
	text-align: center;
	color: #787878;
	font-size: 17px;
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
					<h3>나의 리뷰</h3>
				</div>

			<div class="body-main"> 
					<div class="row"> 
						 <c:forEach var="dto" items="${list}" varStatus="status">
							<div class="box">
								<c:choose>
									<c:when test="${dto.starRate == 5 || dto.starRate == 4}">
										<div class="color"><i class="fa-regular fa-face-smile-beam fa-5x"></i></div> 
									</c:when>
									<c:when test="${dto.starRate == 3}">
										<div class="color"><i class="fa-regular fa-face-meh fa-5x"></i></div>
									</c:when>
									<c:otherwise>
										<div class="color"><i class="fa-regular fa-face-frown fa-5x"></i></div>
									</c:otherwise>
								</c:choose>			
						
								<div class="body ps-2 mt-4">
									<div class="pb-2">
										<c:choose>
											<c:when test="${dto.starRate == 5}">
												<div class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>&nbsp;<span class="bold">${dto.starRate }</span></div>
											</c:when>
											<c:when test="${dto.starRate == 4}">
												<div class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>&nbsp;<span class="bold">${dto.starRate }</span></div>
											</c:when>
											<c:when test="${dto.starRate == 3}">
												<div class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>&nbsp;<span class="bold">${dto.starRate }</span></div>
											</c:when>
											<c:when test="${dto.starRate == 2}">
												<div class="star"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>&nbsp;<span class="bold">${dto.starRate }</span></div>
											</c:when>
											<c:when test="${dto.starRate == 1}">
												<div class="star"><i class="fa-solid fa-star"></i>&nbsp;<span class="bold">${dto.starRate }</span></div>
											</c:when>
											<c:otherwise>
												<div class="star"><i class="fa-regular fa-star"></i>&nbsp;<span class="bold">${dto.starRate }</span></div>
											</c:otherwise>
										</c:choose>
									</div>	
									<div class="rnum">숙소 예약번호 ${dto.reservationNum}</div>
									<div class="rnum">${dto.companyName}&nbsp;${dto.roomName} 이용</div>
									<div class="day">${dto.startDate}~ ${dto.endDate}</div>
									<br>
	
								</div>
								<div class="content">
									${dto.content}
									<div class="reg_date">${dto.reg_date}</div>
								</div>
								<br>
							</div>
						</c:forEach>
						<c:if test="${dataCount == 0}"> 
							<div class="page-navigation paging mb-2">조회할 리뷰가 없습니다.</div>
							<span class="plus">고객님의 리뷰가 TRAVELER의 발전에 큰 영향이 됩니다.</span> 
						</c:if>
					</div>
				</div>
			  <div id="topButton" align="right"><i class="fa-solid fa-angles-up fa-3x"></i></div>
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />




</body>
</html>