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

#basic {
	background-color: #6C757D;
}
.title {
	border-bottom: 2px solid #ced4da;
	background: #ced4da;
}

.page {
	margin-bottom: 20px;
}
#basic:hover{background-color:#7689A5;}

#point {
	background-color: #FF5E00;
}

#point:hover{background-color:#FF9000;}


.png {
	width: 20px;
	height: 20px;
}
</style>
<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp" />
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3>  객실관리 </h3>
			</div>
			
			<div class="body-main">
				 <div class="row board-list-header">
		            
		            <div class="col-auto">&nbsp;</div>
		        </div>	
				<table class="table table-hover board-list">
						<thead>
							<tr class="title">
								<th class="roomName">객실명</th>
								<th class="roomInfo">객실정보</th>
								<th class ="headCount">인원수</th>
								
							</tr>
						</thead>
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								 
								<td class="left">
									<a href="${articleUrl}&roomNum=${dto.roomNum}" class="text-reset">${dto.roomName}</a>
									
								</td>
								
								<td class="left">
									<a >${dto.roomInfo}</a>
									
								</td>
								
								<td class="center">
								<a>${dto.headCount}</a>
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
						<button type="button" class="btn text-white" id="basic" onclick="location.href='${pageContext.request.contextPath}/room/list.do?companyNum=${companyNum}';">새로고침</button>
					</div>
					<div class="col text-end">
						<button type="button" class="btn text-white" id="point" onclick="location.href='${pageContext.request.contextPath}/room/write.do?companyNum=${companyNum}';">객실등록</button>
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