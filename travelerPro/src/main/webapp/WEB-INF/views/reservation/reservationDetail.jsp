<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>traveler</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3>${title}</h3>
				</div>

			<%-- 	<div class="alert" role="alert" style="background: #E4FBFF">
					예약자 정보</div>
				<div class="card border-secondary mb-3" style="max-width: 100rem;">
					<div class="card-header">
						<h5>
							<i class="fa-solid fa-hotel"></i>&nbsp;예약 정보&nbsp;
						</h5>
					</div>
					<div class="card-body text-secondary">
						<h5 class="card-title">객실 타입 ;{dto.companyName}
							{dto.roomName}</h5>
						<p class="card-text">
						<p>${dto.roomInfo}</p>
						<p>체크인
							{dateDto.start_date}&nbsp;{dto.checkInTime}&nbsp;|&nbsp;체크아웃
							{dateDto.end_date}&nbsp;{dto.checkOutTime}</p>
						<p>주 소</p>

						<p>총 지불 금액</p>
					</div>
 --%>
				</div>
				<br>

				<div class="card border-secondary mb-3" style="max-width: 100rem;">
					<div class="card-header">
						<h5>
							<i class="fa-solid fa-user"></i>&nbsp;이용자 정보&nbsp;
						</h5>
					</div>
					<div class="card-body text-secondary">
						<h5 class="card-title">이름</h5>
						<p class="card-text">
						<p>이용자 휴대폰 번호</p>
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





