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

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board2.css"
	type="text/css">
</head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/reservation/reservationStyle.css"
	type="text/css">
	
<body class="pt-5">

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="pt-5">
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3>업체 찜</h3>
				</div>

				<div class="body-main mt-5">
					<div class="row">
						<c:forEach var="dto" items="${list}" varStatus="status">
							<h5 class="card-title date pt-4 ps-5">${dto.companyName}</h5>
								<hr class="pt-2">
								<div class="rnum ps-5"></div>
								<img src="${pageContext.request.contextPath}/uploads/ceo/${dto.imageFileName}"
									class="card-img-top ps-5 pt-4 img">
								
								<div class="body"> 
									<div class="company">${dto.companyInfo} </div>
									<div class="company">${dto.companyTel} </div>
								</div>	
						</c:forEach>


						</div>
				

					<div class="page-navigation paging">${dataPickCount == 0 ? "등록된 찜이 없습니다." : paging}
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