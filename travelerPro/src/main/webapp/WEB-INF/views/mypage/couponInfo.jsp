<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>admin</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title.png" />
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 1500px;
}

.body-title {
	margin-top: 20px;
	margin-bottom: 50px;
}

#table {
	width: 400px;
	height: 140px;
	float: left;
	margin-left: 60px;
	margin-right: 10px;
	border: 1px solid #eee;
}

.block {
	display: block;
	border-bottom: none;
}

.basic {
	background-color: #6C757D;
}

.basic:hover{background-color:#7689A5;}

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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

</head>
<body class="pt-5">

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
	
<main class="pt-5">
	<div class="container">
		<div class="body-container">
			<br><br>
			<div class="body-main">
				<button type="button" class="btn text-white" onclick="location.href='${pageContext.request.contextPath}/mypage/coupon.do?${query}';"><img src="${pageContext.request.contextPath}/resources/images/left2.png" style="width: 18px;"></button>		
				<table class="table table-borderless">
					<tbody>
						<tr><td><br></td></tr>
						<tr>
							<td colspan="2" align="center" class="fw-bolder lh-lg fs-4">
								<c:if test="${dto.couponRate==0}">
									<div class="box top">
										<span class="text-reset text">${dto.couponPrice}</span>
										<span class="fs-6">원</span>
									</div>
								</c:if>
								<c:if test="${dto.couponPrice==0}">
									<div class="box top">
										<span class="text-reset text">${dto.couponRate}</span>
										<span class="fs-6">%</span>
									</div>
								</c:if>
							</td>
						</tr>
					</tbody>
					
					<tbody>
						<tr>
							<td class="p-1 block fs-5 fw-bold" align="center">${dto.couponName}</td>
							<td class="p-0 block text_color" align="center">${dto.start_date} ~ ${dto.end_date} |
								<c:choose>
									<c:when test="${dto.gap == 0}">
										<span id="searchDate">쿠폰이 오늘 만료됩니다.</span>
									</c:when>
									<c:otherwise>
										<span id="searchDate">쿠폰이 ${dto.gap}일 남았습니다.</span>
									</c:otherwise>
								</c:choose>
							</td>			
						</tr>
						<tr><td><br></td></tr>
						<tr>
							<td align="center" class="fs-6 text_color">${dto.content}</td>
						</tr>
						<tr>
							<td align="center" class="text_color">
							<c:if test="${dto.couponRate==0}">
									할인금액  <span class="fw-bold"> ${dto.couponPrice}원</span>
								</c:if>
								<c:if test="${dto.couponPrice==0}">
									할인율  <span class="fw-bold">${dto.couponRate}%</span>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>			
			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>