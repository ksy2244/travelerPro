<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TRAVELER</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title2.png" />
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

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

.paging {
	font-weight: bold; 
	font-size: 18px;
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
			<div class="body-title">
				<h3> 쿠폰함 </h3>
			</div>
			
			<div class="body-main">
				<c:forEach var="dto" items="${list}">
					<table class="table table-hover board-list" id="table">
						<tbody>
								<tr>
									<td class="fw-bolder lh-lg fs-4">

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
									<td class="p-1 block fs-6">${dto.couponName}</td>
									<td class="p-0 block text_color">${dto.start_date} ~ ${dto.end_date}</td>
									<td class="p-2 block" id="searchDate">
										<c:choose>
											<c:when test="${dto.gap == 0}">
												쿠폰이 오늘 만료됩니다.
											</c:when>
											<c:otherwise>
												쿠폰이 ${dto.gap}일 남았습니다.
											</c:otherwise>
										</c:choose>
									</td>
									<td class="p-2 block detail"><a href="${articleUrl}&couponNum=${dto.couponNum}" class="text-reset text">쿠폰 상세 정보 보기 ></a></td>												
								</tr>
						</tbody>
					</table>
				</c:forEach>
				
				<div class="page-navigation paging">
					${dataCount == 0 ? "등록된 쿠폰이 없습니다." : paging}
				</div>

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