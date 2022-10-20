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
	href="../resources/style/reservation/reservationStyle.css"
	type="text/css">
<link rel="import" href="map.html">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<div class="body-title" style="text-align: center">
		<h5>
			<div class="col-auto me-auto">${dataCount}개(${page}/${total_page} 페이지)</div>
		</h5>

	</div>

	<main>
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<i class="fa-solid fa-hotel"></i>&nbsp; 숙박 업체 리스트
				</div>

				<div class="body-main">
					<div class="row board-list-header">
						<div class="col-auto me-auto">
							<p class="form-control-plaintext">
								${dataCount}개(${page}/${total_page} 페이지)</p>
						</div>							
					</div>

					<div class="row">
						<c:forEach var="dto" items="${list}" varStatus="status">
							<div class="col-md-4 col-lg-3 p-1 item">
								<div class="card-group" style="width: 1500px; margin: auto;">
									<div class="card" style="margin: 10px;"
										onclick="location.href='reservation/roomInfo.do?&companyNum=${dto.companyNum}'">
										<img
											src="${pageContext.request.contextPath}/resources/images/reservationImg/room.jpg"
											class="card-img-top">
										<div class="card-body">
											<h5 class="card-title">${dto.roomName}</h5>
											<p class="card-title">숙박업체 평점</p>
											<p class="card-title">숙박업체의 각 객실의 최소값으로 수정</p>
											<p class="card-title">허용 인원 ${dto.headCount}</p>

										</div>
									</div>
								</div>

							</div>
						</c:forEach>
					</div>

					<div class="page-navigation">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
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