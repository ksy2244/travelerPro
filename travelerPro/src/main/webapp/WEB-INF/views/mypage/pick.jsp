<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TRAVELER</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
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

.list2 {
	border-bottom: 1px solid #ccc; 
	padding: 30px;
	padding-left: 50px;
}

.img2 {
	width: 300px;
	height: 300px;
	float: left;
} 

.body2 {
	margin-left: 350px;
	margin-top: 100px;
}

.company {
	font-weight: bold;
	font-size: 20px;
	margin-left: 30px;
	float: left;
}

.pick {	
	color: #787878;
	font-size:19px;
	padding-top: 10px;
}

.png {
	width: 25px;
	margin-left: 30px;
}

.right {
	margin-left: 190px;
	font-size: 17px;
	color: #787878;
}

.price {
	color: black;
	font-size: 30px;
	font-weight: bold;
}

.won {
	font-size: 23px;
	font-weight: bold;
	color: black;
}

.trip {
	border: 1px solid #eee;
	border-radius: 6px;
	padding: 7px;
	clear: both;
	margin-left: 15px;
}

.imgg {
	padding-bottom: 5px;
}

.ok {
	color: #787878;
	padding-bottom: 7px;
}

.paging {
	font-weight: bold; 
	font-size: 18px;
}
</style>


<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board2.css"
	type="text/css">
</head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/reservation/reservationStyle.css"
	type="text/css">
	
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
	
<body class="pt-5">

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="pt-5">
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3>찜</h3>
				</div>

				<div class="body-main mt-5">
					<div class="row">
						<c:forEach var="dto" items="${list}" varStatus="status">
						<div class="list2">
							<img
									src="${pageContext.request.contextPath}/uploads/ceo/${dto.imageFileName}"
									class="card-img-top ps-5 img2">
								
								<div class="rnum ps-5"></div>
								
								
								<div class="body2">
									<div class="company">${dto.companyName}</div>
									<span class="trip">
										<span class="btn gray">
										<img src="${pageContext.request.contextPath}/resources/images/한국관광공사.png" style="width: 14px;" class="imgg">&nbsp;<span class="ok">인증</span>
										</span>
										
									</span>
									<div class="pick">
										<img src="${pageContext.request.contextPath}/resources/images/icon/pick.png" class="png">&nbsp;${dto.pick}
									</div>
									<br>
									<br>
									<br>
									<div class="right">숙박 | ${dto.checkInTime}부터 &nbsp;&nbsp;<span class="price">${dto.minPrice}</span><span class="won">원</span></div>
								</div>
							</div>
						</c:forEach>


						</div>
				
					<div class="page-navigation paging">${dataPickCount == 0 ? "조회할 찜이 없습니다." : ""}
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