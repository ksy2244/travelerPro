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
<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp"/>

<style type="text/css">
.body-container {
	max-width: 1000px;
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
	background-color: #F5EFE6;
}

.basic:hover{background-color:#D9D2CC;}

.form tr:first-child {
	border-top: 2px solid #3C2317;
}

.btn:hover {
	background-color: #D9D2CC;
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
<script type="text/javascript">
function deleteCoupon() {
	if(confirm("쿠폰을 삭제하시겠습니까 ? ")) {
		let query = "${query}&couponNum=${dto.couponNum}";
		let url = "${pageContext.request.contextPath}/coupon/delete.do?" + query;
	    location.href = url;
	}
}
</script>


</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header_admin.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> 쿠폰 상세정보 </h3>
			</div>
			
			<div class="body-main">			
				<table class="table table-borderless">
					<thead>
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
					</thead>
					
					<tbody>
						<tr>
							<td class="p-1 block fs-5 fw-bold" align="center">${dto.couponName}</td>
							<td class="p-0 block text_color" align="center">${dto.start_date} ~ ${dto.end_date} |
								<c:choose>
									<c:when test="${searchDate=='쿠폰 만료일까지 0일 남았습니다.'}">
										<span id="searchDate">쿠폰이 오늘 만료됩니다.</span>
									</c:when>
									<c:otherwise>
										<span id="searchDate">${searchDate}</span>
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
				
				<table class="table table-borderless">
					<tr>
						<td width="50%">
							<button type="button" class="btn basic"onclick="location.href='${pageContext.request.contextPath}/coupon/update.do?page=${page}&couponNum=${dto.couponNum}';">수정</button>
							<button type="button" class="btn basic"onclick="deleteCoupon();">삭제</button>
						</td>
						
						<td class="text-end">
							<button type="button" class="btn basic" onclick="location.href='${pageContext.request.contextPath}/coupon/list.do?${query}';">리스트</button>
						</td>
					</tr>
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