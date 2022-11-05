<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CEO</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
.body-container {
	max-width: 1500px;
}

.body-title {
	margin-top: 20px;
	margin-bottom: 50px;
}

#basic {
	background-color: #6C757D;
}

#basic:hover{background-color:#7689A5;}

.title {
	border-bottom: 2px solid #ced4da;
	background: #ced4da;
}

.page {
	margin-bottom: 20px;
}

#point {
	background-color: #FF5E00;
}

#point:hover{background-color:#FF9000;}

.red {
	color: red;
}

.blue {
	color: blue;
}
</style>
<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp" />
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>
	
<main>
	<div class="container mt-3">
		<div class="body-container">	
			<div class="body-title">
				<h3> 문의 리스트 </h3>
			</div>
			<div class="body-main">
		        <div class="row board-list-header">
		            <div class="col-auto me-auto page">
		            	${dataCount}개 (${page}/${total_page} 페이지)
		            </div>
		            <div class="col-auto">&nbsp;</div>
		        </div>				
				
				<table class="table table-hover board-list">
					<thead>
						<tr class="title">
							<th class="inquiryNum">번호</th>
							<th class="companyNum">업체번호</th>
							<th class="companyName">업체명</th>
							<th class="nickname">회원닉네임</th>
							<th class="reg_date">작성일</th>
							<th class="answhether">답변여부</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status"> 
							<tr>
								<td> ${dto.inquiryNum}</td>
								<td> ${dto.companyNum}</td>
								<td class="left">
									<a href="${articleUrl}&companyNum=${dto.companyNum}&inquiryNum=${dto.inquiryNum}" class="text-reset">${dto.companyName}</a>
								</td>
								<td>${dto.nickName}</td>
								<td>${dto.reg_date}</td>
								<c:choose>
									<c:when test="${dto.answhether==1 }">
										<td class="blue">완료</td>
									</c:when>
									<c:otherwise>
										<td class="red">대기</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 문의글이 없습니다." : paging}
				</div>

				<div class="row board-list-footer">
					<div class="col">
						<button type="button" class="btn text-white" id="basic" onclick="location.href='${pageContext.request.contextPath}/ceo/main.do';">새로고침</button>
					</div>
					<div class="col text-end">
						<button type="button" class="btn text-white" id="point" onclick="location.href='${pageContext.request.contextPath}/ceo/recognition.do';"><i class="fa-solid fa-shop-lock"></i>&nbsp;업체 등록</button>
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