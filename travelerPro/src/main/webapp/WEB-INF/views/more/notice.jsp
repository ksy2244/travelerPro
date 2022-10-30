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
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 1500px;
}

.body-title {
	margin-top: 20px;
	margin-bottom: 40px;
} 

td {
	height: 100px;
}

.subject {
	font-size: 16px;
}

.date {
	color: #787878;
	font-size: 14px;
}

</style>

</head>
<body class="pt-5">

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
	
<main class="pt-5">
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> 공지사항 </h3>
			</div>
			
			<div class="body-main">
				<table class="table table-hover board-list">
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								<td class="text-start subject ps-5 pt-4">
									${dto.subject}
									<br><span class="date">${dto.reg_date}</span> 
									<c:if test="${dto.gap<1}"><span><img src="${pageContext.request.contextPath}/resources/images/new.png" style="width: 14px;"></span></c:if>
								</td>
								<td class="align-middle">
									<a href="${articleUrl}&noticeNum=${dto.noticeNum}" class="text-reset"><img src="${pageContext.request.contextPath}/resources/images/right2.png" style="width: 18px;"></a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 공지사항이 없습니다." : paging}
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