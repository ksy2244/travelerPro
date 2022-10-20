<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>coupon</title>
<jsp:include page="/WEB-INF/views/admin_layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_admin/css/board2.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_admin/css/coupon.css" type="text/css">
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/admin_layout/header.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> 쿠폰 관리 </h3>
			</div>
			
			<div class="body-main">
				<c:forEach var="dto" items="${list}">
				<table class="table table-hover board-list" id="table">
					<tbody>
							<tr>
								
								<td class="fst-italic lh-lg" id="coupon">${dto.couponName}</td>
								<td class="fst-italic fw-bolder lh-lg fs-2" id="coupon">
									<a href="${articleUrl}&couponNum=${dto.couponNum}" class="text-reset">${dto.couponPrice}원</a>
								</td>
								<td id="coupon">${dto.start_date} ~ ${dto.end_date}</td>
							</tr>
					</tbody>
				</table>
				</c:forEach>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
				</div>

				<div class="row board-list-footer">
					<div class="col">
						<button type="button" class="btn" id="btn" onclick="location.href='${pageContext.request.contextPath}/coupon/list.do';">새로고침</button>
					</div>
					<div class="col text-end">
						<button type="button" class="btn" id="btn" onclick="location.href='${pageContext.request.contextPath}/coupon/register.do';">쿠폰 등록</button>
					</div>
				</div>

			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/admin_layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin_layout/staticFooter.jsp"/>
</body>
</html>