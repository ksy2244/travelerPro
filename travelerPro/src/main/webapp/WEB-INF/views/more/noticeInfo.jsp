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

.subject {
	font-size: 18px;
	font-weight: bold;
}

.date {
	color: #787878;
	font-size: 15px;
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
		<br><br>
		<div class="body-container">	
			<div class="body-main">
				<button type="button" class="btn text-white" onclick="location.href='${pageContext.request.contextPath}/more/notice.do?${query}';"><img src="${pageContext.request.contextPath}/resources/images/left2.png" style="width: 18px;"></button>
				<table class="table">
					<thead>
						<tr>
							<td colspan="2" align="center">
								<div class="subject pt-3">${dto.subject}</div>
							</td>
						</tr>
					</thead>		
					<tbody>
						<tr>
							<td align="right">
								<span class="date">${dto.reg_date}</span> 
								<c:if test="${dto.gap<1}"><span><img src="${pageContext.request.contextPath}/resources/images/new.png" style="width: 14px;"></span></c:if>
							</td>
						</tr>				
						<tr>
							<td colspan="2" valign="top" height="200" class="pt-5 pb-5 px-3">
								${dto.content}
							</td>
						</tr>				
						<tr>
							<td colspan="2">
								<img src="${pageContext.request.contextPath}/resources/images/disk.gif" style="width: 15px;">&nbsp;
								<c:if test="${not empty dto.saveFilename}">
									<a href="${pageContext.request.contextPath}/more/download.do?noticeNum=${dto.noticeNum}">${dto.originalFilename}</a>
									(<fmt:formatNumber value="${dto.fileSize/1024}" pattern="#,##0.00"/> kb)
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