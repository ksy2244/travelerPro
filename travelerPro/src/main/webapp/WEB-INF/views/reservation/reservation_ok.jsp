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
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title2.png" />
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
.body-container {
	max-width: 1500px;
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

				<div class="row justify-content-md-center mt-5">
					<div class="col-md-8">
						<div class="border bg-light mt-5 p-4">
							<h4 class="text-center fw-bold">예약 성공</h4>
							<hr class="mt-4">

							<div class="d-grid p-3">
								<p class="text-center"></p>
							</div>

							
							<div class="d-grid">
								<button type="button"
									class=" btn btn-danger"
									onclick="location.href='${pageContext.request.contextPath}/mypage/myReservation.do'">나의
									예약 내역</button>
									<br>
						

								<button type="button"
									class="btn btn-outline-danger"
									onclick="location.href='${pageContext.request.contextPath}/main/main.do'">메인으로 돌아가기</button>
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