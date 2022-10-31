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

.title {
	border-bottom: 2px solid #B4CDE6;
	background: #B4CDE6;
}

.red {
	color: red;
	font-weight: bold;
	font-style: italic;
}

.blue {
	color: blue;
	font-weight: bold;
	font-style: italic;
}

.plus {
	font-size: 15px;
	color: #787878;
	margin-left: 320px; 
}

.paging {
	font-weight: bold; 
	font-size: 18px;
}

th {
	height: 60px;
	font-size: 15px;
}

td {
	height: 50px;
}

.number {
	width: 10%;
}

.cat {
	width: 15%;
}

.answer {
	width: 15%;
}

.day {
	width: 10%;
}

#data {
	font-size: 16px;
	font-weight: 600; 
}

.background {
	background: #CFF4FC;
}

.plus {
	width: 10%;
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
				<h3> 1:1 문의 </h3>
			</div>
			
			<div class="body-main">
		        <div class="row board-list-header">
		            <div class="col-auto me-auto" id="data">Total ${dataCount}건 (${page}/${total_page} 페이지)</div>
		            <div class="col-auto mb-3">&nbsp;</div>
		        </div>				
				
				<table class="table table-hover board-list">
					<thead class="background">
						<tr class="align-middle">
							<th class="number">문의번호</th>
							<th class="cat">카테고리</th>
							<th class="sub">제목</th>
							<th class="day">작성일</th>
							<th class="answer">상태</th>
							<th class="plus"></th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr class="align-middle">
								<td>${dataCount - (page-1) * size - status.index}</td>
																
								<c:if test ="${dto.categoryNum == 1}">
									<td>회원/개인정보</td>
								</c:if>
								<c:if test ="${dto.categoryNum == 2}">
									<td>쿠폰</td>
								</c:if>
								<c:if test ="${dto.categoryNum == 3}">
									<td>환불</td>
								</c:if>
								<c:if test ="${dto.categoryNum == 4}">
									<td>예약/결제</td>
								</c:if>
								
								<td class="left">
									${dto.subject}
								</td>
								
								<td>${dto.reg_date}</td>

								<c:if test="${dto.answer==0 }">
									<td class="red">답변대기</td>
								</c:if>
								
								<c:if test="${dto.answer==1 }">
									<td class="blue">답변완료</td>
								</c:if>
								
								<td class="align-middle">
									<a href="${articleUrl}&questionNum=${dto.questionNum}" class="text-reset"><img src="${pageContext.request.contextPath}/resources/images/right2.png" style="width: 18px;"></a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div class="page-navigation paging" >
					${dataCount == 0 ? "등록된 1:1 문의가 없습니다." : paging}
				</div>
				
				<span class="plus">${dataCount == 0? "TRAVELER는 회원님들의 소중한 의견에 귀기울여 
					신속하고 정확하게 답변드리도록 하겠습니다." : "" }</span>

				<div class="row board-list-footer">
					<div class="col text-end">
						<button type="button" class="btn btn-danger text-white" onclick="location.href='${pageContext.request.contextPath}/qna/write.do';">문의 작성</button>
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