<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
.body-container {
	max-width: 1500px;
}
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> ${companyName}: 객실관리 </h3>
			</div>
			
			<div class="body-main">
				<table class="table table-hover board-list">
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								 
								<td class="left">
									<a href="${articleUrl}&roomNum=${dto.roomNum}" class="text-reset">객실명:${dto.roomName}</a>
									
								</td>
								<td class="center">
								<a>인원수 :${dto.headCount}</a>
								</td>
							
								
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
				</div>

				<div class="row board-list-footer">
					<div class="col">
						<button type="button" class="btn" id="btn" onclick="location.href='${pageContext.request.contextPath}/room/list.do?companyNum=${companyNum}';">새로고침</button>
					</div>
					<div class="col text-end">
						<button type="button" class="btn" id="btn" onclick="location.href='${pageContext.request.contextPath}/room/write.do?companyNum=${companyNum}';">객실등록</button>
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