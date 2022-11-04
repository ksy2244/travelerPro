<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

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


</head>
<body class="pt-5">
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="pt-5">
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3>예약 내역</h3>
				</div>

				<div class="body-main mt-5">
					<div class="row">

						<div class="body">
							<div class="company">${dto.realUserName}</div>
							<br>
							<div class="room">${dto.realUserTel}</div>
							<div class="day">${dto.totalPrice}
								<div class="company">${dto.sales}</div>
								<div class="room">${dto.sales}</div>
								<div class="day">${dto.discountRate}
									<div class="day">${dto.couponPrice}
										<div class="day">${dto.couponName}
											<div class="day">${dto.end_date}</div>
										</div>
									</div>
								</div>
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