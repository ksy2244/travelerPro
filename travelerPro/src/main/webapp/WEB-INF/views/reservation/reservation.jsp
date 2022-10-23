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

<script type="text/javascript">
	function realUserOk() {
		const f = document.reservationForm;
		let str;

		str = f.realUserName.value;
		if (!/^[가-힣]{2,5}$/.test(str)) {
			alert("이름을 다시 입력하세요. ");
			f.realUserName.focus();
			return;
		}

		str = f.realUserTel.value;
		if (!str) {
			alert("전화번호를 입력하세요. ");
			f.realUserTel.focus();
			return;
		}

		f.action = "${pageContext.request.contextPath}/reservation/${mode}_ok.do";
		f.submit();
	}
</script>
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

				<div class="alert" role="alert" style="background: #E4FBFF">
					객실 예매를 위한 정보를 입력해주세요.</div>
				<c:forEach var="dto" items="${list}" varStatus="status">
					<div class="card border-secondary mb-3" style="max-width: 100rem; ">
						<div class="card-header">
							<h5>
								<i class="fa-solid fa-hotel"></i>&nbsp;${dto.companyName}&nbsp;
							</h5>
						</div>
						<div class="card-body text-secondary">
							<h5 class="card-title">객실 타입 ${dto.roomName}</h5>
							<p class="card-text">
							<p>${dto.roomInfo}</p>
							<p>체크인 {체크인 날짜} ${dto.checkInTime}&nbsp;|&nbsp;체크아웃 {체크아웃 날짜}
								${dto.checkOutTime}
						</div>

					</div>
					<br>

					<div class="card border-secondary mb-3" style="max-width: 100rem;">
						<div class="card-header">
							<h5>
								<i class="fa-solid fa-hotel"></i>&nbsp;결제 수단&nbsp;
							</h5>
						</div>
						<div class="card-body text-secondary">
							<h5 class="card-title">카카오 페이</h5>
							<p class="card-text">
						</div>
					</div>
					<br>




				</c:forEach>
				<div class="body-main">
					<form name="reservationForm" method="post">
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="realUserName">이용자
								이름</label>
							<div class="col-sm-10 userId-box">
								<div class="row">
									<div class="col-5 pe-1">
										<input type="text" name="realUserName" id="realUserName"
											class="form-control" value="${dto.realUserName}"
											${mode=="update" ? "readonly='readonly' ":""}
											placeholder="체크인시 필요한 이름입니다.">
									</div>
								</div>
								<c:if test="${mode=='reservation'}">
									<small class="form-control-plaintext help-block">이름은
										2~5자 이내이며, 한글만 가능합니다. </small>
								</c:if>
							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="realUserTel">이용자
								전화번호</label>
							<div class="col-sm-10">
								<input type="text" name="realUserTel" id="realUserTel"
									class="form-control" placeholder="체크인시 필요한 전화번호입니다.">
							</div>
						</div>
					</form>

					<div class="row mb-3">
						<div class="text-center">
							<button type="button" name="sendButton" class="btn"
								onclick="realUserOk();" style="background: #B8B5FF">
								${mode=="reservation"?"예약 ":""} <i class="bi bi-check2"></i> 예약
							</button>
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





