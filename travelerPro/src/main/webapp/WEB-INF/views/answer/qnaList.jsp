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

.basic {
	background-color: #F5EFE6;
}

.basic:hover{background-color:#D9D2CC;}

.title .qnum {
	width: 90px;
}

.title .sub {
	width: 30%;
}

.title .id {
	width: 15%;
}

.title .day {
	width: 15%;
}

.title .cat {
	width: 15%;
}

.content {
	font-style: italic;
	font-size: 15px;
}

.red {
	color: red;
}

.blue {
	color: blue;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header_admin.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> qna 관리 </h3>
			</div>
			
			<div class="body-main">
				<table class="table table-hover board-list">
					<thead>
							<tr class="title">
								<th class="qnum">문의번호</th>
								<th class="sub">제목</th>
								<th class="id">아이디</th>
								<th class="day">작성일</th>
								<th class="cat">카테고리</th>
								<th>답변여부</th>
							</tr>
					</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								<td class="qnum">${dataCount - (page-1) * size - status.index}</td>
								<td class="sub">
									<a href="${articleUrl}&questionNum=${dto.questionNum}" class="text-reset">${dto.subject}</a>
									<c:if test="${dto.gap<1}"><img src="${pageContext.request.contextPath}/resources/images/new.png" style="width: 14px;"></c:if>
								</td>
								<td class="id">${dto.userId}</td>
								<td class="day">${dto.reg_date}</td>
								<td class="cat content">
									<c:choose>
										<c:when test="${dto.categoryNum == 1}">
											회원/개인정보
										</c:when>
										<c:when test="${dto.categoryNum == 2}">
											쿠폰
										</c:when>
										<c:when test="${dto.categoryNum == 3}">
											환불
										</c:when>
										<c:otherwise>예약/결제</c:otherwise>
									</c:choose>
								</td>
								<c:if test="${dto.answer == 0}">
									<td class="red">미완료</td>
								</c:if>
								<c:if test="${dto.answer == 1}">
									<td class="blue">완료</td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 qna가 없습니다." : paging}
				</div>

				<div class="row board-list-footer">
					<div class="col">
						<button type="button" class="btn basic" onclick="location.href='${pageContext.request.contextPath}/notice/list.do';">새로고침</button>
					</div>
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