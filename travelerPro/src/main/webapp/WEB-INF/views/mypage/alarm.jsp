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

.body-title {
	margin-top: 20px;
	margin-bottom: 40px;
}

#table {
	width: 30%;
	height: 140px;
	float: left;
	margin-left: 20px;
	margin-right: 20px;
	margin-top: 25px;
	border: 1px solid #eee;
}

.block {
	display: block;
	border-bottom: none;
}

.basic {
	background-color: #6C757D;
}

.basic:hover {
	background-color: #7689A5;
}

.form tr:first-child {
	border-top: 2px solid #3C2317;
}

.trbold {
	border-bottom: 1px solid #3C2317;
}

.box {
	border: 2px solid #eee;
	height: 60px;
	width: 130px;
	border-right: 7px solid black;
	border-radius: 5px;
}

.text {
	padding-top: 35px;
}

.text_color {
	color: #787878;
}

#searchDate {
	color: red;
}

.detail {
	font-weight: bold;
	font-size: 12px;
	height: 47px;
}

.top {
	margin-top: 10px;
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board2.css"
	type="text/css">
</head>
<body class="pt-5">

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="pt-5">
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3>알림</h3>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="agree">약관 동의</label>
					<div class="col-sm-8" style="padding-top: 5px;">
						<input type="checkbox" id="agree" name="agree"
							class="form-check-input" checked="checked"
							style="margin-left: 0;"
							onchange="form.sendButton.disabled = !checked"> <label
							class="form-check-label"> <a href="#"
							class="text-decoration-none">이용약관</a>에 동의합니다.
						</label>
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